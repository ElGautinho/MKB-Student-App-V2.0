<?php
if ( ! defined( 'ABSPATH' ) ) { exit; }

add_shortcode( 'dynamic_main_menu', function() {
    $items = array();
    $home_page = get_pages( array( 'meta_key' => '_wp_page_template', 'meta_value' => 'page-home-context.php', 'post_status' => 'publish', 'number' => 1 ) );
    $about_page = get_pages( array( 'meta_key' => '_wp_page_template', 'meta_value' => 'page-about.php', 'post_status' => 'publish', 'number' => 1 ) );

    $items[] = '<a href="' . esc_url( ! empty( $home_page ) ? get_permalink( $home_page[0]->ID ) : home_url( '/' ) ) . '">Home</a>';
    $items[] = '<a href="' . esc_url( ! empty( $about_page ) ? get_permalink( $about_page[0]->ID ) : home_url( '/about/' ) ) . '">About</a>';

    if ( sslms_is_student() ) {
        $survey_url = home_url( '/survey/' );
        $survey_active = is_post_type_archive( 'survey' ) || is_singular( 'survey' ) || is_page( get_page_by_path( 'survey' ) ) ? ' class="is-active" aria-current="page"' : '';
        $survey_children = '<a href="' . esc_url( $survey_url ) . '"' . ( is_page( get_page_by_path( 'survey' ) ) ? ' class="is-active" aria-current="page"' : '' ) . '>Browse surveys</a>';
        $my_page = get_pages( array( 'meta_key' => '_wp_page_template', 'meta_value' => 'page-my-surveys.php', 'post_status' => 'publish', 'number' => 1 ) );
        $my_page_obj = ! empty( $my_page ) ? $my_page[0] : get_page_by_path( 'my-completed-surveys' );
        if ( $my_page_obj && 'publish' === get_post_status( $my_page_obj->ID ) ) {
            $my_url = get_permalink( $my_page_obj->ID );
            $active = is_page( $my_page_obj->ID ) ? ' class="is-active" aria-current="page"' : '';
            if ( $active ) { $survey_active = ' class="is-active" aria-current="page"'; }
            $survey_children .= '<a href="' . esc_url( $my_url ) . '"' . $active . '>My Answers</a>';
        }
        $feedback_page = get_pages( array( 'meta_key' => '_wp_page_template', 'meta_value' => 'page-my-feedback.php', 'post_status' => 'publish', 'number' => 1 ) );
        $feedback_page_obj = ! empty( $feedback_page ) ? $feedback_page[0] : get_page_by_path( 'my-feedback' );
        if ( $feedback_page_obj && 'publish' === get_post_status( $feedback_page_obj->ID ) ) {
            $feedback_url = get_permalink( $feedback_page_obj->ID );
            $feedback_active = is_page( $feedback_page_obj->ID ) ? ' class="is-active" aria-current="page"' : '';
            if ( $feedback_active ) { $survey_active = ' class="is-active" aria-current="page"'; }
            $survey_children .= '<a href="' . esc_url( $feedback_url ) . '"' . $feedback_active . '>My Feedback</a>';
        }
        $items[] = '<div class="dynamic-menu-dropdown"><a href="#"' . $survey_active . ' aria-haspopup="true">Surveys</a><div class="dynamic-menu-dropdown-content">' . $survey_children . '</div></div>';
    }

    if ( ! is_user_logged_in() ) {
        $items[] = '<div class="dynamic-menu-dropdown"><a href="#">Account</a><div class="dynamic-menu-dropdown-content">'
            . '<a href="' . esc_url( wp_login_url() ) . '">Sign in</a>'
            . '<a href="' . esc_url( wp_registration_url() ) . '">Register</a>'
            . '</div></div>';
    } else {
        $user = wp_get_current_user();
        $label = in_array( 'administrator', (array) $user->roles, true ) ? 'Administrator' : ( sslms_is_student() ? 'Student' : ( sslms_is_instructor() ? 'Instructor' : 'Account' ) );
        $dashboard = '';
        if ( in_array( 'administrator', (array) $user->roles, true ) ) { $dashboard = admin_url(); }
        if ( in_array( 'instructor', (array) $user->roles, true ) ) { $dashboard = sslms_instructor_dashboard_url(); }
        if ( $dashboard ) {
            $items[] = '<a href="' . esc_url( $dashboard ) . '">Dashboard</a>';
        }
        if ( sslms_is_student() ) {
            $items[] = '<a href="' . esc_url( sslms_student_chat_url() ) . '">Chat</a>';
        } elseif ( sslms_is_instructor() ) {
            $items[] = '<a href="' . esc_url( sslms_instructor_admin_chat_url() ) . '">Chat</a>';
        }
        $profile_url = sslms_is_student() ? sslms_student_profile_page_url() : ( sslms_is_instructor() ? sslms_instructor_profile_url() : get_edit_profile_url( $user->ID ) );
        $profile_page = get_page_by_path( 'student-profile' );
        $profile_page = sslms_is_student() ? $profile_page : get_page_by_path( 'instructor-profile' );
        $profile_active = $profile_page && is_page( $profile_page->ID ) ? ' class="is-active" aria-current="page"' : '';
        $account_active = $profile_active ? ' class="is-active"' : '';
        $items[] = '<div class="dynamic-menu-dropdown"><a href="#"' . $account_active . '>' . esc_html( $label ) . '</a><div class="dynamic-menu-dropdown-content">'
            . '<a href="' . esc_url( $profile_url ) . '"' . $profile_active . '>Profile</a>'
            . '<a href="' . esc_url( sslms_direct_logout_url( home_url( '/' ) ) ) . '">Sign out</a>'
            . '</div></div>';
    }

    return '<nav class="dynamic-main-menu" aria-label="Main navigation">' . implode( '', $items ) . '</nav>';
});
