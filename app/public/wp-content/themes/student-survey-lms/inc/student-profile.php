<?php
if ( ! defined( 'ABSPATH' ) ) { exit; }

function sslms_student_profile_page_url() {
    $page = get_page_by_path( 'student-profile' );
    return $page ? get_permalink( $page->ID ) : home_url( '/student-profile/' );
}

function sslms_student_profile_photo_url( $user_id = 0, $size = 'medium' ) {
    $user_id = $user_id ? absint( $user_id ) : get_current_user_id();
    $attachment_id = absint( get_user_meta( $user_id, '_sslms_profile_photo_id', true ) );
    if ( $attachment_id ) {
        $url = wp_get_attachment_image_url( $attachment_id, $size );
        if ( $url ) { return $url; }
    }
    $user = get_userdata( $user_id );
    return $user ? get_avatar_url( $user_id, array( 'size' => 240 ) ) : '';
}

function sslms_profile_value( $key, $user_id = 0 ) {
    $user_id = $user_id ? absint( $user_id ) : get_current_user_id();
    $user = get_userdata( $user_id );
    if ( ! $user ) { return ''; }
    $core = array( 'first_name', 'last_name', 'display_name', 'user_email' );
    if ( in_array( $key, $core, true ) ) {
        return isset( $user->{$key} ) ? $user->{$key} : '';
    }
    return get_user_meta( $user_id, '_sslms_profile_' . sanitize_key( $key ), true );
}

function sslms_student_profile_fields() {
    return array(
        'phone'                 => 'Phone number',
        'student_id'            => 'Student ID',
        'roll_number'           => 'Roll number',
        'program'               => 'Program / field of study',
        'level'                 => 'Year / level',
        'city'                  => 'City',
        'country'               => 'Country',
        'bio'                   => 'Short bio',
        'assigned_instructor_id' => 'Assigned instructor',
        'student_class'         => 'Class / group',
    );
}

function sslms_get_instructor_users() {
    return get_users( array(
        'role'     => 'instructor',
        'orderby'  => 'display_name',
        'order'    => 'ASC',
    ) );
}

function sslms_get_student_assignment( $user_id = 0 ) {
    $user_id = $user_id ? absint( $user_id ) : get_current_user_id();
    return array(
        'instructor_id' => absint( get_user_meta( $user_id, '_sslms_assigned_instructor_id', true ) ),
        'class'         => trim( (string) get_user_meta( $user_id, '_sslms_student_class', true ) ),
    );
}

function sslms_get_student_visible_survey_ids( $user_id = 0 ) {
    $user_id = $user_id ? absint( $user_id ) : get_current_user_id();
    $assignment = sslms_get_student_assignment( $user_id );

    if ( ! $assignment['instructor_id'] ) {
        return array();
    }

    $args = array(
        'post_type'      => 'survey',
        'post_status'    => 'publish',
        'posts_per_page' => -1,
        'fields'         => 'ids',
        'author'         => $assignment['instructor_id'],
    );

    if ( '' !== $assignment['class'] ) {
        $args['meta_query'] = array(
            'relation' => 'AND',
            array( 'key' => '_survey_class', 'value' => $assignment['class'], 'compare' => '=' ),
            array( 'relation' => 'OR', array( 'key' => '_survey_archived', 'compare' => 'NOT EXISTS' ), array( 'key' => '_survey_archived', 'value' => '1', 'compare' => '!=' ) ),
        );
    } else {
        $args['meta_query'] = array( 'relation' => 'OR', array( 'key' => '_survey_archived', 'compare' => 'NOT EXISTS' ), array( 'key' => '_survey_archived', 'value' => '1', 'compare' => '!=' ) );
    }

    return get_posts( $args );
}

function sslms_student_profile_snapshot( $user_id ) {
    $user = get_userdata( $user_id );
    if ( ! $user ) {
        return array();
    }

    $assignment = sslms_get_student_assignment( $user_id );
    $instructor = $assignment['instructor_id'] ? get_userdata( $assignment['instructor_id'] ) : false;

    return array(
        'user'          => $user,
        'photo'         => sslms_student_profile_photo_url( $user_id, 'medium' ),
        'instructor'    => $instructor,
        'class'         => $assignment['class'],
        'program'       => sslms_profile_value( 'program', $user_id ),
        'city'          => sslms_profile_value( 'city', $user_id ),
        'email'         => $user->user_email,
        'student_id'    => sslms_profile_value( 'student_id', $user_id ),
        'roll_number'   => sslms_profile_value( 'roll_number', $user_id ),
    );
}

function sslms_handle_student_profile() {
    if ( ! is_user_logged_in() || ! sslms_is_student() || empty( $_POST['sslms_profile_nonce'] ) ) { return ''; }
    $nonce = sanitize_text_field( wp_unslash( $_POST['sslms_profile_nonce'] ) );
    if ( ! wp_verify_nonce( $nonce, 'sslms_save_student_profile' ) ) { return 'error'; }

    $user_id = get_current_user_id();
    $first_name = sanitize_text_field( wp_unslash( $_POST['first_name'] ?? '' ) );
    $last_name  = sanitize_text_field( wp_unslash( $_POST['last_name'] ?? '' ) );
    $display_name = trim( $first_name . ' ' . $last_name );
    if ( '' === $display_name ) { $display_name = wp_get_current_user()->user_login; }

    wp_update_user( array(
        'ID'           => $user_id,
        'first_name'   => $first_name,
        'last_name'    => $last_name,
        'display_name' => $display_name,
    ) );

    if ( isset( $_POST['assigned_instructor_id'] ) ) {
        $instructor_id = absint( $_POST['assigned_instructor_id'] );
        $instructor = get_userdata( $instructor_id );
        if ( ! $instructor || ! in_array( 'instructor', (array) $instructor->roles, true ) ) {
            $instructor_id = 0;
        }
        update_user_meta( $user_id, '_sslms_assigned_instructor_id', $instructor_id );
    }

    if ( isset( $_POST['student_class'] ) ) {
        $student_class = sanitize_text_field( wp_unslash( $_POST['student_class'] ) );
        $available_classes = sslms_get_instructor_classes( absint( get_user_meta( $user_id, '_sslms_assigned_instructor_id', true ) ) );
        if ( $student_class && ! in_array( $student_class, $available_classes, true ) ) {
            $student_class = '';
        }
        update_user_meta( $user_id, '_sslms_student_class', $student_class );
    }

    foreach ( sslms_student_profile_fields() as $key => $label ) {
        if ( in_array( $key, array( 'assigned_instructor_id', 'student_class' ), true ) ) {
            continue;
        }
        $value = isset( $_POST[ $key ] ) ? wp_unslash( $_POST[ $key ] ) : '';
        $value = 'bio' === $key ? sanitize_textarea_field( $value ) : sanitize_text_field( $value );
        update_user_meta( $user_id, '_sslms_profile_' . $key, $value );
    }

    if ( ! empty( $_FILES['profile_photo']['name'] ) ) {
        require_once ABSPATH . 'wp-admin/includes/file.php';
        require_once ABSPATH . 'wp-admin/includes/media.php';
        require_once ABSPATH . 'wp-admin/includes/image.php';
        $attachment_id = media_handle_upload( 'profile_photo', 0, array(), array( 'test_form' => false ) );
        if ( ! is_wp_error( $attachment_id ) ) {
            update_user_meta( $user_id, '_sslms_profile_photo_id', absint( $attachment_id ) );
        }
    }

    return 'saved';
}

function sslms_profile_completeness( $user_id = 0 ) {
    $user_id = $user_id ? absint( $user_id ) : get_current_user_id();
    $checks = array(
        sslms_profile_value( 'first_name', $user_id ),
        sslms_profile_value( 'last_name', $user_id ),
        sslms_profile_value( 'phone', $user_id ),
        sslms_profile_value( 'student_id', $user_id ),
        sslms_profile_value( 'roll_number', $user_id ),
        sslms_profile_value( 'program', $user_id ),
        sslms_profile_value( 'level', $user_id ),
        sslms_profile_value( 'city', $user_id ),
        sslms_profile_value( 'country', $user_id ),
        sslms_profile_value( 'bio', $user_id ),
        get_user_meta( $user_id, '_sslms_profile_photo_id', true ),
    );
    $filled = count( array_filter( $checks, static function( $value ) { return '' !== trim( (string) $value ); } ) );
    return (int) round( ( $filled / count( $checks ) ) * 100 );
}
