<?php
/**
 * Template Name: My Survey Archive
 */
if ( ! is_user_logged_in() ) { auth_redirect(); exit; }

$user_id = get_current_user_id();
$paged = isset( $_GET['survey_page'] ) ? max( 1, absint( $_GET['survey_page'] ) ) : 1;
$responses = sslms_get_student_responses_paginated( $user_id, $paged, 4 );
?>
<?php get_header(); ?>
<main class="lms-main survey-archive-page">
  <div class="lms-container">
    <div class="archive-heading">
      <div>
        <p class="lms-kicker">My learning history</p>
        <h1>My Survey Archive</h1>
        <p>All surveys you have submitted, organized four at a time. Your answers remain read-only after submission.</p>
      </div>
      <a class="lms-button lms-button-secondary" href="<?php echo esc_url( home_url( '/my-profile/' ) ); ?>">My Profile</a>
    </div>

    <?php if ( $responses->have_posts() ) : ?>
      <div class="survey-archive-grid">
        <?php while ( $responses->have_posts() ) : $responses->the_post();
          $response = get_post();
          $survey_id = absint( get_post_meta( $response->ID, '_response_survey_id', true ) );
          $survey = $survey_id ? get_post( $survey_id ) : null;
          $answers = get_post_meta( $response->ID, '_response_answers', true );
          $answer_count = is_array( $answers ) ? count( array_filter( $answers, function( $v ) { return $v !== '' && $v !== array(); } ) ) : 0;
          $review_url = $survey ? add_query_arg( 'response_id', $response->ID, get_permalink( $survey->ID ) ) : '#';
        ?>
          <article class="archive-survey-card">
            <div class="archive-card-top">
              <span class="archive-status">Completed</span>
              <span class="archive-date"><?php echo esc_html( get_the_date( 'M j, Y', $response ) ); ?></span>
            </div>
            <h2><?php echo esc_html( $survey ? get_the_title( $survey ) : 'Survey' ); ?></h2>
            <p class="archive-meta"><?php echo esc_html( $answer_count ); ?> answers submitted</p>
            <a class="lms-button" href="<?php echo esc_url( $review_url ); ?>">Review my answers</a>
          </article>
        <?php endwhile; wp_reset_postdata(); ?>
      </div>

      <?php
      $total_pages = (int) $responses->max_num_pages;
      if ( $total_pages > 1 ) :
      ?>
        <nav class="survey-pagination" aria-label="Survey archive pagination">
          <?php if ( $paged > 1 ) : ?>
            <a href="<?php echo esc_url( add_query_arg( 'survey_page', $paged - 1 ) ); ?>">← Previous</a>
          <?php endif; ?>
          <span>Page <?php echo esc_html( $paged ); ?> of <?php echo esc_html( $total_pages ); ?></span>
          <?php if ( $paged < $total_pages ) : ?>
            <a href="<?php echo esc_url( add_query_arg( 'survey_page', $paged + 1 ) ); ?>">Next →</a>
          <?php endif; ?>
        </nav>
      <?php endif; ?>

    <?php else : ?>
      <div class="lms-card empty-state">
        <h2>No completed surveys yet</h2>
        <p>Your submitted surveys will appear here once you complete one.</p>
      </div>
    <?php endif; ?>
  </div>
</main>
<?php get_footer(); ?>
