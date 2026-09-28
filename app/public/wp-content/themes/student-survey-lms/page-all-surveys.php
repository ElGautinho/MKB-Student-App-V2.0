<?php
/* Template Name: All Surveys */
get_header();
if ( ! sslms_is_student() ) {
  echo '<section class="lms-page"><div class="survey-permission"><strong>Sign in required.</strong><br>Please sign in as a student to access available surveys.</div></section>';
  get_footer(); return;
}
$allowed_survey_ids = sslms_get_student_visible_survey_ids();
$survey_page = max( 1, absint( $_GET['survey_page'] ?? 1 ) );
$survey_query = ! empty( $allowed_survey_ids ) ? new WP_Query( array( 'post_type' => 'survey', 'post_status' => 'publish', 'post__in' => $allowed_survey_ids, 'posts_per_page' => 3, 'paged' => $survey_page, 'orderby' => 'date', 'order' => 'DESC' ) ) : null;
$surveys = $survey_query ? $survey_query->posts : array();
?>
<section class="lms-page">
  <div class="lms-toolbar"><div><p class="lms-kicker">Learning activities</p><h1 class="lms-section-title">Available surveys</h1><p>Choose a survey, share your perspective, and help improve your learning experience.</p></div></div>
  <?php if ( empty( $allowed_survey_ids ) ) : ?>
    <div class="empty-state"><strong>Survey access is not assigned yet.</strong><br><span class="lms-muted">Please select your instructor and class in your profile to unlock your surveys.</span></div>
  <?php elseif ( $surveys ) : ?>
    <div class="survey-grid">
      <?php foreach ( $surveys as $i => $survey ) :
        $description = get_post_meta( $survey->ID, '_survey_description', true );
        $start = get_post_meta( $survey->ID, '_survey_start_date', true );
        $end = get_post_meta( $survey->ID, '_survey_end_date', true );
        $questions = sslms_get_survey_questions( $survey->ID );
        $survey_response = sslms_get_student_response( $survey->ID, get_current_user_id() );
        $survey_link = get_permalink( $survey->ID );
        $completed_pages = get_pages( array( 'meta_key' => '_wp_page_template', 'meta_value' => 'page-my-surveys.php', 'post_status' => 'publish', 'number' => 1 ) );
        $completed_url = ! empty( $completed_pages ) ? get_permalink( $completed_pages[0]->ID ) : home_url( '/my-completed-surveys/' );
        $review_link = $survey_response ? add_query_arg( 'response_id', $survey_response->ID, $completed_url ) : '';
      ?>
      <article class="lms-card survey-card">
        <div class="survey-card__image-wrap">
          <img class="survey-card__image" src="<?php echo esc_url( sslms_image_url( $i + 1 ) ); ?>" alt="Learning activity">
          <span class="survey-card__number"><?php echo esc_html( $i + 1 ); ?></span>
        </div>
        <div class="survey-card__body">
          <span class="survey-card__tag">Feedback</span>
          <h3><?php echo esc_html( get_the_title( $survey ) ); ?></h3>
          <p><?php echo esc_html( $description ? wp_trim_words( $description, 18 ) : 'Share your thoughts and help improve the learning experience.' ); ?></p>
          <div class="survey-card__meta"><span><?php echo esc_html( count( $questions ) ); ?> questions</span><?php if ( $start && $end ) : ?><span><?php echo esc_html( $start ); ?> → <?php echo esc_html( $end ); ?></span><?php endif; ?></div>
          <?php if ( $survey_response ) : ?>
            <a class="survey-card__link" href="<?php echo esc_url( $review_link ); ?>">Review my answers</a>
          <?php else : ?>
            <a class="survey-card__link" href="<?php echo esc_url( $survey_link ); ?>">Start survey</a>
          <?php endif; ?>
        </div>
      </article>
      <?php endforeach; ?>
    </div>
    <?php if ( $survey_query && $survey_query->max_num_pages > 1 ) : ?><nav class="survey-pagination" aria-label="Available survey pagination"><?php if ( $survey_page > 1 ) : ?><a aria-label="Previous page of surveys" href="<?php echo esc_url( add_query_arg( 'survey_page', $survey_page - 1 ) ); ?>"><span aria-hidden="true">←</span> Previous</a><?php endif; ?><span>Page <?php echo esc_html( $survey_page ); ?> of <?php echo esc_html( $survey_query->max_num_pages ); ?></span><?php if ( $survey_page < $survey_query->max_num_pages ) : ?><a aria-label="Next page of surveys" href="<?php echo esc_url( add_query_arg( 'survey_page', $survey_page + 1 ) ); ?>">Next <span aria-hidden="true">→</span></a><?php endif; ?></nav><?php endif; ?>
  <?php else : ?>
    <div class="empty-state"><strong>No surveys available yet.</strong><br><span class="lms-muted">New learning surveys will appear here when they are published.</span></div>
  <?php endif; ?>
</section>
<?php get_footer(); ?>
