<?php
if ( ! defined( 'ABSPATH' ) ) { exit; }

function sslms_notification_user_meta_key( $type ) {
    return '_sslms_seen_' . sanitize_key( $type ) . '_ids';
}

function sslms_notification_seen_ids( $type, $user_id = 0 ) {
    $user_id = $user_id ? absint( $user_id ) : get_current_user_id();
    $ids = get_user_meta( $user_id, sslms_notification_user_meta_key( $type ), true );
    return is_array( $ids ) ? array_map( 'absint', $ids ) : array();
}

function sslms_notification_mark_seen( $type, $ids, $user_id = 0 ) {
    $user_id = $user_id ? absint( $user_id ) : get_current_user_id();
    $ids = array_filter( array_map( 'absint', (array) $ids ) );
    if ( ! $user_id || ! $ids ) { return; }
    $seen = array_values( array_unique( array_merge( sslms_notification_seen_ids( $type, $user_id ), $ids ) ) );
    update_user_meta( $user_id, sslms_notification_user_meta_key( $type ), $seen );
}

function sslms_process_notification_click() {
    if ( ! is_user_logged_in() || empty( $_GET['sslms_notification_type'] ) || empty( $_GET['sslms_notification_id'] ) ) { return; }
    $type = sanitize_key( wp_unslash( $_GET['sslms_notification_type'] ) );
    $id = absint( $_GET['sslms_notification_id'] );
    if ( in_array( $type, array( 'surveys', 'feedback', 'responses', 'messages' ), true ) && $id ) {
        sslms_notification_mark_seen( $type, array( $id ) );
    }
}
add_action( 'template_redirect', 'sslms_process_notification_click' );

function sslms_get_notification_items( $user_id = 0 ) {
    $user_id = $user_id ? absint( $user_id ) : get_current_user_id();
    if ( ! $user_id ) { return array(); }
    $items = array();
    $user = get_userdata( $user_id );
    $roles = $user ? (array) $user->roles : array();

    if ( in_array( 'student', $roles, true ) ) {
        $seen_surveys = sslms_notification_seen_ids( 'surveys', $user_id );
        foreach ( sslms_get_student_visible_survey_ids( $user_id ) as $survey_id ) {
            if ( ! in_array( (int) $survey_id, $seen_surveys, true ) ) {
                $items[] = array( 'type' => 'surveys', 'id' => $survey_id, 'title' => 'New survey available', 'text' => get_the_title( $survey_id ), 'url' => get_permalink( $survey_id ) );
            }
        }

        $seen_feedback = sslms_notification_seen_ids( 'feedback', $user_id );
        $responses = get_posts( array( 'post_type' => 'response', 'post_status' => 'publish', 'author' => $user_id, 'posts_per_page' => -1, 'meta_query' => array( array( 'key' => '_response_feedback', 'value' => '', 'compare' => '!=' ) ) ) );
        foreach ( $responses as $response ) {
            if ( ! in_array( (int) $response->ID, $seen_feedback, true ) ) {
                $items[] = array( 'type' => 'feedback', 'id' => $response->ID, 'title' => 'New instructor feedback', 'text' => get_the_title( $response->ID ), 'url' => add_query_arg( 'response_id', $response->ID, home_url( '/my-feedback/' ) ) );
            }
        }
    } elseif ( in_array( 'instructor', $roles, true ) ) {
        $seen_responses = sslms_notification_seen_ids( 'responses', $user_id );
        $survey_ids = get_posts( array( 'post_type' => 'survey', 'post_status' => array( 'publish', 'draft', 'pending', 'private' ), 'author' => $user_id, 'posts_per_page' => -1, 'fields' => 'ids' ) );
        if ( $survey_ids ) {
            $responses = get_posts( array( 'post_type' => 'response', 'post_status' => 'publish', 'posts_per_page' => 50, 'meta_query' => array( array( 'key' => '_response_survey_id', 'value' => array_map( 'absint', $survey_ids ), 'compare' => 'IN' ) ), 'orderby' => 'date', 'order' => 'DESC' ) );
            foreach ( $responses as $response ) {
                if ( ! in_array( (int) $response->ID, $seen_responses, true ) ) {
                    $items[] = array( 'type' => 'responses', 'id' => $response->ID, 'title' => 'New survey response', 'text' => get_the_title( absint( get_post_meta( $response->ID, '_response_survey_id', true ) ) ), 'url' => sslms_instructor_dashboard_url() );
                }
            }
        }
    }

    $seen_messages = sslms_notification_seen_ids( 'messages', $user_id );
    $messages = get_posts( array( 'post_type' => 'sslms_chat_message', 'post_status' => 'publish', 'posts_per_page' => 50, 'meta_key' => '_sslms_chat_recipient_id', 'meta_value' => $user_id, 'orderby' => 'date', 'order' => 'DESC' ) );
    foreach ( $messages as $message ) {
        if ( ! in_array( (int) $message->ID, $seen_messages, true ) ) {
            $items[] = array( 'type' => 'messages', 'id' => $message->ID, 'title' => 'New chat message', 'text' => wp_trim_words( $message->post_content, 10 ), 'url' => in_array( 'student', $roles, true ) ? sslms_student_chat_url() : sslms_instructor_admin_chat_url() );
        }
    }

    return $items;
}

function sslms_get_notification_item( $type, $id, $user_id = 0 ) {
    $user_id = $user_id ? absint( $user_id ) : get_current_user_id();
    $id = absint( $id );
    if ( ! $user_id || ! $id ) { return false; }
    $user = get_userdata( $user_id );
    $roles = $user ? (array) $user->roles : array();

    if ( 'surveys' === $type && in_array( 'student', $roles, true ) && in_array( $id, sslms_get_student_visible_survey_ids( $user_id ), true ) ) {
        return array( 'type' => 'surveys', 'id' => $id, 'title' => 'Survey', 'text' => get_the_title( $id ), 'url' => get_permalink( $id ), 'archived' => true );
    }
    if ( 'feedback' === $type && in_array( 'student', $roles, true ) ) {
        $response = get_post( $id );
        if ( $response && 'response' === $response->post_type && (int) $response->post_author === $user_id && get_post_meta( $id, '_response_feedback', true ) ) {
            return array( 'type' => 'feedback', 'id' => $id, 'title' => 'Instructor feedback', 'text' => get_the_title( $id ), 'url' => add_query_arg( 'response_id', $id, home_url( '/my-feedback/' ) ), 'archived' => true );
        }
    }
    if ( 'responses' === $type && in_array( 'instructor', $roles, true ) ) {
        $response = get_post( $id );
        $survey_id = $response ? absint( get_post_meta( $id, '_response_survey_id', true ) ) : 0;
        if ( $response && 'response' === $response->post_type && $survey_id && (int) get_post_field( 'post_author', $survey_id ) === $user_id ) {
            return array( 'type' => 'responses', 'id' => $id, 'title' => 'Survey response', 'text' => get_the_title( $survey_id ), 'url' => sslms_instructor_dashboard_url(), 'archived' => true );
        }
    }
    if ( 'messages' === $type ) {
        $message = get_post( $id );
        if ( $message && 'sslms_chat_message' === $message->post_type && (int) get_post_meta( $id, '_sslms_chat_recipient_id', true ) === $user_id ) {
            return array( 'type' => 'messages', 'id' => $id, 'title' => 'Chat message', 'text' => wp_trim_words( $message->post_content, 10 ), 'url' => in_array( 'student', $roles, true ) ? sslms_student_chat_url() : sslms_instructor_admin_chat_url(), 'archived' => true );
        }
    }
    return false;
}

function sslms_render_header_tools() {
    if ( ! is_user_logged_in() ) { return ''; }
    $user_id = get_current_user_id();
    $items = sslms_get_notification_items( $user_id );
    $current_type = sanitize_key( $_GET['sslms_notification_type'] ?? '' );
    $current_id = absint( $_GET['sslms_notification_id'] ?? 0 );
    if ( $current_type && $current_id ) {
        $current_item = sslms_get_notification_item( $current_type, $current_id, $user_id );
        if ( $current_item ) { array_unshift( $items, $current_item ); }
    }
    $visible_items = $items;
    $count = count( sslms_get_notification_items( $user_id ) );
    $avatar = sslms_student_profile_photo_url( $user_id, 'thumbnail' );
    ob_start();
    ?>
    <div class="lms-header-tools">
        <details class="lms-notifications">
            <summary aria-label="Notifications"><span class="lms-notifications__icon" aria-hidden="true">&#128276;</span><?php if ( $count ) : ?><b><?php echo esc_html( $count > 99 ? '99+' : $count ); ?></b><?php endif; ?></summary>
            <div class="lms-notifications__panel"><strong>Notifications</strong><?php if ( $items ) : ?><div class="lms-notifications__list"><?php foreach ( $visible_items as $item ) : ?><a class="lms-notification-link<?php echo ! empty( $item['archived'] ) ? ' is-archived' : ''; ?>" data-notification-link="true" href="<?php echo esc_url( add_query_arg( array( 'sslms_notification_type' => $item['type'], 'sslms_notification_id' => $item['id'] ), $item['url'] ) ); ?>"><strong><?php echo esc_html( $item['title'] ); ?></strong><small><?php echo esc_html( $item['text'] ); ?></small></a><?php endforeach; ?></div><?php else : ?><p>No new notifications.</p><?php endif; ?></div>
        </details>
        <a class="lms-header-avatar" href="<?php echo esc_url( sslms_is_student() ? sslms_student_profile_page_url() : ( sslms_is_instructor() ? sslms_instructor_profile_url() : get_edit_profile_url( $user_id ) ) ); ?>" aria-label="Open profile"><img src="<?php echo esc_url( $avatar ); ?>" alt=""></a>
    </div>
    <?php
    return ob_get_clean();
}
