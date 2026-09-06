<?php
get_header();

if (!current_user_can('student')) {
    echo "<section class='lms-page'><p class='alert'>You do not have permission to view this survey.</p></section>";
    get_footer(); exit;
}

$survey_id = get_the_ID();
$title = get_the_title();
$description = get_post_meta($survey_id, '_survey_description', true);
$start_date = get_post_meta($survey_id, '_survey_start_date', true);
$end_date = get_post_meta($survey_id, '_survey_end_date', true);
$user_id = get_current_user_id();
$already_responded = false;

if (is_user_logged_in()) {
    $existing_response = get_posts([
        'post_type' => 'response',
        'meta_key' => '_response_survey_id',
        'meta_value' => $survey_id,
        'author' => $user_id,
        'posts_per_page' => 1
    ]);
    if ($existing_response) $already_responded = true;
}

$success_message = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['answer']) && is_user_logged_in() && !$already_responded) {
    $answers = $_POST['answer'];
    $validation_errors = [];
    $clean_answers = [];

    $required_posts = get_posts([
        'post_type' => 'question',
        'meta_query' => [
            ['key'=>'_question_parent_survey','value'=>$survey_id,'compare'=>'='],
            ['key'=>'_question_required','value'=>'1','compare'=>'='],
        ],
        'posts_per_page' => -1,
        'fields' => 'ids'
    ]);

    foreach ($required_posts as $req_qid) {
        if (!isset($answers[$req_qid])) $validation_errors[] = $req_qid;
    }

    foreach ($answers as $question_id => $response) {
        $is_required = get_post_meta($question_id, '_question_required', true) === '1';
        if ($is_required) {
            if (is_array($response)) {
                $empty = true;
                foreach ($response as $r) { if (strlen(trim($r)) > 0) { $empty = false; break; } }
                if ($empty) $validation_errors[] = $question_id;
            } elseif (strlen(trim($response)) === 0) {
                $validation_errors[] = $question_id;
            }
        }
        $clean_answers[$question_id] = is_array($response)
            ? array_map('sanitize_text_field', $response)
            : sanitize_text_field($response);
    }

    if (!empty($validation_errors)) {
        $success_message = '<div class="survey-error"><strong>Almost there.</strong><br>Please fill all required questions before submitting.</div>';
    } else {
        $response_post = [
            'post_type' => 'response',
            'post_title' => 'Response for Survey #' . $survey_id . ' by User #' . $user_id,
            'post_status' => 'publish',
            'post_author' => $user_id,
        ];
        $response_id = wp_insert_post($response_post);
        if ($response_id && !is_wp_error($response_id)) {
            update_post_meta($response_id, '_response_survey_id', $survey_id);
            update_post_meta($response_id, '_response_student_id', $user_id);
            update_post_meta($response_id, '_response_answers', $clean_answers);
            $success_message = '<div class="survey-success"><strong>Response submitted!</strong><br>Thank you for helping improve the learning experience.</div>';
        } else {
            $success_message = '<div class="survey-error"><strong>Something went wrong.</strong><br>Your responses could not be saved.</div>';
        }
    }
}

$questions = get_posts([
    'post_type' => 'question',
    'meta_key' => '_question_parent_survey',
    'meta_value' => $survey_id,
    'orderby' => 'menu_order',
    'order' => 'ASC',
    'posts_per_page' => -1,
]);
?>

<section id="survey-wrapper" class="survey-shell">
    <div class="survey-hero">
        <p class="lms-kicker" style="color:#bfc2ff;">Learning survey</p>
        <h1><?php echo esc_html($title); ?></h1>
        <?php if ($description) : ?><p class="survey-description"><?php echo esc_html($description); ?></p><?php endif; ?>
        <?php if ($start_date && $end_date) : ?><p class="survey-dates"><strong>Available:</strong>&nbsp; <?php echo esc_html($start_date); ?> → <?php echo esc_html($end_date); ?></p><?php endif; ?>
    </div>

    <?php if ($success_message) echo $success_message; ?>

    <?php if ($already_responded) : ?>
        <div class="survey-info"><strong>You have already completed this survey.</strong><br>Thank you for sharing your feedback.</div>
    <?php elseif ($questions) : ?>
        <form id="survey-form" method="post" autocomplete="off">
            <?php $total = count($questions); foreach ($questions as $i => $question) :
                $question_id = $question->ID;
                $question_text = $question->post_title;
                $question_type = get_post_meta($question_id, '_question_type', true);
                $is_required = get_post_meta($question_id, '_question_required', true) === '1';
                $options = get_post_meta($question_id, '_question_answer_options', true);
                $options_array = $options ? array_filter(array_map('trim', explode("\n", $options))) : [];
            ?>
            <fieldset class="survey-question <?php echo ($is_required && in_array($question_type, ['multiple_choice','checkbox'], true)) ? 'required-group' : ''; ?>">
                <legend>Question <?php echo ($i + 1) . ' / ' . $total; ?></legend>
                <p><?php echo esc_html($question_text); ?> <?php if ($is_required) : ?><span aria-label="required" style="color:#c3445c">*</span><?php endif; ?></p>
                <?php switch ($question_type) {
                    case 'text':
                        echo '<input type="text" name="answer['.$question_id.']" '.($is_required?'required':'').' class="form-control" placeholder="Type your answer...">'; break;
                    case 'multiple_choice':
                    case 'checkbox':
                        foreach ($options_array as $opt) echo '<label><input type="checkbox" name="answer['.$question_id.'][]" value="'.esc_attr($opt).'"> '.esc_html($opt).'</label>';
                        break;
                    case 'radio_button':
                        foreach ($options_array as $opt) echo '<label><input type="radio" name="answer['.$question_id.']" value="'.esc_attr($opt).'" '.($is_required?'required':'').'> '.esc_html($opt).'</label>';
                        break;
                    case 'dropdown':
                        if ($options_array) { echo '<select name="answer['.$question_id.']" '.($is_required?'required':'').'><option value="">Choose an option</option>'; foreach ($options_array as $opt) echo '<option value="'.esc_attr($opt).'">'.esc_html($opt).'</option>'; echo '</select>'; }
                        break;
                    case 'true_false':
                        echo '<label><input type="radio" name="answer['.$question_id.']" value="true" '.($is_required?'required':'').'> True</label><label><input type="radio" name="answer['.$question_id.']" value="false" '.($is_required?'required':'').'> False</label>'; break;
                    case 'email': echo '<input type="email" name="answer['.$question_id.']" '.($is_required?'required':'').' class="form-control" placeholder="you@example.com">'; break;
                    case 'phone': echo '<input type="tel" name="answer['.$question_id.']" '.($is_required?'required':'').' class="form-control" placeholder="Your phone number">'; break;
                    case 'text_array': echo '<textarea name="answer['.$question_id.']" '.($is_required?'required':'').' class="form-control" placeholder="Enter multiple lines..."></textarea>'; break;
                    case 'date': echo '<input type="date" name="answer['.$question_id.']" '.($is_required?'required':'').' class="form-control">'; break;
                    case 'number': echo '<input type="number" name="answer['.$question_id.']" '.($is_required?'required':'').' class="form-control">'; break;
                    case 'file_upload': echo '<input type="file" name="answer['.$question_id.']" '.($is_required?'required':'').' class="form-control">'; break;
                    case 'time': echo '<input type="time" name="answer['.$question_id.']" '.($is_required?'required':'').' class="form-control">'; break;
                    case 'range': echo '<input type="range" name="answer['.$question_id.']" min="0" max="100" class="form-control">'; break;
                    case 'textarea': echo '<textarea name="answer['.$question_id.']" '.($is_required?'required':'').' class="form-control" placeholder="Share your thoughts..."></textarea>'; break;
                    default: echo '<input type="text" name="answer['.$question_id.']" required class="form-control" placeholder="Type your answer...">';
                } ?>
            </fieldset>
            <?php endforeach; ?>
            <div class="survey-navigation"><button type="submit" id="submit-btn">Submit responses&nbsp; →</button></div>
            <p id="progress"><?php echo esc_html($total); ?> questions · Fields marked * are required</p>
        </form>
    <?php else : ?>
        <div class="empty-state">No questions found for this survey.</div>
    <?php endif; ?>
</section>

<script>
document.addEventListener('DOMContentLoaded', function () {
    var form = document.getElementById('survey-form');
    if (!form) return;
    form.addEventListener('submit', function (e) {
        var groups = document.querySelectorAll('.survey-question.required-group');
        for (var i = 0; i < groups.length; i++) {
            var checkboxes = groups[i].querySelectorAll('input[type="checkbox"]');
            var ok = false;
            for (var j = 0; j < checkboxes.length; j++) if (checkboxes[j].checked) ok = true;
            if (!ok) {
                e.preventDefault();
                groups[i].style.outline = '3px solid rgba(195,68,92,.28)';
                groups[i].scrollIntoView({behavior:'smooth', block:'center'});
                alert('Please select at least one option for the required checkbox questions.');
                return;
            }
            groups[i].style.outline = '';
        }
    });
});
</script>
<?php get_footer(); ?>
