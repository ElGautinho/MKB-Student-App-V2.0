<?php
if ( ! defined( 'ABSPATH' ) ) { exit; }

add_filter( 'login_redirect', function( $redirect_to, $request, $user ) {
    if ( $user instanceof WP_User && ! empty( $user->roles ) ) {
        if ( in_array( 'administrator', $user->roles, true ) ) { return admin_url(); }
        if ( in_array( 'instructor', $user->roles, true ) ) { return sslms_instructor_dashboard_url(); }
        if ( in_array( 'student', $user->roles, true ) ) { return home_url( '/' ); }
    }
    return $redirect_to;
}, 10, 3 );

function sslms_direct_logout_url( $redirect_to = '' ) {
    return add_query_arg(
        array(
            'sslms_logout' => '1',
            '_wpnonce'     => wp_create_nonce( 'sslms_logout' ),
            'redirect_to'  => $redirect_to ? $redirect_to : home_url( '/' ),
        ),
        home_url( '/' )
    );
}

add_action( 'template_redirect', function() {
    if ( empty( $_GET['sslms_logout'] ) || '1' !== $_GET['sslms_logout'] ) { return; }
    $nonce = sanitize_text_field( wp_unslash( $_GET['_wpnonce'] ?? '' ) );
    if ( ! wp_verify_nonce( $nonce, 'sslms_logout' ) ) { return; }
    $redirect_to = esc_url_raw( wp_unslash( $_GET['redirect_to'] ?? home_url( '/' ) ) );
    wp_logout();
    wp_safe_redirect( wp_validate_redirect( $redirect_to, home_url( '/' ) ) );
    exit;
});

add_action( 'wp_logout', function() {
    wp_safe_redirect( home_url( '/' ) );
    exit;
});

add_filter( 'show_admin_bar', function( $show ) {
    if ( sslms_user_has_role( 'student' ) ) { return false; }
    return $show;
});

add_action( 'admin_init', function() {
    if ( ! is_admin() || defined( 'DOING_AJAX' ) ) { return; }
    if ( sslms_user_has_role( array( 'student', 'instructor' ) ) ) {
        wp_safe_redirect( home_url( '/' ) ); exit;
    }
});

add_action( 'template_redirect', function() {
    $user_roles = is_user_logged_in() ? (array) wp_get_current_user()->roles : array();
    if ( is_page( 'admin-only' ) && ! in_array( 'administrator', $user_roles, true ) ) {
        wp_safe_redirect( home_url( '/' ) ); exit;
    }
    if ( is_page( 'instructor-only' ) && ! in_array( 'instructor', $user_roles, true ) ) {
        wp_safe_redirect( home_url( '/' ) ); exit;
    }
    if ( is_page( 'student-only' ) && ! in_array( 'student', $user_roles, true ) ) {
        wp_safe_redirect( home_url( '/' ) ); exit;
    }
});
