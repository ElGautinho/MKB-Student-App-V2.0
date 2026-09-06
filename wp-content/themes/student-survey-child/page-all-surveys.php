<?php
/* Template Name: All Surveys */
get_header();
if (!is_user_logged_in() || !current_user_can('student')) {
    echo '<section class="lms-page"><div class="survey-permission"><strong>Access restricted</strong><br>You do not have permission to view surveys.</div></section>';
    get_footer(); exit;
}
$surveys = new WP_Query(['post_type'=>'survey','posts_per_page'=>-1]);
?>
<section class="lms-page">
    <div class="lms-toolbar">
        <div><p class="lms-kicker">Learning hub</p><h1 class="lms-section-title">Available surveys</h1><p>Choose a survey and share your experience.</p></div>
        <span class="lms-kicker" style="margin-bottom:7px;">Student space</span>
    </div>
    <?php if ($surveys->have_posts()) : ?>
        <div class="survey-grid">
        <?php $image_index = 0; $images = [
            'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=900&q=80',
            'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=900&q=80',
            'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=900&q=80'
        ]; ?>
        <?php while ($surveys->have_posts()) : $surveys->the_post();
            $survey_id = get_the_ID();
            $survey_link = add_query_arg('survey_id', $survey_id, site_url('/take-survey/'));
            $description = get_post_meta($survey_id, '_survey_description', true);
        ?>
            <article class="lms-card survey-card">
                <img class="survey-card__image" src="<?php echo esc_url($images[$image_index % count($images)]); ?>" alt="Learning survey illustration">
                <div class="survey-card__body">
                    <span class="survey-card__tag">Survey</span>
                    <h3><?php echo esc_html(get_the_title()); ?></h3>
                    <p><?php echo esc_html($description ? wp_trim_words($description, 18) : 'Share your thoughts and help improve the learning experience.'); ?></p>
                    <a class="survey-card__link" href="<?php echo esc_url($survey_link); ?>">Start survey</a>
                </div>
            </article>
        <?php $image_index++; endwhile; wp_reset_postdata(); ?>
        </div>
    <?php else : ?>
        <div class="empty-state"><strong>No surveys available yet.</strong><br><span class="lms-muted">New learning surveys will appear here when they are published.</span></div>
    <?php endif; ?>
</section>
<?php get_footer(); ?>
