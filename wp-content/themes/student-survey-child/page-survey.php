<?php
/* Template Name: Survey Page */
get_header();
if (!is_user_logged_in() || !current_user_can('student')) {
    echo '<section class="lms-page"><div class="survey-permission"><strong>Access restricted</strong><br>You do not have permission to view this survey.</div></section>';
    get_footer(); return;
}
$survey_id = isset($_GET['survey_id']) ? intval($_GET['survey_id']) : 0;
if (!$survey_id) {
    echo '<section class="lms-page"><div class="survey-error">No survey specified.</div></section>';
    get_footer(); return;
}
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['survey_answers'])) {
    $answers = $_POST['survey_answers'];
    $user_id = get_current_user_id();
    foreach ($answers as $question_id => $answer) {
        add_post_meta($question_id, 'student_answer_' . $user_id, sanitize_text_field($answer));
    }
    echo '<section class="lms-page"><div class="survey-success"><strong>Your answers have been submitted.</strong><br>Thank you!</div></section>';
}
$questions = new WP_Query([
    'post_type' => 'question',
    'meta_query' => [['key'=>'_question_parent_survey','value'=>$survey_id,'compare'=>'=']],
    'posts_per_page' => -1
]);
?>
<section class="survey-shell">
    <div class="survey-hero">
        <p class="lms-kicker" style="color:#bfc2ff;">Learning survey</p>
        <h1><?php echo esc_html(get_the_title($survey_id)); ?></h1>
        <p class="survey-description">Share your thoughts and help improve the learning experience.</p>
    </div>
    <?php if ($questions->have_posts()) : ?>
    <form method="post" class="survey-form">
        <?php $i=0; while ($questions->have_posts()) : $questions->the_post(); $i++;
            $question_id=get_the_ID(); $question_text=get_the_title(); $question_type=get_post_meta($question_id,'question_type',true);
        ?>
        <fieldset class="survey-question">
            <legend>Question <?php echo esc_html($i); ?></legend>
            <p><?php echo esc_html($question_text); ?></p>
            <?php switch ($question_type) {
                case 'text': echo '<input type="text" name="survey_answers['.esc_attr($question_id).']" class="form-control" placeholder="Type your answer...">'; break;
                case 'radio':
                    $options=get_post_meta($question_id,'question_options',true); if ($options && is_array($options)) foreach ($options as $opt) echo '<label><input type="radio" name="survey_answers['.esc_attr($question_id).']" value="'.esc_attr($opt).'"> '.esc_html($opt).'</label>'; break;
                case 'dropdown':
                case 'multiple_choice':
                    $options=get_post_meta($question_id,'question_options',true); if ($options && is_array($options)) { echo '<select name="survey_answers['.esc_attr($question_id).']"><option value="">Choose an option</option>'; foreach ($options as $opt) echo '<option value="'.esc_attr($opt).'">'.esc_html($opt).'</option>'; echo '</select>'; } break;
                case 'textarea': echo '<textarea name="survey_answers['.esc_attr($question_id).']" class="form-control" placeholder="Share your thoughts..."></textarea>'; break;
                default: echo '<input type="text" name="survey_answers['.esc_attr($question_id).']" class="form-control" placeholder="Type your answer...">';
            } ?>
        </fieldset>
        <?php endwhile; wp_reset_postdata(); ?>
        <div class="survey-navigation"><button type="submit" id="submit-btn">Submit responses&nbsp; →</button></div>
    </form>
    <?php else : ?><div class="empty-state">No questions found for this survey.</div><?php endif; ?>
</section>
<?php get_footer(); ?>
