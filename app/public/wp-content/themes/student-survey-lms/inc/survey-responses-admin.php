<?php
if ( ! defined( 'ABSPATH' ) ) { exit; }

function sslms_can_manage_responses() {
    return sslms_user_has_role( array( 'instructor', 'administrator' ) );
}

add_action( 'admin_menu', function() {
    if ( ! sslms_can_manage_responses() ) { return; }
    add_menu_page( 'Survey Responses', 'Survey Responses', 'read', 'survey-responses', 'sslms_survey_responses_admin_page', 'dashicons-feedback', 6 );
});

function sslms_survey_responses_admin_page() {
    if ( ! sslms_can_manage_responses() ) {
        echo '<div class="notice notice-error"><p>Access denied.</p></div>'; return;
    }

    if ( isset( $_POST['response_id'], $_POST['sslms_feedback_nonce'] ) && wp_verify_nonce( sanitize_text_field( wp_unslash( $_POST['sslms_feedback_nonce'] ) ), 'sslms_feedback' ) ) {
        $response_id = absint( $_POST['response_id'] );
        $survey_id = absint( get_post_meta( $response_id, '_response_survey_id', true ) );
        if ( ! sslms_instructor_can_manage_survey( $survey_id ) ) {
            echo '<div class="notice notice-error"><p>Feedback access denied.</p></div>';
        } elseif ( 'delete_feedback' === sanitize_key( $_POST['feedback_action'] ?? '' ) ) {
            delete_post_meta( $response_id, '_response_feedback' );
            echo '<div class="notice notice-success"><p>Feedback deleted.</p></div>';
        } else {
            $feedback = sanitize_textarea_field( wp_unslash( $_POST['response_feedback'] ?? '' ) );
            if ( '' === trim( $feedback ) ) {
                delete_post_meta( $response_id, '_response_feedback' );
            } else {
                update_post_meta( $response_id, '_response_feedback', $feedback );
            }
            echo '<div class="notice notice-success"><p>Feedback saved.</p></div>';
        }
    }

    $current_user = wp_get_current_user();
    $survey_args = array( 'post_type' => 'survey', 'posts_per_page' => -1 );
    if ( ! in_array( 'administrator', (array) $current_user->roles, true ) ) { $survey_args['author'] = $current_user->ID; }
    $surveys = get_posts( $survey_args );

    echo '<div class="wrap"><h1>Survey Responses</h1>';
    if ( ! $surveys ) { echo '<p>No surveys found.</p></div>'; return; }

    foreach ( $surveys as $survey ) {
        echo '<div style="background:#fff;padding:20px;margin:20px 0;border:1px solid #ddd;border-radius:12px;"><h2>' . esc_html( $survey->post_title ) . '</h2>';
        $responses = get_posts( array( 'post_type' => 'response', 'meta_key' => '_response_survey_id', 'meta_value' => $survey->ID, 'posts_per_page' => -1 ) );
        if ( ! $responses ) { echo '<p>No responses yet.</p></div>'; continue; }
        echo '<table class="widefat fixed striped"><thead><tr><th>Student</th><th>Class</th><th>Answers</th><th>Date</th><th>Feedback</th></tr></thead><tbody>';
        foreach ( $responses as $response ) {
            $student_id = get_post_meta( $response->ID, '_response_student_id', true );
            $student = get_userdata( $student_id );
            $assignment = sslms_get_student_assignment( $student_id );
            $student_class = $assignment['class'];
            $answers = get_post_meta( $response->ID, '_response_answers', true );
            $feedback = get_post_meta( $response->ID, '_response_feedback', true );
            $snapshot = $student ? sslms_student_profile_snapshot( $student_id ) : array();
            echo '<tr><td>';
            if ( $student ) {
                $photo = ! empty( $snapshot['photo'] ) ? '<img src="' . esc_url( $snapshot['photo'] ) . '" style="width:42px;height:42px;border-radius:50%;object-fit:cover;vertical-align:middle;margin-right:8px;">' : '';
                echo '<div style="display:flex;align-items:center;">' . $photo . '<div><strong>' . esc_html( $student->display_name ) . '</strong><br><small>' . esc_html( $student->user_email ) . '</small></div></div>';
            } else {
                echo 'Unknown student';
            }
            echo '</td><td>' . esc_html( $student_class ?: '—' ) . '</td><td><pre style="white-space:pre-wrap;">' . esc_html( print_r( $answers, true ) ) . '</pre></td><td>' . esc_html( get_the_date( '', $response ) ) . '</td><td>';
            echo '<form method="post"><input type="hidden" name="response_id" value="' . esc_attr( $response->ID ) . '">';
            wp_nonce_field( 'sslms_feedback', 'sslms_feedback_nonce' );
            echo '<textarea name="response_feedback" rows="4" style="width:100%;">' . esc_textarea( $feedback ) . '</textarea><p><button class="button button-primary" name="feedback_action" value="save_feedback">Save feedback</button> <button class="button" name="feedback_action" value="delete_feedback">Delete feedback</button></p></form></td></tr>';
        }
        echo '</tbody></table></div>';
    }
    echo '</div>';
}
