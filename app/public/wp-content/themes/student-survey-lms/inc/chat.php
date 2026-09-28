<?php
if ( ! defined( 'ABSPATH' ) ) { exit; }

function sslms_register_chat_message_cpt() {
    register_post_type( 'sslms_chat_message', array(
        'labels'             => array( 'name' => 'Chat messages', 'singular_name' => 'Chat message' ),
        'public'             => false,
        'show_ui'            => false,
        'show_in_menu'       => false,
        'supports'           => array( 'title', 'editor', 'author' ),
        'capability_type'    => 'post',
        'map_meta_cap'       => true,
        'rewrite'            => false,
        'query_var'          => false,
    ) );
}
add_action( 'init', 'sslms_register_chat_message_cpt' );

function sslms_student_chat_url() {
    $page = get_page_by_path( 'student-chat' );
    return $page ? get_permalink( $page->ID ) : home_url( '/student-chat/' );
}

function sslms_instructor_admin_chat_url() {
    $page = get_page_by_path( 'instructor-admin-chat' );
    return $page ? get_permalink( $page->ID ) : home_url( '/instructor-admin-chat/' );
}

function sslms_is_chat_admin( $user_id = 0 ) {
    $user = $user_id ? get_userdata( absint( $user_id ) ) : wp_get_current_user();
    return $user && ( user_can( $user, 'manage_options' ) || in_array( 'administrator', (array) $user->roles, true ) );
}

function sslms_is_chat_instructor( $user_id = 0 ) {
    $user = $user_id ? get_userdata( absint( $user_id ) ) : wp_get_current_user();
    return $user && in_array( 'instructor', (array) $user->roles, true );
}

function sslms_chat_participants_are_valid( $type, $first_id, $second_id ) {
    if ( 'student_instructor' === $type ) {
        $student_id = sslms_is_student_user( $first_id ) ? $first_id : $second_id;
        $instructor_id = $student_id === $first_id ? $second_id : $first_id;
        $chosen_instructor_id = absint( get_user_meta( $student_id, '_sslms_chat_instructor_id', true ) );
        $assigned_instructor_id = absint( get_user_meta( $student_id, '_sslms_assigned_instructor_id', true ) );
        return sslms_is_student_user( $student_id ) && sslms_is_chat_instructor( $instructor_id ) && ( $chosen_instructor_id === absint( $instructor_id ) || ( ! $chosen_instructor_id && $assigned_instructor_id === absint( $instructor_id ) ) );
    }

    return 'instructor_admin' === $type && ( ( sslms_is_chat_instructor( $first_id ) && sslms_is_chat_admin( $second_id ) ) || ( sslms_is_chat_admin( $first_id ) && sslms_is_chat_instructor( $second_id ) ) );
}

function sslms_get_student_chat_instructor_id( $student_id = 0 ) {
    $student_id = $student_id ? absint( $student_id ) : get_current_user_id();
    return absint( get_user_meta( $student_id, '_sslms_chat_instructor_id', true ) ) ?: absint( get_user_meta( $student_id, '_sslms_assigned_instructor_id', true ) );
}

function sslms_get_chat_students_for_instructor( $instructor_id = 0 ) {
    $instructor_id = $instructor_id ? absint( $instructor_id ) : get_current_user_id();
    return get_users( array(
        'role'       => 'student',
        'orderby'    => 'display_name',
        'order'      => 'ASC',
        'meta_query' => array(
            'relation' => 'OR',
            array( 'key' => '_sslms_chat_instructor_id', 'value' => $instructor_id ),
            array( 'key' => '_sslms_assigned_instructor_id', 'value' => $instructor_id ),
        ),
    ) );
}

function sslms_is_student_user( $user_id ) {
    $user = get_userdata( absint( $user_id ) );
    return $user && in_array( 'student', (array) $user->roles, true );
}

function sslms_get_chat_messages( $type, $first_id, $second_id ) {
    $first_id = absint( $first_id );
    $second_id = absint( $second_id );
    if ( ! sslms_chat_participants_are_valid( $type, $first_id, $second_id ) ) { return array(); }

    return get_posts( array(
        'post_type'      => 'sslms_chat_message',
        'post_status'    => 'publish',
        'posts_per_page' => 100,
        'orderby'        => 'date',
        'order'          => 'ASC',
        'meta_query'     => array(
            'relation' => 'AND',
            array( 'key' => '_sslms_chat_type', 'value' => $type ),
            array(
                'relation' => 'OR',
                array( 'key' => '_sslms_chat_sender_id', 'value' => $first_id ),
                array( 'key' => '_sslms_chat_recipient_id', 'value' => $first_id ),
            ),
            array(
                'relation' => 'OR',
                array( 'key' => '_sslms_chat_sender_id', 'value' => $second_id ),
                array( 'key' => '_sslms_chat_recipient_id', 'value' => $second_id ),
            ),
        ),
    ) );
}

function sslms_save_chat_message( $type, $recipient_id, $nonce_action, $nonce_name ) {
    if ( ! is_user_logged_in() || empty( $_POST[ $nonce_name ] ) || ! wp_verify_nonce( sanitize_text_field( wp_unslash( $_POST[ $nonce_name ] ) ), $nonce_action ) ) { return 'error'; }
    $sender_id = get_current_user_id();
    $recipient_id = absint( $recipient_id );
    $message = sanitize_textarea_field( wp_unslash( $_POST['chat_message'] ?? '' ) );
    if ( '' === trim( $message ) || ! sslms_chat_participants_are_valid( $type, $sender_id, $recipient_id ) ) { return 'error'; }

    $message_id = wp_insert_post( array(
        'post_type'    => 'sslms_chat_message',
        'post_status'  => 'publish',
        'post_title'   => wp_trim_words( $message, 8, '...' ),
        'post_content' => $message,
        'post_author'  => $sender_id,
    ), true );
    if ( is_wp_error( $message_id ) ) { return 'error'; }
    update_post_meta( $message_id, '_sslms_chat_type', $type );
    update_post_meta( $message_id, '_sslms_chat_sender_id', $sender_id );
    update_post_meta( $message_id, '_sslms_chat_recipient_id', $recipient_id );
    return 'sent';
}

function sslms_handle_chat_actions( $type, $recipient_id, $nonce_action, $nonce_name ) {
    if ( ! is_user_logged_in() || empty( $_POST['sslms_chat_action'] ) || empty( $_POST[ $nonce_name ] ) ) { return ''; }
    if ( ! wp_verify_nonce( sanitize_text_field( wp_unslash( $_POST[ $nonce_name ] ) ), $nonce_action ) ) { return 'error'; }

    $message_id = absint( $_POST['chat_message_id'] ?? 0 );
    $message = get_post( $message_id );
    $recipient_id = absint( $recipient_id );
    if ( ! $message || 'sslms_chat_message' !== $message->post_type || (int) $message->post_author !== get_current_user_id() || ! sslms_chat_participants_are_valid( $type, get_current_user_id(), $recipient_id ) ) { return 'error'; }

    $action = sanitize_key( $_POST['sslms_chat_action'] );
    if ( 'delete' === $action ) {
        return wp_delete_post( $message_id, true ) ? 'deleted' : 'error';
    }
    if ( 'edit' === $action ) {
        $content = sanitize_textarea_field( wp_unslash( $_POST['chat_message'] ?? '' ) );
        if ( '' === trim( $content ) ) { return 'error'; }
        $updated = wp_update_post( array( 'ID' => $message_id, 'post_title' => wp_trim_words( $content, 8, '...' ), 'post_content' => $content ), true );
        return is_wp_error( $updated ) ? 'error' : 'edited';
    }
    return 'error';
}
