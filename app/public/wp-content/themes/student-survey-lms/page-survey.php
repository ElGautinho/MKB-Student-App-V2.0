<?php
/* Template Name: Survey Page */
// Compatibility route: /survey/?survey_id=123 redirects into the canonical survey template.
$survey_id = isset( $_GET['survey_id'] ) ? absint( $_GET['survey_id'] ) : 0;
if ( $survey_id && get_post_type( $survey_id ) === 'survey' ) {
    wp_safe_redirect( get_permalink( $survey_id ) );
    exit;
}

get_header();
if ( ! sslms_is_student() ) {
    echo '<section class="lms-page"><div class="survey-permission"><strong>Sign in required.</strong><br>Please sign in as a student to access available surveys.</div></section>';
    get_footer();
    return;
}

$allowed_survey_ids = sslms_get_student_visible_survey_ids();
$surveys = ! empty( $allowed_survey_ids ) ? get_posts( array( 'post_type' => 'survey', 'post_status' => 'publish', 'post__in' => $allowed_survey_ids, 'posts_per_page' => -1, 'orderby' => 'date', 'order' => 'DESC' ) ) : array();
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
        $completed_pages = get_pages( array( 'meta_key' => '_wp_page_template', 'meta_value' => 'page-my-surveys.php', 'post_status' => 'publish', 'number' => 1 ) );
        $completed_url = ! empty( $completed_pages ) ? get_permalink( $completed_pages[0]->ID ) : home_url( '/my-completed-surveys/' );
        $review_link = $survey_response ? add_query_arg( 'response_id', $survey_response->ID, $completed_url ) : '';
      ?>
      <article class="lms-card survey-card">
        <div class="survey-card__image-wrap"><img class="survey-card__image" src="<?php echo esc_url( get_the_post_thumbnail_url( $survey->ID, 'large' ) ?: sslms_image_url( $i + 1 ) ); ?>" alt="<?php echo esc_attr( get_the_title( $survey ) ); ?>"><span class="survey-card__number"><?php echo esc_html( $i + 1 ); ?></span></div>
        <div class="survey-card__body"><span class="survey-card__tag">Feedback</span><h3><?php echo esc_html( get_the_title( $survey ) ); ?></h3><p><?php echo esc_html( $description ? wp_trim_words( $description, 18 ) : 'Share your thoughts and help improve the learning experience.' ); ?></p><div class="survey-card__meta"><span><?php echo esc_html( count( $questions ) ); ?> questions</span><?php if ( $start && $end ) : ?><span><?php echo esc_html( $start ); ?> → <?php echo esc_html( $end ); ?></span><?php endif; ?></div><?php if ( $survey_response ) : ?>
            <a class="survey-card__link" href="<?php echo esc_url( $review_link ); ?>">Review my answers</a>
          <?php else : ?>
            <a class="survey-card__link" href="<?php echo esc_url( get_permalink( $survey->ID ) ); ?>">Start survey</a>
          <?php endif; ?></div>
      </article>
      <?php endforeach; ?>
    </div>
  <?php else : ?><div class="empty-state"><strong>No surveys available yet.</strong><br><span class="lms-muted">New learning surveys will appear here when they are published.</span></div><?php endif; ?>
</section>
<?php get_footer(); ?>
