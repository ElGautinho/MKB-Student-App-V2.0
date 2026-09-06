<?php
/* Template Name: My Completed Surveys */
get_header();
if (!is_user_logged_in() || !current_user_can('student')) {
    echo '<section class="lms-page"><div class="survey-permission"><strong>Access restricted</strong><br>You do not have permission to view this page.</div></section>';
    get_footer(); exit;
}
$user_id = get_current_user_id();
$responses = get_posts(['post_type'=>'response','author'=>$user_id,'posts_per_page'=>-1]);
?>
<section class="lms-page">
    <div class="lms-toolbar"><div><p class="lms-kicker">Your learning activity</p><h1 class="lms-section-title">Completed surveys</h1><p>Review what you have submitted and any instructor feedback.</p></div></div>
    <?php if ($responses) : ?>
    <div class="my-surveys-layout">
        <aside class="lms-card completed-list">
            <h2>Your submissions</h2>
            <ul class="survey-list">
            <?php foreach ($responses as $response) :
                $survey_id = get_post_meta($response->ID, '_response_survey_id', true);
                $survey_title = get_the_title($survey_id);
                $view_link = add_query_arg(['survey_id'=>$survey_id,'response_id'=>$response->ID], get_permalink());
            ?>
                <li class="survey-list-item"><a href="<?php echo esc_url($view_link); ?>" class="survey-link"><?php echo esc_html($survey_title); ?></a></li>
            <?php endforeach; ?>
            </ul>
        </aside>
        <?php if (isset($_GET['survey_id']) && isset($_GET['response_id'])) :
            $survey_id = intval($_GET['survey_id']); $response_id = intval($_GET['response_id']);
            $answers = get_post_meta($response_id, '_response_answers', true);
            $feedback = get_post_meta($response_id, '_response_feedback', true);
            $questions = get_posts(['post_type'=>'question','meta_key'=>'_question_parent_survey','meta_value'=>$survey_id,'orderby'=>'menu_order','order'=>'ASC','posts_per_page'=>-1]);
        ?>
        <div class="lms-card survey-answers-block">
            <p class="lms-kicker">Submission review</p>
            <h2 class="answers-title"><?php echo esc_html(get_the_title($survey_id)); ?></h2>
            <?php if ($questions) : ?><ul class="question-list">
                <?php foreach ($questions as $question) : $question_id=$question->ID; $answer=isset($answers[$question_id])?$answers[$question_id]:''; ?>
                    <li class="question-list-item"><span class="question-label"><?php echo esc_html($question->post_title); ?></span><span class="answer-value"><?php echo esc_html(is_array($answer)?implode(', ',$answer):$answer); ?></span></li>
                <?php endforeach; ?>
            </ul><?php else : ?><div class="no-questions">No questions found for this survey.</div><?php endif; ?>
            <?php if (!empty($feedback)) : ?><div class="instructor-feedback"><strong>Instructor feedback</strong><br><?php echo esc_html($feedback); ?></div><?php endif; ?>
        </div>
        <?php else : ?>
        <div class="lms-card survey-answers-block"><p class="lms-kicker">Ready to review?</p><h2 class="answers-title">Select a completed survey</h2><p class="lms-muted">Choose a submission from the left to see your answers and feedback.</p></div>
        <?php endif; ?>
    </div>
    <?php else : ?>
        <div class="empty-state"><strong>You have not completed any surveys yet.</strong><br><span class="lms-muted">Your completed surveys will appear here.</span></div>
    <?php endif; ?>
</section>
<?php get_footer(); ?>
