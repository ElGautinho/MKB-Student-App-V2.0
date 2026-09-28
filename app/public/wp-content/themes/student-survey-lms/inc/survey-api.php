<?php
if ( ! defined( 'ABSPATH' ) ) { exit; }

// Compatibility helpers retained for the original application.
function sslms_get_survey_questions( $survey_id ) {
    return get_posts( array(
        'post_type' => 'question',
        'meta_key' => '_question_parent_survey',
        'meta_value' => absint( $survey_id ),
        'orderby' => 'menu_order',
        'order' => 'ASC',
        'posts_per_page' => -1,
    ) );
}

function sslms_delete_survey_responses( $survey_id ) {
    $response_ids = get_posts( array(
        'post_type'      => 'response',
        'post_status'    => 'any',
        'posts_per_page' => -1,
        'fields'         => 'ids',
        'meta_key'       => '_response_survey_id',
        'meta_value'     => absint( $survey_id ),
    ) );

    foreach ( $response_ids as $response_id ) {
        wp_delete_post( $response_id, true );
    }
}

function sslms_remove_question_answers( $question_id, $survey_id = 0 ) {
    $survey_id = absint( $survey_id ?: get_post_meta( $question_id, '_question_parent_survey', true ) );
    if ( ! $survey_id ) { return; }

    $response_ids = get_posts( array(
        'post_type'      => 'response',
        'post_status'    => 'any',
        'posts_per_page' => -1,
        'fields'         => 'ids',
        'meta_key'       => '_response_survey_id',
        'meta_value'     => $survey_id,
    ) );

    foreach ( $response_ids as $response_id ) {
        $answers = get_post_meta( $response_id, '_response_answers', true );
        if ( ! is_array( $answers ) || ! array_key_exists( $question_id, $answers ) ) { continue; }
        unset( $answers[ $question_id ] );
        update_post_meta( $response_id, '_response_answers', $answers );
    }
}

function sslms_get_available_response_ids( $args = array() ) {
    $survey_ids = get_posts( array(
        'post_type'      => 'survey',
        'post_status'    => array( 'publish', 'draft', 'pending', 'private' ),
        'posts_per_page' => -1,
        'fields'         => 'ids',
    ) );

    if ( empty( $survey_ids ) ) { return array( 0 ); }

    $survey_query = array( 'key' => '_response_survey_id', 'value' => $survey_ids, 'compare' => 'IN' );
    $meta_query = array( $survey_query );
    if ( ! empty( $args['meta_query'] ) ) {
        $meta_query[] = $args['meta_query'];
    }
    unset( $args['meta_query'] );

    return get_posts( array_merge( array(
        'post_type'      => 'response',
        'post_status'    => 'publish',
        'posts_per_page' => -1,
        'fields'         => 'ids',
        'meta_query'     => array_merge( array( 'relation' => 'AND' ), $meta_query ),
    ), $args ) );
}

function sslms_cleanup_deleted_survey_content( $post_id ) {
    $post = get_post( $post_id );
    if ( ! $post ) { return; }

    if ( 'survey' === $post->post_type ) {
        sslms_delete_survey_responses( $post_id );
    } elseif ( 'question' === $post->post_type ) {
        sslms_remove_question_answers( $post_id );
    }
}
add_action( 'before_delete_post', 'sslms_cleanup_deleted_survey_content' );
add_action( 'trashed_post', 'sslms_cleanup_deleted_survey_content' );

function sslms_cleanup_orphaned_survey_data() {
    $survey_ids = get_posts( array(
        'post_type'      => 'survey',
        'post_status'    => array( 'publish', 'draft', 'pending', 'private' ),
        'posts_per_page' => -1,
        'fields'         => 'ids',
    ) );
    $survey_id_map = array_fill_keys( array_map( 'absint', $survey_ids ), true );
    $responses = get_posts( array(
        'post_type'      => 'response',
        'post_status'    => array( 'publish', 'draft', 'pending', 'private', 'future', 'trash' ),
        'posts_per_page' => -1,
    ) );

    foreach ( $responses as $response ) {
        $survey_id = absint( get_post_meta( $response->ID, '_response_survey_id', true ) );
        if ( empty( $survey_id_map[ $survey_id ] ) ) {
            wp_delete_post( $response->ID, true );
            continue;
        }

        $question_ids = wp_list_pluck( sslms_get_survey_questions( $survey_id ), 'ID' );
        $question_id_map = array_fill_keys( array_map( 'absint', $question_ids ), true );
        $answers = get_post_meta( $response->ID, '_response_answers', true );
        if ( ! is_array( $answers ) ) { continue; }

        $clean_answers = array_intersect_key( $answers, $question_id_map );
        if ( $clean_answers !== $answers ) {
            update_post_meta( $response->ID, '_response_answers', $clean_answers );
        }
    }
}
add_action( 'init', 'sslms_cleanup_orphaned_survey_data', 40 );

function sslms_get_student_response( $survey_id, $user_id ) {
    $survey_id = absint( $survey_id );
    $user_id   = absint( $user_id );

    if ( ! $survey_id || ! $user_id ) {
        return null;
    }

    $query = new WP_Query( array(
        'post_type'      => 'response',
        'post_status'    => 'publish',
        'author'         => $user_id,
        'posts_per_page' => 1,
        'orderby'        => 'date',
        'order'          => 'DESC',
        'meta_query'     => array(
            array(
                'key'     => '_response_survey_id',
                'value'   => $survey_id,
                'compare' => '=',
            ),
        ),
        'no_found_rows'  => true,
    ) );

    if ( ! $query->have_posts() ) {
        wp_reset_postdata();
        return null;
    }

    $response = $query->posts[0];
    wp_reset_postdata();
    return $response;
}
