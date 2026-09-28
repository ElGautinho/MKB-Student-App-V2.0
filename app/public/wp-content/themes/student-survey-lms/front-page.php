<?php
/* Template Name: Home Context */
get_header();
$survey_count = wp_count_posts( 'survey' );
$total_surveys = isset( $survey_count->publish ) ? (int) $survey_count->publish : 0;
$completed = sslms_is_student() ? count( sslms_get_available_response_ids( array( 'author' => get_current_user_id() ) ) ) : 0;
$feedback_args = array( 'meta_query' => array( array( 'key' => '_response_feedback', 'value' => '', 'compare' => '!=' ) ) );
$feedback_response_ids = sslms_get_available_response_ids( $feedback_args );
$mentor_feedback_count = count( $feedback_response_ids );
if ( sslms_is_student() ) { $feedback_response_ids = sslms_get_available_response_ids( array_merge( $feedback_args, array( 'author' => get_current_user_id() ) ) ); $mentor_feedback_count = count( $feedback_response_ids ); }
?>
<section class="lms-page">
  <div class="lms-hero">
    <div class="lms-hero__copy">
      <p class="lms-kicker">Your learning hub</p>
      <h1>Learn, reflect &amp; <span>shape better learning.</span></h1>
      <p>Discover your surveys, share thoughtful feedback, and help instructors create learning experiences that truly work for students.</p>
      <div class="lms-actions">
        <?php if ( sslms_is_student() ) : ?>
          <a class="lms-btn" href="<?php echo esc_url( home_url( '/survey/' ) ); ?>">Explore surveys <span aria-hidden="true">&nbsp;→</span></a>
        <?php else : ?>
          <a class="lms-btn" href="<?php echo esc_url( wp_login_url() ); ?>">Get started <span aria-hidden="true">&nbsp;→</span></a>
        <?php endif; ?>
        <a class="lms-btn lms-btn--ghost" href="<?php echo esc_url( home_url( '/about/' ) ); ?>">How it works</a>
      </div>
    </div>
    <div class="lms-hero__visual">
      <img class="lms-hero__image" src="<?php echo esc_url( sslms_dashboard_image_url() ); ?>" alt="Students collaborating while studying">
      <div class="lms-float-card">
        <span class="lms-float-icon" aria-hidden="true">✓</span>
        <span><strong>Every voice matters</strong><small>Feedback helps improve the next lesson</small></span>
      </div>
    </div>
  </div>

  <div class="lms-stat-strip">
    <div class="lms-stat"><strong><?php echo esc_html( $total_surveys ); ?></strong><span>Published surveys</span></div>
    <div class="lms-stat"><strong><?php echo esc_html( $completed ); ?></strong><span>Your completed surveys</span></div>
    <div class="lms-stat"><strong><?php echo esc_html( $mentor_feedback_count ); ?></strong><span>Mentor feedback received</span></div>
  </div>

  <div class="lms-feature-grid">
    <article class="lms-card lms-feature"><div class="lms-feature__icon">🎯</div><h3>Focused learning</h3><p>See the surveys and feedback activities relevant to your learning journey.</p></article>
    <article class="lms-card lms-feature"><div class="lms-feature__icon">💬</div><h3>Your voice matters</h3><p>Share clear, useful feedback in a calm and simple experience.</p></article>
    <article class="lms-card lms-feature"><div class="lms-feature__icon">📈</div><h3>Track your progress</h3><p>Review your completed surveys and instructor feedback whenever you need it.</p></article>
  </div>
</section>
<?php get_footer(); ?>
