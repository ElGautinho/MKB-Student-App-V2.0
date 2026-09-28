<?php
/* Template Name: Student Chat */
if ( ! sslms_is_student() ) {
  get_header();
    echo '<section class="lms-page"><div class="survey-permission"><strong>Student chat</strong><br>Please sign in with a student account to access your conversation.</div></section>';
    get_footer(); return;
}
$user_id = get_current_user_id();
$selected_instructor_id = absint( $_POST['chat_recipient_id'] ?? $_GET['chat_recipient_id'] ?? sslms_get_student_chat_instructor_id( $user_id ) );
$instructor = $selected_instructor_id ? get_userdata( $selected_instructor_id ) : false;
if ( ! $instructor || ! sslms_is_chat_instructor( $instructor->ID ) ) { $instructor = false; }
if ( $instructor ) { update_user_meta( $user_id, '_sslms_chat_instructor_id', $instructor->ID ); }
$status = $instructor ? sslms_handle_chat_actions( 'student_instructor', $instructor->ID, 'sslms_student_chat', 'sslms_student_chat_nonce' ) : '';
if ( ! $status ) { $status = $instructor && isset( $_POST['sslms_student_chat_nonce'] ) ? sslms_save_chat_message( 'student_instructor', $instructor->ID, 'sslms_student_chat', 'sslms_student_chat_nonce' ) : ''; }
if ( $status ) {
  wp_safe_redirect( add_query_arg( array( 'chat_recipient_id' => $selected_instructor_id, 'sslms_status' => $status ), get_permalink() ) );
  exit;
}
$status = sanitize_key( $_GET['sslms_status'] ?? '' );
$messages = $instructor ? sslms_get_chat_messages( 'student_instructor', $user_id, $instructor->ID ) : array();
$instructors = sslms_get_instructor_users();
get_header();
?>
<section class="lms-page chat-page">
  <div class="lms-toolbar"><div><p class="lms-kicker">Chat</p><h1 class="lms-section-title">Chat</h1><p>Ask questions, share updates and keep your learning conversation in one place.</p></div><a class="lms-btn lms-btn--ghost" href="<?php echo esc_url( home_url( '/student-dashboard/' ) ); ?>">Back to dashboard <span aria-hidden="true">&#8594;</span></a></div>
  <?php if ( 'sent' === $status ) : ?><div class="profile-notice profile-notice--success">Your message has been sent.</div><?php elseif ( 'edited' === $status ) : ?><div class="profile-notice profile-notice--success">Your message has been updated.</div><?php elseif ( 'deleted' === $status ) : ?><div class="profile-notice profile-notice--success">Your message has been deleted.</div><?php elseif ( 'error' === $status ) : ?><div class="profile-notice profile-notice--error">We could not update that message. Please try again.</div><?php endif; ?>
  <form class="lms-card chat-selector" method="get"><label><span>Choose an instructor</span><select name="chat_recipient_id" required><option value="">Select an instructor</option><?php foreach ( $instructors as $available_instructor ) : ?><option value="<?php echo esc_attr( $available_instructor->ID ); ?>" <?php selected( $instructor ? $instructor->ID : 0, $available_instructor->ID ); ?>><?php echo esc_html( $available_instructor->display_name ); ?></option><?php endforeach; ?></select></label><button class="lms-btn lms-btn--small" type="submit">Open conversation <span aria-hidden="true">&#8594;</span></button></form>
  <?php if ( ! $instructor ) : ?><div class="lms-card chat-empty"><strong>Choose an instructor first</strong><p>Select an instructor above to start a private conversation.</p></div>
  <?php else : ?>
    <section class="lms-card chat-card"><div class="chat-card__header"><div><p class="lms-kicker">Private conversation</p><h2><?php echo esc_html( $instructor->display_name ); ?></h2><small><?php echo esc_html( sslms_profile_value( 'program', $instructor->ID ) ?: 'Instructor' ); ?></small></div><img src="<?php echo esc_url( sslms_student_profile_photo_url( $instructor->ID, 'medium' ) ); ?>" alt=""></div>
      <div class="chat-messages"><?php if ( $messages ) : foreach ( $messages as $message ) : $mine = (int) $message->post_author === $user_id; ?><article class="chat-message<?php echo $mine ? ' chat-message--mine' : ''; ?>"><div class="chat-message__body"><?php echo nl2br( esc_html( $message->post_content ) ); ?></div><small><?php echo esc_html( $mine ? 'You' : $instructor->display_name ); ?> · <?php echo esc_html( get_the_date( 'M j, Y g:i a', $message ) ); ?></small><?php if ( $mine ) : ?><div class="chat-message__actions"><form method="post"><input type="hidden" name="chat_recipient_id" value="<?php echo esc_attr( $instructor->ID ); ?>"><input type="hidden" name="chat_message_id" value="<?php echo esc_attr( $message->ID ); ?>"><?php wp_nonce_field( 'sslms_student_chat', 'sslms_student_chat_nonce' ); ?><input type="hidden" name="sslms_chat_action" value="edit"><input class="chat-edit-input" type="text" name="chat_message" value="<?php echo esc_attr( $message->post_content ); ?>" required><button type="submit">Edit</button></form><form method="post"><input type="hidden" name="chat_recipient_id" value="<?php echo esc_attr( $instructor->ID ); ?>"><input type="hidden" name="chat_message_id" value="<?php echo esc_attr( $message->ID ); ?>"><?php wp_nonce_field( 'sslms_student_chat', 'sslms_student_chat_nonce' ); ?><input type="hidden" name="sslms_chat_action" value="delete"><button type="submit" onclick="return confirm('Delete this message?');">Delete</button></form></div><?php endif; ?></article><?php endforeach; else : ?><div class="chat-no-messages"><strong>Start the conversation</strong><p>Send your first message to <?php echo esc_html( $instructor->display_name ); ?>.</p></div><?php endif; ?></div>
      <form class="chat-form" method="post"><input type="hidden" name="chat_recipient_id" value="<?php echo esc_attr( $instructor->ID ); ?>"><?php wp_nonce_field( 'sslms_student_chat', 'sslms_student_chat_nonce' ); ?><label><span>Message</span><textarea name="chat_message" rows="3" placeholder="Write a message..." required></textarea></label><button class="lms-btn" type="submit">Send message <span aria-hidden="true">&#8594;</span></button></form>
    </section>
  <?php endif; ?>
</section>
<?php get_footer(); ?>
