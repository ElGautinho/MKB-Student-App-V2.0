<?php
/* Template Name: My Feedback */
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
$selected = null;
if ( $selected_id ) {
  foreach ( $responses as $response ) {
    if ( (int) $response->ID === $selected_id ) { $selected = $response; break; }
  }
}
if ( ! $selected && $responses ) { $selected = $responses[0]; }
if ( $selected && get_post_meta( $selected->ID, '_response_feedback', true ) ) {
  sslms_notification_mark_seen( 'feedback', array( $selected->ID ), $user_id );
}

$completed_page = get_pages( array( 'meta_key' => '_wp_page_template', 'meta_value' => 'page-my-surveys.php', 'post_status' => 'publish', 'number' => 1 ) );
$completed_url = ! empty( $completed_page ) ? get_permalink( $completed_page[0]->ID ) : home_url( '/my-completed-surveys/' );
?>
<section class="lms-page feedback-page">
  <div class="feedback-intro">
    <div>
      <p class="lms-kicker">Your learning journey</p>
      <h1 class="lms-section-title">My Feedback</h1>
      <p>See the surveys you have completed, who created them, and the complete feedback shared by your instructor.</p>
    </div>
    <a class="lms-btn lms-btn--ghost" href="<?php echo esc_url( $completed_url ); ?>">View my answers</a>
  </div>

  <?php if ( ! $responses ) : ?>
    <div class="feedback-empty lms-card">
      <div class="feedback-empty__icon">✦</div>
      <h2>No feedback yet</h2>
      <p>Once you complete a survey, it will appear here with its survey information and instructor feedback.</p>
      <a class="lms-btn" href="<?php echo esc_url( home_url( '/survey/' ) ); ?>">Explore surveys →</a>
    </div>
  <?php else : ?>
    <div class="feedback-layout">
      <aside class="lms-card feedback-sidebar">
        <div class="feedback-sidebar__head">
          <span>Completed</span>
          <strong><?php echo esc_html( $responses_query->found_posts ); ?></strong>
        </div>
        <div class="feedback-response-list">
          <?php foreach ( $responses as $response ) :
            $sid = absint( get_post_meta( $response->ID, '_response_survey_id', true ) );
            $feedback = trim( (string) get_post_meta( $response->ID, '_response_feedback', true ) );
            $active = $selected && (int) $selected->ID === (int) $response->ID;
            $link = add_query_arg( array( 'response_id' => $response->ID, 'response_page' => $paged ), get_permalink() );
          ?>
            <a class="feedback-response<?php echo $active ? ' is-active' : ''; ?>" href="<?php echo esc_url( $link ); ?>">
              <span class="feedback-response__icon">✓</span>
              <span class="feedback-response__text"><strong><?php echo esc_html( get_the_title( $sid ) ?: 'Survey' ); ?></strong><small><?php echo esc_html( get_the_date( '', $response ) ); ?></small></span>
              <span class="feedback-response__status <?php echo $feedback ? 'has-feedback' : 'waiting'; ?>"><?php echo $feedback ? 'Feedback' : 'Pending'; ?></span>
            </a>
          <?php endforeach; ?>
        </div>
        <?php if ( $responses_query->max_num_pages > 1 ) : ?><nav class="survey-pagination" aria-label="Completed feedback pagination"><?php if ( $paged > 1 ) : ?><a aria-label="Previous page of feedback" href="<?php echo esc_url( add_query_arg( 'response_page', $paged - 1 ) ); ?>"><span aria-hidden="true">←</span> Previous</a><?php endif; ?><span>Page <?php echo esc_html( $paged ); ?> of <?php echo esc_html( $responses_query->max_num_pages ); ?></span><?php if ( $paged < $responses_query->max_num_pages ) : ?><a aria-label="Next page of feedback" href="<?php echo esc_url( add_query_arg( 'response_page', $paged + 1 ) ); ?>">Next <span aria-hidden="true">→</span></a><?php endif; ?></nav><?php endif; ?>
      </aside>

      <?php if ( $selected ) :
        $survey_id = absint( get_post_meta( $selected->ID, '_response_survey_id', true ) );
        $survey = get_post( $survey_id );
        $feedback = trim( (string) get_post_meta( $selected->ID, '_response_feedback', true ) );
        $questions = sslms_get_survey_questions( $survey_id );
        $start_date = get_post_meta( $survey_id, '_survey_start_date', true );
        $end_date = get_post_meta( $survey_id, '_survey_end_date', true );
        $description = get_post_meta( $survey_id, '_survey_description', true );
        $creator = $survey ? get_userdata( (int) $survey->post_author ) : false;
        $creator_name = $creator ? $creator->display_name : 'Instructor';
        $creator_photo = $creator ? get_avatar_url( $creator->ID, array( 'size' => 96 ) ) : '';
        $survey_image = $survey ? get_the_post_thumbnail_url( $survey_id, 'large' ) : '';
      ?>
      <div class="feedback-content">
        <section class="lms-card feedback-survey-card">
          <div class="feedback-survey-media">
            <img src="<?php echo esc_url( $survey_image ?: sslms_image_url( $survey_id ) ); ?>" alt="<?php echo esc_attr( $survey ? $survey->post_title : 'Survey' ); ?>">
            <span>Completed <?php echo esc_html( get_the_date( '', $selected ) ); ?></span>
          </div>
          <div class="feedback-survey-body">
            <p class="lms-kicker">Survey information</p>
            <h2><?php echo esc_html( $survey ? $survey->post_title : 'Survey' ); ?></h2>
            <?php if ( $description ) : ?><p class="feedback-survey-description"><?php echo esc_html( $description ); ?></p><?php endif; ?>
            <div class="feedback-info-grid">
              <div><small>Created by</small><strong class="feedback-person"><img src="<?php echo esc_url( $creator_photo ); ?>" alt=""><span><?php echo esc_html( $creator_name ); ?></span></strong></div>
              <div><small>Questions</small><strong><?php echo esc_html( count( $questions ) ); ?></strong></div>
              <div><small>Available</small><strong><?php echo esc_html( $start_date ? $start_date : 'Open' ); ?><?php if ( $end_date ) : ?> → <?php echo esc_html( $end_date ); ?><?php endif; ?></strong></div>
            </div>
          </div>
        </section>

        <section class="feedback-full-card lms-card">
          <div class="feedback-card-heading">
            <div><p class="lms-kicker">Instructor review</p><h2>Complete feedback</h2></div>
            <span class="feedback-badge <?php echo $feedback ? 'feedback-badge--ready' : 'feedback-badge--waiting'; ?>"><?php echo $feedback ? 'Received' : 'Waiting for review'; ?></span>
          </div>
          <?php if ( $feedback ) : ?>
            <div class="feedback-quote"><span class="feedback-quote__mark">“</span><div><?php echo nl2br( esc_html( $feedback ) ); ?></div></div>
          <?php else : ?>
            <div class="feedback-pending"><strong>Your instructor has not added feedback yet.</strong><p>Keep this page in mind. As soon as the instructor reviews your response, their full message will appear here.</p></div>
          <?php endif; ?>
        </section>

        <div class="feedback-bottom-actions">
          <a class="lms-btn lms-btn--ghost" href="<?php echo esc_url( $completed_url ); ?>">← Review my answers</a>
          <a class="lms-btn" href="<?php echo esc_url( get_permalink( $survey_id ) ); ?>">Open survey</a>
        </div>
      </div>
      <?php endif; ?>
    </div>
  <?php endif; ?>
</section>
<?php get_footer(); ?>
