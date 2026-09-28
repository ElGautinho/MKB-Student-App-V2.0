<?php
/**
 * Student Survey LMS - standalone theme.
 */

if ( ! defined( 'ABSPATH' ) ) { exit; }

// Keep WordPress-generated labels and theme screens in English.
add_filter( 'locale', function() {
    return 'en_US';
} );

function sslms_setup() {
    add_theme_support( 'title-tag' );
    add_theme_support( 'post-thumbnails' );
    add_theme_support( 'html5', array( 'search-form', 'comment-form', 'comment-list', 'gallery', 'caption', 'style', 'script' ) );
    register_nav_menus( array( 'primary' => __( 'Primary Menu', 'student-survey-lms' ) ) );
}
add_action( 'after_setup_theme', 'sslms_setup' );

function sslms_ensure_core_pages() {
    $pages = array(
        array(
            'title' => 'About',
            'slug' => 'about',
            'template' => 'page-about.php',
        ),
        array(
            'title' => 'Surveys',
            'slug' => 'survey',
            'template' => 'page-all-surveys.php',
        ),
        array(
            'title' => 'Student Dashboard',
            'slug' => 'student-dashboard',
            'template' => 'page-student-dashboard.php',
        ),
        array(
            'title' => 'My Answers',
            'slug' => 'my-completed-surveys',
            'template' => 'page-my-surveys.php',
        ),
        array(
            'title' => 'My Feedback',
            'slug' => 'my-feedback',
            'template' => 'page-my-feedback.php',
        ),
        array(
            'title' => 'Student Profile',
            'slug' => 'student-profile',
            'template' => 'page-student-profile.php',
        ),
        array(
            'title' => 'Instructor Dashboard',
            'slug' => 'instructor-dashboard',
            'template' => 'page-instructor-dashboard.php',
        ),
        array(
            'title' => 'Instructor Profile',
            'slug' => 'instructor-profile',
            'template' => 'page-instructor-profile.php',
        ),
        array(
            'title' => 'Student Chat',
            'slug' => 'student-chat',
            'template' => 'page-student-chat.php',
        ),
        array(
            'title' => 'Instructor Admin Chat',
            'slug' => 'instructor-admin-chat',
            'template' => 'page-instructor-admin-chat.php',
        ),
    );

    foreach ( $pages as $page ) {
        $existing = get_page_by_path( $page['slug'] );
        if ( ! $existing ) {
            $page_id = wp_insert_post( array(
                'post_title'   => $page['title'],
                'post_name'    => $page['slug'],
                'post_status'  => 'publish',
                'post_type'    => 'page',
                'post_content' => '',
            ) );
            if ( $page_id && ! is_wp_error( $page_id ) ) {
                update_post_meta( $page_id, '_wp_page_template', $page['template'] );
            }
        } else {
            wp_update_post( array( 'ID' => $existing->ID, 'post_status' => 'publish' ) );
            if ( $page['template'] !== get_post_meta( $existing->ID, '_wp_page_template', true ) ) {
                update_post_meta( $existing->ID, '_wp_page_template', $page['template'] );
            }
        }
    }

    flush_rewrite_rules();
}

function sslms_activate() {
    sslms_ensure_core_pages();
}
function sslms_deactivate() {
    flush_rewrite_rules();
}
register_activation_hook( __FILE__, 'sslms_activate' );

// Ensure the core student pages exist and stay connected to the correct templates.
add_action( 'init', 'sslms_ensure_core_pages', 30 );
register_deactivation_hook( __FILE__, 'sslms_deactivate' );

function sslms_enqueue_assets() {
    wp_enqueue_style( 'sslms-style', get_stylesheet_uri(), array(), '3.8.0' );
    wp_enqueue_script( 'sslms-app', get_template_directory_uri() . '/assets/js/app.js', array(), '3.9.0', true );
}
add_action( 'wp_enqueue_scripts', 'sslms_enqueue_assets' );

// Keep survey cover images available even when the original project's MU plugin registers the CPT.
add_action( 'init', function() {
    if ( post_type_exists( 'survey' ) ) {
        add_post_type_support( 'survey', 'thumbnail' );
    }
}, 20 );

function sslms_user_has_role( $roles ) {
    if ( ! is_user_logged_in() ) { return false; }
    $roles = (array) $roles;
    $user = wp_get_current_user();
    return (bool) array_intersect( $roles, (array) $user->roles );
}

function sslms_is_student() { return sslms_user_has_role( 'student' ); }
function sslms_is_instructor() { return sslms_user_has_role( array( 'instructor', 'administrator' ) ); }

function sslms_site_name() { return 'MKB Student Survey'; }
add_filter( 'pre_get_document_title', function( $title ) { return ( is_front_page() || is_home() ) ? sslms_site_name() : $title; } );

function sslms_dashboard_image_url() {
    return get_template_directory_uri() . '/assets/img-modern-computer-lab-students.jpg';
}

function sslms_image_url( $index = 0 ) {
    // African student imagery selected for the LMS visual identity.
    // These are Pexels images; the Pexels pages can also be edited in Canva.
    $images = array(
        'https://images.pexels.com/photos/36830932/pexels-photo-36830932.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1400&h=900',
        'https://images.pexels.com/photos/34162714/pexels-photo-34162714.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1400&h=900',
        'https://images.pexels.com/photos/5940830/pexels-photo-5940830.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1400&h=900',
        'https://images.pexels.com/photos/35129514/pexels-photo-35129514.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1400&h=900',
        'https://images.pexels.com/photos/11025018/pexels-photo-11025018.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1400&h=900',
    );
    return $images[ absint( $index ) % count( $images ) ];
}

// The CPT modules are bundled so this theme can run on its own. If the original
// project MU plugins are still active, they take precedence and are not loaded twice.
if ( ! function_exists( 'register_survey_cpt' ) ) {
    require_once get_template_directory() . '/inc/custom-post-type-surveys.php';
}
if ( ! function_exists( 'register_question_cpt' ) ) {
    require_once get_template_directory() . '/inc/custom-post-type-questions.php';
}

require_once get_template_directory() . '/inc/roles.php';
require_once get_template_directory() . '/inc/auth-redirect.php';
require_once get_template_directory() . '/inc/dynamic-menu.php';
require_once get_template_directory() . '/inc/survey-responses-admin.php';
require_once get_template_directory() . '/inc/survey-api.php';
require_once get_template_directory() . '/inc/student-profile.php';
require_once get_template_directory() . '/inc/instructor.php';
require_once get_template_directory() . '/inc/chat.php';
require_once get_template_directory() . '/inc/notifications.php';


/* ============================================================
 * MKB Student LMS v3.8.0
 * Student profile + submitted survey archive
 * ============================================================ */

/**
 * Register profile/archive pages when the theme is activated.
 */
function sslms_create_profile_pages() {
    $pages = array(
        array(
            'title' => 'My Profile',
            'slug' => 'my-profile',
            'template' => 'page-my-profile.php',
        ),
        array(
            'title' => 'My Survey Archive',
            'slug' => 'my-survey-archive',
            'template' => 'page-my-survey-archive.php',
        ),
    );

    foreach ( $pages as $page ) {
        $existing = get_page_by_path( $page['slug'] );
        if ( ! $existing ) {
            $id = wp_insert_post( array(
                'post_title'   => $page['title'],
                'post_name'    => $page['slug'],
                'post_status'  => 'publish',
                'post_type'    => 'page',
            ) );
            if ( $id && ! is_wp_error( $id ) ) {
                update_post_meta( $id, '_wp_page_template', $page['template'] );
            }
        } elseif ( ! get_post_meta( $existing->ID, '_wp_page_template', true ) ) {
            update_post_meta( $existing->ID, '_wp_page_template', $page['template'] );
        }
    }
}
add_action( 'after_switch_theme', 'sslms_create_profile_pages' );

/**
 * Save student profile fields.
 */
function sslms_save_student_profile() {
    if ( ! is_user_logged_in() || ! isset( $_POST['sslms_profile_nonce'] ) ) {
        return;
    }

    if ( ! wp_verify_nonce( sanitize_text_field( wp_unslash( $_POST['sslms_profile_nonce'] ) ), 'sslms_save_profile' ) ) {
        return;
    }

    $user_id = get_current_user_id();

    $fields = array(
        'first_name' => 'first_name',
        'last_name' => 'last_name',
        'phone' => 'description_phone',
        'country' => 'description_country',
        'city' => 'description_city',
        'institution' => 'description_institution',
        'program' => 'description_program',
        'bio' => 'description_bio',
    );

    if ( isset( $_POST['first_name'] ) ) {
        update_user_meta( $user_id, 'first_name', sanitize_text_field( wp_unslash( $_POST['first_name'] ) ) );
    }
    if ( isset( $_POST['last_name'] ) ) {
        update_user_meta( $user_id, 'last_name', sanitize_text_field( wp_unslash( $_POST['last_name'] ) ) );
    }

    foreach ( $fields as $post_key => $meta_key ) {
        if ( isset( $_POST[ $post_key ] ) ) {
            $value = 'bio' === $post_key
                ? sanitize_textarea_field( wp_unslash( $_POST[ $post_key ] ) )
                : sanitize_text_field( wp_unslash( $_POST[ $post_key ] ) );
            update_user_meta( $user_id, $meta_key, $value );
        }
    }

    if ( ! empty( $_FILES['profile_photo']['name'] ) ) {
        require_once ABSPATH . 'wp-admin/includes/file.php';
        require_once ABSPATH . 'wp-admin/includes/media.php';
        require_once ABSPATH . 'wp-admin/includes/image.php';

        $attachment_id = media_handle_upload( 'profile_photo', 0 );
        if ( ! is_wp_error( $attachment_id ) ) {
            update_user_meta( $user_id, 'sslms_profile_photo_id', absint( $attachment_id ) );
        }
    }

    wp_safe_redirect( add_query_arg( 'profile_updated', '1', wp_get_referer() ? wp_get_referer() : home_url( '/my-profile/' ) ) );
    exit;
}
add_action( 'template_redirect', 'sslms_save_student_profile' );

/**
 * Limit profile/archive pages to authenticated users.
 */
function sslms_protect_student_pages() {
    if ( is_page( array( 'my-profile', 'my-survey-archive' ) ) && ! is_user_logged_in() ) {
        auth_redirect();
    }
}
add_action( 'template_redirect', 'sslms_protect_student_pages' );

/**
 * Make sure only the logged-in student's own responses are queried.
 */
function sslms_get_student_responses_paginated( $user_id, $paged = 1, $per_page = 4 ) {
    $user_id = absint( $user_id );
    $paged = max( 1, absint( $paged ) );
    $per_page = max( 1, absint( $per_page ) );

    if ( ! $user_id ) {
        return new WP_Query( array( 'post__in' => array( 0 ) ) );
    }

    $available_survey_ids = get_posts( array(
        'post_type'      => 'survey',
        'post_status'    => array( 'publish', 'draft', 'pending', 'private' ),
        'posts_per_page' => -1,
        'fields'         => 'ids',
    ) );

    if ( empty( $available_survey_ids ) ) {
        return new WP_Query( array( 'post__in' => array( 0 ) ) );
    }

    return new WP_Query( array(
        'post_type'      => 'response',
        'post_status'    => 'publish',
        'author'         => $user_id,
        'post__in'       => get_posts( array(
            'post_type'      => 'response',
            'post_status'    => 'publish',
            'author'         => $user_id,
            'posts_per_page' => -1,
            'fields'         => 'ids',
            'meta_query'     => array( array( 'key' => '_response_survey_id', 'value' => $available_survey_ids, 'compare' => 'IN' ) ),
        ) ),
        'posts_per_page' => $per_page,
        'paged'          => $paged,
        'orderby'        => 'date',
        'order'          => 'DESC',
        'no_found_rows'  => false,
    ) );
}

/**
 * Add student-only links to the primary navigation when logged in.
 */
function sslms_add_student_nav_links( $items, $args ) {
    if ( ! is_user_logged_in() ) {
        return $items;
    }

    if ( isset( $args->theme_location ) && 'primary' === $args->theme_location ) {
        $profile_url = home_url( '/my-profile/' );
        $archive_url = home_url( '/my-survey-archive/' );
        $items .= '<li class="menu-item menu-item-student-profile"><a href="' . esc_url( $profile_url ) . '">Profile</a></li>';
        $items .= '<li class="menu-item menu-item-survey-archive"><a href="' . esc_url( $archive_url ) . '">My Surveys</a></li>';
    }

    return $items;
}
add_filter( 'wp_nav_menu_items', 'sslms_add_student_nav_links', 20, 2 );
