<?php
if ( ! defined( 'ABSPATH' ) ) { exit; }

function sslms_instructor_dashboard_url() {
    $page = get_page_by_path( 'instructor-dashboard' );
    return $page ? get_permalink( $page->ID ) : home_url( '/instructor-dashboard/' );
}

function sslms_instructor_profile_url() {
    $page = get_page_by_path( 'instructor-profile' );
    return $page ? get_permalink( $page->ID ) : home_url( '/instructor-profile/' );
}

function sslms_instructor_can_manage_survey( $survey_id ) {
    $survey = get_post( absint( $survey_id ) );
    if ( ! $survey || 'survey' !== $survey->post_type ) { return false; }
    return current_user_can( 'manage_options' ) || ( sslms_is_instructor() && (int) $survey->post_author === get_current_user_id() );
}

function sslms_get_instructor_classes( $instructor_id = 0 ) {
    $instructor_id = $instructor_id ? absint( $instructor_id ) : get_current_user_id();
    $surveys = get_posts( array( 'post_type' => 'survey', 'post_status' => array( 'publish', 'draft', 'pending', 'private' ), 'author' => $instructor_id, 'posts_per_page' => -1 ) );
    $classes = array();
    foreach ( $surveys as $survey ) {
        $class = trim( (string) get_post_meta( $survey->ID, '_survey_class', true ) );
        if ( $class ) { $classes[] = $class; }
    }
    $classes = array_values( array_unique( $classes ) );
    natcasesort( $classes );
    return array_values( $classes );
}

function sslms_instructor_handle_actions() {
    if ( ! is_user_logged_in() || ! sslms_is_instructor() || empty( $_POST['sslms_instructor_nonce'] ) ) { return ''; }
    if ( ! wp_verify_nonce( sanitize_text_field( wp_unslash( $_POST['sslms_instructor_nonce'] ) ), 'sslms_instructor_actions' ) ) { return 'error'; }

    $action = sanitize_key( $_POST['instructor_action'] ?? '' );
    if ( 'save_survey' === $action ) {
        $survey_id = absint( $_POST['survey_id'] ?? 0 );
        if ( $survey_id && ! sslms_instructor_can_manage_survey( $survey_id ) ) { return 'error'; }
        $data = array(
            'post_type' => 'survey',
            'post_title' => sanitize_text_field( wp_unslash( $_POST['survey_title'] ?? '' ) ),
            'post_content' => sanitize_textarea_field( wp_unslash( $_POST['survey_content'] ?? '' ) ),
            'post_status' => in_array( $_POST['survey_status'] ?? 'draft', array( 'publish', 'draft' ), true ) ? sanitize_key( $_POST['survey_status'] ) : 'draft',
        );
        if ( '' === $data['post_title'] ) { return 'error'; }
        if ( $survey_id ) { $data['ID'] = $survey_id; $saved_id = wp_update_post( $data, true ); }
        else { $data['post_author'] = get_current_user_id(); $saved_id = wp_insert_post( $data, true ); }
        if ( is_wp_error( $saved_id ) ) { return 'error'; }
        update_post_meta( $saved_id, '_survey_description', sanitize_textarea_field( wp_unslash( $_POST['survey_description'] ?? '' ) ) );
        update_post_meta( $saved_id, '_survey_class', sanitize_text_field( wp_unslash( $_POST['survey_class'] ?? '' ) ) );
        update_post_meta( $saved_id, '_survey_start_date', sanitize_text_field( wp_unslash( $_POST['survey_start_date'] ?? '' ) ) );
        update_post_meta( $saved_id, '_survey_end_date', sanitize_text_field( wp_unslash( $_POST['survey_end_date'] ?? '' ) ) );
        if ( ! $survey_id ) { delete_post_meta( $saved_id, '_survey_archived' ); }
        return 'saved';
    }

    if ( 'toggle_archive_survey' === $action ) {
        $survey_id = absint( $_POST['survey_id'] ?? 0 );
        if ( ! sslms_instructor_can_manage_survey( $survey_id ) ) { return 'error'; }
        if ( '1' === get_post_meta( $survey_id, '_survey_archived', true ) ) {
            delete_post_meta( $survey_id, '_survey_archived' );
            return 'unarchived';
        }
        update_post_meta( $survey_id, '_survey_archived', '1' );
        return 'archived';
    }

    if ( 'delete_survey' === $action ) {
        $survey_id = absint( $_POST['survey_id'] ?? 0 );
        if ( ! sslms_instructor_can_manage_survey( $survey_id ) ) { return 'error'; }
        foreach ( sslms_get_survey_questions( $survey_id ) as $question ) { wp_delete_post( $question->ID, true ); }
        return wp_delete_post( $survey_id, true ) ? 'deleted' : 'error';
    }

    if ( 'save_question' === $action ) {
        $survey_id = absint( $_POST['question_survey_id'] ?? 0 );
        $question_id = absint( $_POST['question_id'] ?? 0 );
        if ( ! sslms_instructor_can_manage_survey( $survey_id ) ) { return 'error'; }
        if ( $question_id && ! in_array( $question_id, array_map( 'absint', wp_list_pluck( sslms_get_survey_questions( $survey_id ), 'ID' ) ), true ) ) { return 'error'; }
        $data = array( 'post_type' => 'question', 'post_title' => sanitize_text_field( wp_unslash( $_POST['question_title'] ?? '' ) ), 'post_status' => 'publish' );
        if ( '' === $data['post_title'] ) { return 'error'; }
        if ( $question_id ) { $data['ID'] = $question_id; $saved_id = wp_update_post( $data, true ); }
        else { $data['post_author'] = get_current_user_id(); $saved_id = wp_insert_post( $data, true ); }
        if ( is_wp_error( $saved_id ) ) { return 'error'; }
        update_post_meta( $saved_id, '_question_parent_survey', $survey_id );
        update_post_meta( $saved_id, '_question_type', sanitize_key( $_POST['question_type'] ?? 'text' ) );
        update_post_meta( $saved_id, '_question_answer_options', sanitize_textarea_field( wp_unslash( $_POST['question_options'] ?? '' ) ) );
        if ( ! empty( $_POST['question_required'] ) ) { update_post_meta( $saved_id, '_question_required', '1' ); } else { delete_post_meta( $saved_id, '_question_required' ); }
        return 'saved';
    }

    if ( 'delete_question' === $action ) {
        $question_id = absint( $_POST['question_id'] ?? 0 );
        $survey_id = absint( get_post_meta( $question_id, '_question_parent_survey', true ) );
        return ( $question_id && sslms_instructor_can_manage_survey( $survey_id ) && wp_delete_post( $question_id, true ) ) ? 'deleted' : 'error';
    }

    if ( 'save_feedback' === $action ) {
        $response_id = absint( $_POST['response_id'] ?? 0 );
        $survey_id = absint( get_post_meta( $response_id, '_response_survey_id', true ) );
        if ( ! $response_id || ! sslms_instructor_can_manage_survey( $survey_id ) ) { return 'error'; }
        $feedback = sanitize_textarea_field( wp_unslash( $_POST['response_feedback'] ?? '' ) );
        if ( '' === trim( $feedback ) ) {
            delete_post_meta( $response_id, '_response_feedback' );
        } else {
            update_post_meta( $response_id, '_response_feedback', $feedback );
        }
        return 'feedback_saved';
    }

    if ( 'delete_feedback' === $action ) {
        $response_id = absint( $_POST['response_id'] ?? 0 );
        $survey_id = absint( get_post_meta( $response_id, '_response_survey_id', true ) );
        if ( ! $response_id || ! sslms_instructor_can_manage_survey( $survey_id ) ) { return 'error'; }
        delete_post_meta( $response_id, '_response_feedback' );
        return 'feedback_saved';
    }

    return 'error';
}

function sslms_handle_instructor_profile() {
    if ( ! is_user_logged_in() || ! sslms_is_instructor() || empty( $_POST['sslms_instructor_profile_nonce'] ) ) { return ''; }
    if ( ! wp_verify_nonce( sanitize_text_field( wp_unslash( $_POST['sslms_instructor_profile_nonce'] ) ), 'sslms_save_instructor_profile' ) ) { return 'error'; }
    $user_id = get_current_user_id();
    $first = sanitize_text_field( wp_unslash( $_POST['first_name'] ?? '' ) );
    $last = sanitize_text_field( wp_unslash( $_POST['last_name'] ?? '' ) );
    wp_update_user( array( 'ID' => $user_id, 'first_name' => $first, 'last_name' => $last, 'display_name' => trim( $first . ' ' . $last ) ?: wp_get_current_user()->user_login ) );
    foreach ( array( 'phone', 'country', 'city', 'institution', 'program' ) as $key ) { update_user_meta( $user_id, '_sslms_profile_' . $key, sanitize_text_field( wp_unslash( $_POST[ $key ] ?? '' ) ) ); }
    update_user_meta( $user_id, '_sslms_profile_bio', sanitize_textarea_field( wp_unslash( $_POST['bio'] ?? '' ) ) );
    if ( ! empty( $_FILES['profile_photo']['name'] ) ) {
        require_once ABSPATH . 'wp-admin/includes/file.php';
        require_once ABSPATH . 'wp-admin/includes/media.php';
        require_once ABSPATH . 'wp-admin/includes/image.php';
        $attachment_id = media_handle_upload( 'profile_photo', 0, array(), array( 'test_form' => false ) );
        if ( ! is_wp_error( $attachment_id ) ) { update_user_meta( $user_id, '_sslms_profile_photo_id', absint( $attachment_id ) ); }
    }
    return 'saved';
}
