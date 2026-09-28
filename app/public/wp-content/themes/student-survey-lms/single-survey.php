<?php
if ( ! sslms_is_student() ) {
  get_header();
  echo '<section class="lms-page"><div class="survey-permission"><strong>Student access required.</strong><br>Please sign in with a student account to complete this survey.</div></section>';
  get_footer(); return;
}
$survey_id = get_the_ID();
$title = get_the_title();
$description = get_post_meta( $survey_id, '_survey_description', true );
$start_date = get_post_meta( $survey_id, '_survey_start_date', true );
$end_date = get_post_meta( $survey_id, '_survey_end_date', true );
$user_id = get_current_user_id();
$assignment = sslms_get_student_assignment( $user_id );
$visible_surveys = sslms_get_student_visible_survey_ids( $user_id );
$can_access_survey = in_array( $survey_id, $visible_surveys, true );

if ( ! $can_access_survey ) {
    get_header();
    echo '<section class="lms-page"><div class="survey-permission"><strong>Access to this survey is limited.</strong><br>Please choose your assigned instructor and class in your profile to view the right survey.</div></section>';
    get_footer();
    return;
}
  sslms_notification_mark_seen( 'surveys', array( $survey_id ), $user_id );

$existing_response = sslms_get_student_response( $survey_id, $user_id );
$already_responded = (bool) $existing_response;
$questions = sslms_get_survey_questions( $survey_id );
$message = 'submitted' === sanitize_key( $_GET['survey_status'] ?? '' ) ? '<div class="survey-success"><strong>Response submitted!</strong><br>Thank you for helping improve the learning experience.</div>' : '';

if ( 'POST' === $_SERVER['REQUEST_METHOD'] && isset( $_POST['sslms_submit_survey'] ) && wp_verify_nonce( sanitize_text_field( wp_unslash( $_POST['sslms_survey_nonce'] ?? '' ) ), 'sslms_submit_survey' ) && ! $already_responded ) {
    $answers = isset( $_POST['answer'] ) && is_array( $_POST['answer'] ) ? wp_unslash( $_POST['answer'] ) : array();
    $errors = array(); $clean = array();
    foreach ( $questions as $question ) {
        $qid = $question->ID;
        $required = '1' === get_post_meta( $qid, '_question_required', true );
        $value = $answers[ $qid ] ?? '';
        $empty = is_array( $value ) ? ! array_filter( array_map( 'trim', $value ) ) : '' === trim( (string) $value );
        if ( $required && $empty ) { $errors[] = $qid; }
        $clean[ $qid ] = is_array( $value ) ? array_map( 'sanitize_text_field', $value ) : sanitize_textarea_field( $value );
    }
    if ( $errors ) {
        $message = '<div class="survey-error"><strong>Almost there.</strong><br>Please complete all required questions before submitting.</div>';
    } else {
        $response_id = wp_insert_post( array( 'post_type' => 'response', 'post_title' => 'Response for Survey #' . $survey_id . ' by User #' . $user_id, 'post_status' => 'publish', 'post_author' => $user_id ) );
        if ( $response_id && ! is_wp_error( $response_id ) ) {
            update_post_meta( $response_id, '_response_survey_id', $survey_id );
            update_post_meta( $response_id, '_response_student_id', $user_id );
            update_post_meta( $response_id, '_response_answers', $clean );
            $existing_response = get_post( $response_id );
            $already_responded = true;
            wp_safe_redirect( add_query_arg( 'survey_status', 'submitted', get_permalink( $survey_id ) ) );
            exit;
        } else {
            $message = '<div class="survey-error"><strong>Something went wrong.</strong><br>Your responses could not be saved.</div>';
        }
    }
}
  get_header();
?>
<section id="survey-wrapper" class="survey-shell">
  <div class="survey-hero<?php echo has_post_thumbnail( $survey_id ) ? ' survey-hero--with-image' : ''; ?>">
    <?php if ( has_post_thumbnail( $survey_id ) ) : ?><img class="survey-hero__image" src="<?php echo esc_url( get_the_post_thumbnail_url( $survey_id, 'large' ) ); ?>" alt="<?php echo esc_attr( $title ); ?>"><?php endif; ?>
    <div class="survey-hero__content"><p class="lms-kicker" style="color:#c4c6ff;">Learning survey</p><h1><?php echo esc_html( $title ); ?></h1><?php if ( $description ) : ?><p class="survey-description"><?php echo esc_html( $description ); ?></p><?php endif; ?><?php if ( $start_date || $end_date ) : ?><p class="survey-dates"><strong>Availability:</strong>&nbsp; <?php echo esc_html( $start_date ?: 'Open' ); ?> → <?php echo esc_html( $end_date ?: 'Open' ); ?></p><?php endif; ?></div>
  </div>
  <?php echo $message; ?>
  <?php if ( $already_responded ) :
    $submitted_answers = get_post_meta( $existing_response->ID, '_response_answers', true );
    $submitted_feedback = get_post_meta( $existing_response->ID, '_response_feedback', true );
  ?>
    <div class="survey-info">
      <strong>You have already completed this survey.</strong><br>
      Your answers are shown below in read-only mode. You cannot modify or resubmit them.
    </div>

    <div class="lms-card survey-answers-block" id="review-my-answers">
      <p class="lms-kicker">Review my answers</p>
      <h2 class="answers-title"><?php echo esc_html( $title ); ?></h2>
      <?php if ( $questions ) : ?>
        <ul class="question-list">
          <?php foreach ( $questions as $question ) :
            $qid = $question->ID;
            $answer = is_array( $submitted_answers ) && isset( $submitted_answers[ $qid ] ) ? $submitted_answers[ $qid ] : '';
            $display_answer = is_array( $answer ) ? implode( ', ', $answer ) : $answer;
          ?>
            <li class="question-list-item">
              <span class="question-label"><?php echo esc_html( $question->post_title ); ?></span>
              <span class="answer-value"><?php echo esc_html( $display_answer !== '' ? $display_answer : 'No answer provided' ); ?></span>
            </li>
          <?php endforeach; ?>
        </ul>
      <?php else : ?>
        <div class="no-questions">No questions found for this survey.</div>
      <?php endif; ?>

      <?php if ( $submitted_feedback ) : ?>
        <div class="instructor-feedback">
          <strong>Instructor feedback</strong><br>
          <?php echo esc_html( $submitted_feedback ); ?>
        </div>
      <?php endif; ?>
    </div>
  <?php elseif ( $questions ) : ?>
    <div class="survey-progress" aria-hidden="true"><div class="survey-progress__bar"><div class="survey-progress__fill" id="survey-progress-fill"></div></div></div>
    <form id="survey-form" class="survey-form" method="post" enctype="multipart/form-data" autocomplete="off">
      <?php wp_nonce_field( 'sslms_submit_survey', 'sslms_survey_nonce' ); ?><input type="hidden" name="sslms_submit_survey" value="1">
      <?php $total = count( $questions ); foreach ( $questions as $i => $question ) :
        $qid = $question->ID; $type = get_post_meta( $qid, '_question_type', true ); $required = '1' === get_post_meta( $qid, '_question_required', true );
        $options = get_post_meta( $qid, '_question_answer_options', true ); $options = $options ? array_filter( array_map( 'trim', preg_split( '/\r\n|\r|\n/', $options ) ) ) : array();
      ?>
      <fieldset class="survey-question <?php echo ( $required && in_array( $type, array( 'multiple_choice', 'checkbox' ), true ) ) ? 'required-group' : ''; ?>" aria-labelledby="survey-question-heading-<?php echo esc_attr( $qid ); ?>">
        <div class="survey-question__heading" id="survey-question-heading-<?php echo esc_attr( $qid ); ?>"><span class="survey-question__progress">Question <?php echo esc_html( $i + 1 . ' / ' . $total ); ?></span><p><?php echo esc_html( $question->post_title ); ?> <?php if ( $required ) : ?><span aria-label="required" style="color:#c94b65">*</span><?php endif; ?></p></div>
        <?php if ( in_array( $type, array( 'multiple_choice', 'checkbox' ), true ) ) : ?>
          <?php foreach ( $options as $opt ) : ?>
            <label class="survey-option"><input type="checkbox" name="answer[<?php echo esc_attr( $qid ); ?>][]" value="<?php echo esc_attr( $opt ); ?>"> <span><?php echo esc_html( $opt ); ?></span></label>
          <?php endforeach; ?>
        <?php elseif ( 'radio_button' === $type ) : ?>
          <?php foreach ( $options as $opt ) : ?>
            <label class="survey-option"><input type="radio" name="answer[<?php echo esc_attr( $qid ); ?>]" value="<?php echo esc_attr( $opt ); ?>" <?php echo $required ? 'required' : ''; ?>> <span><?php echo esc_html( $opt ); ?></span></label>
          <?php endforeach; ?>
        <?php elseif ( 'true_false' === $type ) : ?>
          <?php foreach ( array( 'true' => 'True', 'false' => 'False' ) as $value => $label ) : ?>
            <label class="survey-option"><input type="radio" name="answer[<?php echo esc_attr( $qid ); ?>]" value="<?php echo esc_attr( $value ); ?>" <?php echo $required ? 'required' : ''; ?>> <span><?php echo esc_html( $label ); ?></span></label>
          <?php endforeach; ?>
        <?php elseif ( 'dropdown' === $type ) : ?>
          <select name="answer[<?php echo esc_attr( $qid ); ?>]" <?php echo $required ? 'required' : ''; ?>><option value="">Choose an option</option><?php foreach ( $options as $opt ) : ?><option value="<?php echo esc_attr( $opt ); ?>"><?php echo esc_html( $opt ); ?></option><?php endforeach; ?></select>
        <?php elseif ( 'email' === $type ) : ?><input type="email" name="answer[<?php echo esc_attr( $qid ); ?>]" class="form-control" placeholder="you@example.com" <?php echo $required ? 'required' : ''; ?>>
        <?php elseif ( 'phone' === $type ) : ?><input type="tel" name="answer[<?php echo esc_attr( $qid ); ?>]" class="form-control" placeholder="Your phone number" <?php echo $required ? 'required' : ''; ?>>
        <?php elseif ( 'text_array' === $type || 'textarea' === $type ) : ?><textarea name="answer[<?php echo esc_attr( $qid ); ?>]" class="form-control" placeholder="Share your thoughts..." <?php echo $required ? 'required' : ''; ?>></textarea>
        <?php elseif ( 'date' === $type ) : ?><input type="date" name="answer[<?php echo esc_attr( $qid ); ?>]" class="form-control" <?php echo $required ? 'required' : ''; ?>>
        <?php elseif ( 'number' === $type ) : ?><input type="number" name="answer[<?php echo esc_attr( $qid ); ?>]" class="form-control" <?php echo $required ? 'required' : ''; ?>>
        <?php elseif ( 'file_upload' === $type ) : ?><input type="file" name="answer[<?php echo esc_attr( $qid ); ?>]" class="form-control" <?php echo $required ? 'required' : ''; ?>>
        <?php elseif ( 'time' === $type ) : ?><input type="time" name="answer[<?php echo esc_attr( $qid ); ?>]" class="form-control" <?php echo $required ? 'required' : ''; ?>>
        <?php elseif ( 'range' === $type ) : ?><input type="range" name="answer[<?php echo esc_attr( $qid ); ?>]" min="0" max="100" class="form-control">
        <?php else : ?><input type="text" name="answer[<?php echo esc_attr( $qid ); ?>]" class="form-control" placeholder="Type your answer..." <?php echo $required ? 'required' : ''; ?>><?php endif; ?>
      </fieldset>
      <?php endforeach; ?>
      <div class="survey-navigation"><button type="submit" id="submit-btn">Submit responses&nbsp; →</button></div>
      <p id="progress"><?php echo esc_html( $total ); ?> questions · Fields marked * are required</p>
    </form>
  <?php else : ?><div class="empty-state">No questions found for this survey.</div><?php endif; ?>
</section>
<?php get_footer(); ?>
