<?php
/* Template Name: My Completed Surveys */
get_header();
if ( ! sslms_is_student() ) {
  echo '<section class="lms-page"><div class="survey-permission"><strong>Access restricted.</strong><br>This page is available to students only.</div></section>';
  get_footer(); return;
}
$user_id = get_current_user_id();
$paged = max( 1, absint( $_GET['response_page'] ?? 1 ) );
$responses_query = sslms_get_student_responses_paginated( $user_id, $paged, 4 );
$responses = $responses_query->posts;
$selected_id = isset( $_GET['response_id'] ) ? absint( $_GET['response_id'] ) : 0;
$selected = $responses ? $responses[0] : null;
if ( $selected_id ) {
  $requested_response = get_post( $selected_id );
  $requested_survey_id = $requested_response ? absint( get_post_meta( $requested_response->ID, '_response_survey_id', true ) ) : 0;
  if ( $requested_response && 'response' === $requested_response->post_type && (int) $requested_response->post_author === $user_id && 'survey' === get_post_type( $requested_survey_id ) ) {
    $selected = $requested_response;
  }
}
?>
<section class="lms-page student-answers-page">
  <div class="lms-toolbar"><div><p class="lms-kicker">Your learning activity</p><h1 class="lms-section-title">My progress</h1><p>Review completed surveys and any instructor feedback.</p></div></div>
  <?php if ( $responses ) : ?>
  <div class="my-surveys-layout">
    <aside class="lms-card completed-list"><div class="completed-list__heading"><div><p class="lms-kicker">Survey archive</p><h2>Your submissions</h2></div><span class="completed-count"><?php echo esc_html( $responses_query->found_posts ); ?></span></div><ul class="survey-list">
      <?php foreach ( $responses as $index => $response ) :
        $sid = absint( get_post_meta( $response->ID, '_response_survey_id', true ) );
        $link = add_query_arg( array( 'response_id' => $response->ID, 'response_page' => $paged ), get_permalink() );
      ?>
      <li class="survey-list-item"><a href="<?php echo esc_url( $link ); ?>" class="survey-link<?php echo $selected && (int) $selected->ID === (int) $response->ID ? ' is-selected' : ''; ?>"><span class="survey-link__number"><?php echo esc_html( ( ( $paged - 1 ) * 4 ) + $index + 1 ); ?></span><span><?php echo esc_html( get_the_title( $sid ) ); ?><small><?php echo esc_html( get_the_date( '', $response ) ); ?></small></span></a></li>
      <?php endforeach; ?>
    </ul>
    <?php if ( $responses_query->max_num_pages > 1 ) : ?><nav class="survey-pagination" aria-label="Completed survey pagination"><?php if ( $paged > 1 ) : ?><a aria-label="Previous page of completed surveys" href="<?php echo esc_url( add_query_arg( 'response_page', $paged - 1 ) ); ?>"><span aria-hidden="true">←</span> Previous</a><?php endif; ?><span>Page <?php echo esc_html( $paged ); ?> of <?php echo esc_html( $responses_query->max_num_pages ); ?></span><?php if ( $paged < $responses_query->max_num_pages ) : ?><a aria-label="Next page of completed surveys" href="<?php echo esc_url( add_query_arg( 'response_page', $paged + 1 ) ); ?>">Next <span aria-hidden="true">→</span></a><?php endif; ?></nav><?php endif; ?>
    </aside>
    <?php if ( $selected ) :
      $survey_id = absint( get_post_meta( $selected->ID, '_response_survey_id', true ) );
      $answers = get_post_meta( $selected->ID, '_response_answers', true );
      $feedback = get_post_meta( $selected->ID, '_response_feedback', true );
      $questions = sslms_get_survey_questions( $survey_id );
    ?>
    <div class="lms-card survey-answers-block"><p class="lms-kicker">Submission review</p><h2 class="answers-title"><?php echo esc_html( get_the_title( $survey_id ) ); ?></h2>
      <?php if ( $questions ) : ?><ul class="question-list">
        <?php foreach ( $questions as $question ) : $qid = $question->ID; $answer = is_array( $answers ) && isset( $answers[ $qid ] ) ? $answers[ $qid ] : ''; ?>
          <li class="question-list-item"><span class="question-label"><?php echo esc_html( $question->post_title ); ?></span><span class="answer-value"><?php echo esc_html( is_array( $answer ) ? implode( ', ', $answer ) : $answer ); ?></span></li>
        <?php endforeach; ?></ul>
      <?php else : ?><div class="no-questions">No questions found for this survey.</div><?php endif; ?>
      <?php if ( $feedback ) : ?><div class="instructor-feedback"><strong>Instructor feedback</strong><br><?php echo esc_html( $feedback ); ?></div><?php endif; ?>
    </div>
    <?php endif; ?>
  </div>
  <?php else : ?><div class="empty-state"><strong>You have not completed any surveys yet.</strong><br><span class="lms-muted">Your completed surveys will appear here after you submit one.</span></div><?php endif; ?>
</section>
<?php get_footer(); ?>
