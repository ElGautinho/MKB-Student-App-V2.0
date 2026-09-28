<?php
/* Template Name: Student Dashboard */
get_header();
if ( ! sslms_is_student() ) {
    echo '<section class="lms-page"><div class="survey-permission"><strong>Student dashboard</strong><br>Please sign in with a student account to access your learning dashboard.</div></section>';
    get_footer(); return;
}
$user = wp_get_current_user();
$responses = get_posts( array( 'post_type'=>'response', 'post__in'=>sslms_get_available_response_ids( array( 'author' => get_current_user_id() ) ), 'author'=>get_current_user_id(), 'posts_per_page'=>-1, 'orderby'=>'date', 'order'=>'DESC' ) );
$completed_count = count( $responses );
$survey_count = wp_count_posts( 'survey' );
$total_surveys = isset($survey_count->publish) ? (int)$survey_count->publish : 0;
$latest = array_slice( $responses, 0, 3 );
$completed_page = get_pages( array( 'meta_key'=>'_wp_page_template', 'meta_value'=>'page-my-surveys.php', 'post_status'=>'publish', 'number'=>1 ) );
$completed_url = !empty($completed_page) ? get_permalink($completed_page[0]->ID) : home_url('/my-completed-surveys/');
$survey_url = home_url('/survey/');
?>
<section class="lms-page student-dashboard">
  <div class="dashboard-welcome">
    <div>
      <p class="lms-kicker">MKB Student Survey</p>
      <h1>Welcome back, <?php echo esc_html( $user->display_name ?: $user->user_login ); ?> 👋</h1>
      <p>Stay on top of your learning feedback, complete new surveys and revisit your previous responses anytime.</p>
      <div class="lms-actions"><a class="lms-btn" href="<?php echo esc_url($survey_url); ?>">Browse surveys <span aria-hidden="true">→</span></a><a class="lms-btn lms-btn--ghost" href="<?php echo esc_url($completed_url); ?>">Completed surveys</a></div>
    </div>
    <div class="dashboard-welcome__visual"><img src="<?php echo esc_url( sslms_dashboard_image_url() ); ?>" alt="Students learning together"><div class="dashboard-badge"><strong><?php echo esc_html($completed_count); ?></strong><span>completed</span></div></div>
  </div>
  <div class="dashboard-stats">
    <article class="dashboard-stat"><span class="dashboard-stat__icon">📚</span><div><strong><?php echo esc_html($total_surveys); ?></strong><span>Available surveys</span></div></article>
    <article class="dashboard-stat"><span class="dashboard-stat__icon dashboard-stat__icon--green">✓</span><div><strong><?php echo esc_html($completed_count); ?></strong><span>Completed surveys</span></div></article>
    <article class="dashboard-stat"><span class="dashboard-stat__icon dashboard-stat__icon--gold">↗</span><div><strong><?php echo $total_surveys ? esc_html( min(100, round(($completed_count/$total_surveys)*100)) ) . '%' : '0%'; ?></strong><span>Your activity</span></div></article>
  </div>
  <div class="dashboard-grid">
    <section class="lms-card dashboard-panel">
      <div class="dashboard-panel__head"><div><p class="lms-kicker">Your history</p><h2>Completed surveys</h2></div><a href="<?php echo esc_url($completed_url); ?>">View all →</a></div>
      <?php if ($latest) : ?><div class="dashboard-history"><?php foreach($latest as $response) : $sid=absint(get_post_meta($response->ID,'_response_survey_id',true)); $title=get_the_title($sid); $link=add_query_arg('response_id',$response->ID,$completed_url); ?><a class="history-item" href="<?php echo esc_url($link); ?>"><span class="history-check">✓</span><span><strong><?php echo esc_html($title ?: 'Survey submission'); ?></strong><small>Submitted <?php echo esc_html(get_the_date('', $response)); ?></small></span><span class="history-arrow">→</span></a><?php endforeach; ?></div>
      <?php else : ?><div class="dashboard-empty"><span>📝</span><strong>No completed surveys yet</strong><p>Your submitted surveys will appear here.</p><a class="lms-btn" href="<?php echo esc_url($survey_url); ?>">Start a survey</a></div><?php endif; ?>
    </section>
    <aside class="lms-card dashboard-panel dashboard-quick"><p class="lms-kicker">Quick access</p><h2>Keep learning</h2><a class="quick-link quick-link--primary" href="<?php echo esc_url($survey_url); ?>"><span>🧭</span><span><strong>Available surveys</strong><small>Find a survey to complete</small></span><b>→</b></a><a class="quick-link" href="<?php echo esc_url($completed_url); ?>"><span>📋</span><span><strong>Completed surveys</strong><small>Review your answers &amp; feedback</small></span><b>→</b></a><a class="quick-link" href="<?php echo esc_url( sslms_student_chat_url() ); ?>"><span>💬</span><span><strong>Chat</strong><small>Ask a question or share an update</small></span><b>→</b></a><div class="dashboard-tip"><strong>💡 Tip</strong><p>Revisit instructor feedback to see how your learning journey is developing.</p></div></aside>
  </div>
</section>
<?php get_footer(); ?>
