<?php
/* Template Name: Instructor Dashboard */
if ( ! sslms_is_instructor() ) {
  get_header();
    echo '<section class="lms-page"><div class="survey-permission"><strong>Instructor access required.</strong><br>Please sign in with an instructor account to manage surveys.</div></section>';
    get_footer(); return;
}
$status = sslms_instructor_handle_actions();
if ( $status ) {
  $redirect_args = array( 'sslms_status' => $status );
  if ( ! empty( $_POST['survey_id'] ) ) { $redirect_args['survey_id'] = absint( $_POST['survey_id'] ); }
  if ( ! empty( $_POST['question_survey_id'] ) ) { $redirect_args['survey_id'] = absint( $_POST['question_survey_id'] ); }
  wp_safe_redirect( add_query_arg( $redirect_args, get_permalink() ) );
  exit;
}
$status = sanitize_key( $_GET['sslms_status'] ?? '' );
$user_id = get_current_user_id();
$survey_view = sanitize_key( $_GET['survey_view'] ?? 'active' );
$survey_search = sanitize_text_field( wp_unslash( $_GET['survey_search'] ?? '' ) );
$survey_page = max( 1, absint( $_GET['survey_page'] ?? 1 ) );
$student_page = max( 1, absint( $_GET['student_page'] ?? 1 ) );
$response_search = sanitize_text_field( wp_unslash( $_GET['response_search'] ?? '' ) );
$response_page = max( 1, absint( $_GET['response_page'] ?? 1 ) );
$new_survey = isset( $_GET['new_survey'] ) && '1' === $_GET['new_survey'];
$survey_args = array( 'post_type' => 'survey', 'post_status' => array( 'publish', 'draft', 'pending', 'private' ), 'author' => $user_id, 'posts_per_page' => 6, 'paged' => $survey_page, 'orderby' => 'date', 'order' => 'DESC' );
if ( $survey_search ) { $survey_args['s'] = $survey_search; }
if ( 'archived' === $survey_view ) {
  $survey_args['meta_key'] = '_survey_archived';
  $survey_args['meta_value'] = '1';
} elseif ( 'all' === $survey_view ) {
  $survey_args['meta_query'] = array( 'relation' => 'OR', array( 'key' => '_survey_archived', 'compare' => 'NOT EXISTS' ), array( 'key' => '_survey_archived', 'value' => '1', 'compare' => '!=' ) );
} else {
  $survey_args['meta_query'] = array( 'relation' => 'OR', array( 'key' => '_survey_archived', 'compare' => 'NOT EXISTS' ), array( 'key' => '_survey_archived', 'value' => '1', 'compare' => '!=' ) );
}
$survey_query = new WP_Query( $survey_args );
$surveys = $survey_query->posts;
$selected_id = absint( $_GET['survey_id'] ?? 0 );
$selected = $new_survey ? null : ( $selected_id ? get_post( $selected_id ) : ( $surveys ? $surveys[0] : null ) );
if ( $selected && ! sslms_instructor_can_manage_survey( $selected->ID ) ) { $selected = null; }
$students_query = new WP_User_Query( array( 'role' => 'student', 'number' => 3, 'offset' => ( $student_page - 1 ) * 3, 'count_total' => true, 'orderby' => 'display_name', 'order' => 'ASC', 'meta_key' => '_sslms_assigned_instructor_id', 'meta_value' => $user_id ) );
$students = $students_query->get_results();
$student_ids = wp_list_pluck( $students, 'ID' );
$all_responses = $selected ? get_posts( array( 'post_type' => 'response', 'post_status' => 'publish', 'posts_per_page' => -1, 'meta_key' => '_response_survey_id', 'meta_value' => $selected->ID, 'orderby' => 'date', 'order' => 'DESC' ) ) : array();
$filtered_responses = array();
foreach ( $all_responses as $response ) {
  $student_id = absint( get_post_meta( $response->ID, '_response_student_id', true ) );
  $student = get_userdata( $student_id );
  $answers = get_post_meta( $response->ID, '_response_answers', true );
  $feedback = (string) get_post_meta( $response->ID, '_response_feedback', true );
  $answer_text = is_array( $answers ) ? implode( ' ', array_map( function( $answer ) { return is_array( $answer ) ? implode( ' ', $answer ) : (string) $answer; }, $answers ) ) : (string) $answers;
  $search_text = implode( ' ', array_filter( array( $response->post_title, $student ? $student->display_name : '', $student ? $student->user_email : '', $answer_text, $feedback ) ) );
  if ( ! $response_search || false !== stripos( $search_text, $response_search ) ) {
    $filtered_responses[] = $response;
  }
}
$response_total = count( $filtered_responses );
$response_total_pages = max( 1, (int) ceil( $response_total / 3 ) );
$response_page = min( $response_page, $response_total_pages );
$responses = array_slice( $filtered_responses, ( $response_page - 1 ) * 3, 3 );
sslms_notification_mark_seen( 'responses', wp_list_pluck( $responses, 'ID' ), $user_id );
$action_url = add_query_arg( $selected ? array( 'survey_id' => $selected->ID ) : array(), get_permalink() );
get_header();
?>
<section class="lms-page instructor-dashboard-page">
  <div class="lms-toolbar"><div><p class="lms-kicker">Instructor home</p><h1 class="lms-section-title">Manage your learning space</h1><p>Create surveys, shape questions, review responses and support the students assigned to you.</p></div><div class="lms-actions"><a class="lms-btn lms-btn--ghost" href="<?php echo esc_url( sslms_instructor_admin_chat_url() ); ?>">Chat <span aria-hidden="true">→</span></a><a class="lms-btn lms-btn--ghost" href="<?php echo esc_url( sslms_instructor_profile_url() ); ?>">My profile <span aria-hidden="true">→</span></a></div></div>
  <?php if ( 'saved' === $status || 'feedback_saved' === $status ) : ?><div class="profile-notice profile-notice--success">Your changes have been saved.</div><?php elseif ( 'archived' === $status ) : ?><div class="profile-notice profile-notice--success">Survey archived.</div><?php elseif ( 'unarchived' === $status ) : ?><div class="profile-notice profile-notice--success">Survey restored.</div><?php elseif ( 'deleted' === $status ) : ?><div class="profile-notice profile-notice--success">The item was deleted.</div><?php elseif ( 'error' === $status ) : ?><div class="profile-notice profile-notice--error">We could not save that change. Check the fields and try again.</div><?php endif; ?>

  <div class="dashboard-stats">
    <article class="dashboard-stat"><span class="dashboard-stat__icon">◈</span><div><strong><?php echo esc_html( $survey_query->found_posts ); ?></strong><span>Your surveys</span></div></article>
    <article class="dashboard-stat"><span class="dashboard-stat__icon dashboard-stat__icon--green">✓</span><div><strong><?php echo esc_html( count( $students ) ); ?></strong><span>Assigned students</span></div></article>
  </div>

  <div class="instructor-dashboard-grid">
    <section class="lms-card instructor-panel">
      <div class="dashboard-panel__head"><div><p class="lms-kicker">Survey library</p><h2>Your surveys</h2></div><a class="lms-btn" href="<?php echo esc_url( add_query_arg( array( 'new_survey' => '1', 'survey_view' => $survey_view, 'survey_search' => $survey_search ), get_permalink() ) . '#new-survey' ); ?>">New survey <span aria-hidden="true">+</span></a></div>
      <form class="instructor-survey-tools" method="get" action="<?php echo esc_url( $action_url ); ?>"><input type="search" name="survey_search" value="<?php echo esc_attr( $survey_search ); ?>" placeholder="Search surveys"><select name="survey_view"><option value="active" <?php selected( $survey_view, 'active' ); ?>>Active surveys</option><option value="all" <?php selected( $survey_view, 'all' ); ?>>All surveys</option><option value="archived" <?php selected( $survey_view, 'archived' ); ?>>Archived surveys</option></select><button class="lms-btn lms-btn--small" type="submit">Filter</button></form>
      <?php if ( $surveys ) : ?><div class="instructor-survey-list"><?php foreach ( $surveys as $survey ) : $archived = '1' === get_post_meta( $survey->ID, '_survey_archived', true ); ?><div class="instructor-survey-entry"><a class="instructor-survey-item<?php echo $selected && (int) $selected->ID === (int) $survey->ID ? ' is-selected' : ''; ?>" href="<?php echo esc_url( add_query_arg( array( 'survey_id' => $survey->ID, 'survey_view' => $survey_view, 'survey_search' => $survey_search ), $action_url ) ); ?>"><span><strong><?php echo esc_html( $survey->post_title ); ?></strong><small><?php echo $archived ? 'Archived' : esc_html( ucfirst( $survey->post_status ) ); ?> · <?php echo esc_html( count( sslms_get_survey_questions( $survey->ID ) ) ); ?> questions</small></span><b aria-hidden="true">→</b></a><form method="post" action="<?php echo esc_url( $action_url ); ?>"><?php wp_nonce_field( 'sslms_instructor_actions', 'sslms_instructor_nonce' ); ?><input type="hidden" name="instructor_action" value="toggle_archive_survey"><input type="hidden" name="survey_id" value="<?php echo esc_attr( $survey->ID ); ?>"><button type="submit"><?php echo $archived ? 'Restore' : 'Archive'; ?></button></form></div><?php endforeach; ?></div><?php if ( $survey_query->max_num_pages > 1 ) : ?><nav class="survey-pagination instructor-survey-pagination" aria-label="Survey library pagination"><?php if ( $survey_page > 1 ) : ?><a aria-label="Previous page of surveys" href="<?php echo esc_url( add_query_arg( array( 'survey_page' => $survey_page - 1, 'survey_view' => $survey_view, 'survey_search' => $survey_search ), $action_url ) ); ?>"><span aria-hidden="true">←</span> Previous</a><?php endif; ?><span>Page <?php echo esc_html( $survey_page ); ?> of <?php echo esc_html( $survey_query->max_num_pages ); ?></span><?php if ( $survey_page < $survey_query->max_num_pages ) : ?><a aria-label="Next page of surveys" href="<?php echo esc_url( add_query_arg( array( 'survey_page' => $survey_page + 1, 'survey_view' => $survey_view, 'survey_search' => $survey_search ), $action_url ) ); ?>">Next <span aria-hidden="true">→</span></a><?php endif; ?></nav><?php endif; ?><?php else : ?><div class="dashboard-empty"><strong>No matching surveys</strong><p>Create a new survey or change the search/filter.</p></div><?php endif; ?>
    </section>

    <section class="lms-card instructor-panel" id="new-survey">
      <p class="lms-kicker">Survey editor</p><h2><?php echo $selected ? 'Edit survey' : 'Create a survey'; ?></h2>
      <form class="instructor-form" method="post" action="<?php echo esc_url( $action_url ); ?>">
        <?php wp_nonce_field( 'sslms_instructor_actions', 'sslms_instructor_nonce' ); ?><input type="hidden" name="instructor_action" value="save_survey"><input type="hidden" name="survey_id" value="<?php echo esc_attr( $selected ? $selected->ID : 0 ); ?>">
        <label><span>Title</span><input type="text" name="survey_title" value="<?php echo esc_attr( $selected ? $selected->post_title : '' ); ?>" required></label>
        <label><span>Description</span><textarea name="survey_description" rows="3"><?php echo esc_textarea( $selected ? get_post_meta( $selected->ID, '_survey_description', true ) : '' ); ?></textarea></label>
        <div class="instructor-form-grid"><label><span>Class / group</span><input type="text" name="survey_class" value="<?php echo esc_attr( $selected ? get_post_meta( $selected->ID, '_survey_class', true ) : '' ); ?>" placeholder="e.g. B2 - Math"></label><label><span>Status</span><select name="survey_status"><option value="draft" <?php selected( $selected ? $selected->post_status : 'draft', 'draft' ); ?>>Draft</option><option value="publish" <?php selected( $selected ? $selected->post_status : '', 'publish' ); ?>>Published</option></select></label><label><span>Start date</span><input type="date" name="survey_start_date" value="<?php echo esc_attr( $selected ? get_post_meta( $selected->ID, '_survey_start_date', true ) : '' ); ?>"></label><label><span>End date</span><input type="date" name="survey_end_date" value="<?php echo esc_attr( $selected ? get_post_meta( $selected->ID, '_survey_end_date', true ) : '' ); ?>"></label></div>
        <label><span>Internal content</span><textarea name="survey_content" rows="2"><?php echo esc_textarea( $selected ? $selected->post_content : '' ); ?></textarea></label>
        <button class="lms-btn" type="submit">Save survey <span aria-hidden="true">→</span></button>
      </form>
      <?php if ( $selected ) : ?><form class="instructor-delete-form" method="post" action="<?php echo esc_url( $action_url ); ?>" onsubmit="return confirm('Delete this survey and its questions?');"><?php wp_nonce_field( 'sslms_instructor_actions', 'sslms_instructor_nonce' ); ?><input type="hidden" name="instructor_action" value="delete_survey"><input type="hidden" name="survey_id" value="<?php echo esc_attr( $selected->ID ); ?>"><button class="lms-btn lms-btn--danger" type="submit">Delete survey</button></form><?php endif; ?>
    </section>
  </div>

  <?php if ( $selected ) : $questions = sslms_get_survey_questions( $selected->ID ); ?>
  <section class="lms-card instructor-panel instructor-questions-panel"><div class="dashboard-panel__head"><div><p class="lms-kicker">Question builder</p><h2><?php echo esc_html( $selected->post_title ); ?></h2></div></div>
    <?php foreach ( $questions as $question ) : ?><form class="instructor-question-row" method="post" action="<?php echo esc_url( $action_url ); ?>"><?php wp_nonce_field( 'sslms_instructor_actions', 'sslms_instructor_nonce' ); ?><input type="hidden" name="instructor_action" value="save_question"><input type="hidden" name="question_survey_id" value="<?php echo esc_attr( $selected->ID ); ?>"><input type="hidden" name="question_id" value="<?php echo esc_attr( $question->ID ); ?>"><input type="text" name="question_title" value="<?php echo esc_attr( $question->post_title ); ?>" required><select name="question_type"><?php foreach ( array( 'text' => 'Text', 'multiple_choice' => 'Multiple choice', 'radio_button' => 'Radio', 'true_false' => 'True / false', 'checkbox' => 'Checkbox', 'dropdown' => 'Dropdown', 'textarea' => 'Long text', 'number' => 'Number', 'date' => 'Date' ) as $type => $label ) : ?><option value="<?php echo esc_attr( $type ); ?>" <?php selected( get_post_meta( $question->ID, '_question_type', true ), $type ); ?>><?php echo esc_html( $label ); ?></option><?php endforeach; ?></select><textarea name="question_options" rows="3" placeholder="One answer option per line"><?php echo esc_textarea( get_post_meta( $question->ID, '_question_answer_options', true ) ); ?></textarea><label class="instructor-check"><input type="checkbox" name="question_required" value="1" <?php checked( get_post_meta( $question->ID, '_question_required', true ), '1' ); ?>> Required</label><button class="lms-btn lms-btn--small" type="submit">Save</button></form><form class="instructor-inline-delete" method="post" action="<?php echo esc_url( $action_url ); ?>"><?php wp_nonce_field( 'sslms_instructor_actions', 'sslms_instructor_nonce' ); ?><input type="hidden" name="instructor_action" value="delete_question"><input type="hidden" name="question_id" value="<?php echo esc_attr( $question->ID ); ?>"><button type="submit">Remove</button></form><?php endforeach; ?>
    <form class="instructor-question-new" method="post" action="<?php echo esc_url( $action_url ); ?>"><p class="lms-kicker">Add question</p><?php wp_nonce_field( 'sslms_instructor_actions', 'sslms_instructor_nonce' ); ?><input type="hidden" name="instructor_action" value="save_question"><input type="hidden" name="question_survey_id" value="<?php echo esc_attr( $selected->ID ); ?>"><input type="text" name="question_title" placeholder="Write the question" required><select name="question_type"><option value="text">Text</option><option value="multiple_choice">Multiple choice</option><option value="radio_button">Radio</option><option value="true_false">True / false</option><option value="checkbox">Checkbox</option><option value="dropdown">Dropdown</option><option value="textarea">Long text</option><option value="number">Number</option><option value="date">Date</option></select><textarea name="question_options" rows="3" placeholder="One answer option per line"></textarea><label class="instructor-check"><input type="checkbox" name="question_required" value="1"> Required</label><button class="lms-btn" type="submit">Add question <span aria-hidden="true">+</span></button></form>
  </section>

  <section class="lms-card instructor-panel"><div class="dashboard-panel__head"><div><p class="lms-kicker">Student responses</p><h2>Review and give feedback</h2></div></div>
    <?php if ( $selected ) : ?><form class="instructor-response-tools" method="get" action="<?php echo esc_url( $action_url ); ?>"><input type="hidden" name="survey_id" value="<?php echo esc_attr( $selected->ID ); ?>"><input type="search" name="response_search" value="<?php echo esc_attr( $response_search ); ?>" placeholder="Search student, answer or feedback"><button class="lms-btn lms-btn--small" type="submit">Filter</button></form><?php endif; ?>
    <?php if ( $responses ) : ?><div class="instructor-responses"><?php foreach ( $responses as $response ) : $student_id = absint( get_post_meta( $response->ID, '_response_student_id', true ) ); $student = get_userdata( $student_id ); $answers = get_post_meta( $response->ID, '_response_answers', true ); $feedback = (string) get_post_meta( $response->ID, '_response_feedback', true ); ?><article class="instructor-response"><div class="instructor-response__person"><strong><?php echo esc_html( $student ? $student->display_name : 'Unknown student' ); ?></strong><small><?php echo esc_html( $student ? $student->user_email : '' ); ?> · <?php echo esc_html( get_the_date( '', $response ) ); ?></small></div><details><summary>View answers</summary><?php if ( is_array( $answers ) && $answers ) : ?><ul class="instructor-answer-list"><?php foreach ( $answers as $question_id => $answer ) : ?><li><strong><?php echo esc_html( get_the_title( $question_id ) ?: 'Answer' ); ?>:</strong> <?php echo esc_html( is_array( $answer ) ? implode( ', ', $answer ) : (string) $answer ); ?></li><?php endforeach; ?></ul><?php else : ?><p class="instructor-no-answer">No answers submitted.</p><?php endif; ?></details><form method="post" action="<?php echo esc_url( $action_url ); ?>"><?php wp_nonce_field( 'sslms_instructor_actions', 'sslms_instructor_nonce' ); ?><input type="hidden" name="instructor_action" value="save_feedback"><input type="hidden" name="response_id" value="<?php echo esc_attr( $response->ID ); ?>"><textarea name="response_feedback" rows="3" placeholder="Write constructive feedback for this student..."><?php echo esc_textarea( $feedback ); ?></textarea><button class="lms-btn lms-btn--small" type="submit">Save feedback</button><button class="lms-btn lms-btn--small lms-btn--danger" type="submit" name="instructor_action" value="delete_feedback" formnovalidate>Delete feedback</button></form></article><?php endforeach; ?></div><?php if ( $response_total_pages > 1 ) : ?><nav class="survey-pagination instructor-response-pagination" aria-label="Student response pagination"><?php if ( $response_page > 1 ) : ?><a aria-label="Previous page of responses" href="<?php echo esc_url( add_query_arg( array( 'survey_id' => $selected->ID, 'response_search' => $response_search, 'response_page' => $response_page - 1 ), $action_url ) ); ?>"><span aria-hidden="true">←</span> Previous</a><?php endif; ?><span>Page <?php echo esc_html( $response_page ); ?> of <?php echo esc_html( $response_total_pages ); ?></span><?php if ( $response_page < $response_total_pages ) : ?><a aria-label="Next page of responses" href="<?php echo esc_url( add_query_arg( array( 'survey_id' => $selected->ID, 'response_search' => $response_search, 'response_page' => $response_page + 1 ), $action_url ) ); ?>">Next <span aria-hidden="true">→</span></a><?php endif; ?></nav><?php endif; ?><?php else : ?><div class="dashboard-empty"><strong><?php echo $response_search ? 'No matching responses' : 'No responses yet'; ?></strong><p><?php echo $response_search ? 'Try a different search.' : 'Student submissions for this survey will appear here.'; ?></p></div><?php endif; ?>
  </section>
  <?php endif; ?>

  <section class="lms-card instructor-panel"><div class="dashboard-panel__head"><div><p class="lms-kicker">Your students</p><h2>Students in your class</h2></div><strong><?php echo esc_html( $students_query->get_total() ); ?></strong></div><?php if ( $students ) : ?><div class="instructor-student-grid"><?php foreach ( $students as $student ) : $snapshot = sslms_student_profile_snapshot( $student->ID ); ?><article class="instructor-student"><img src="<?php echo esc_url( $snapshot['photo'] ); ?>" alt=""><div><strong><?php echo esc_html( $student->display_name ); ?></strong><small><?php echo esc_html( $student->user_email ); ?></small><span><?php echo esc_html( $snapshot['class'] ?: 'Class not selected' ); ?><?php echo $snapshot['program'] ? ' · ' . esc_html( $snapshot['program'] ) : ''; ?></span></div></article><?php endforeach; ?></div><?php $student_total_pages = (int) ceil( $students_query->get_total() / 3 ); if ( $student_total_pages > 1 ) : ?><nav class="survey-pagination instructor-student-pagination" aria-label="Student list pagination"><?php if ( $student_page > 1 ) : ?><a aria-label="Previous page of students" href="<?php echo esc_url( add_query_arg( 'student_page', $student_page - 1 ) ); ?>"><span aria-hidden="true">←</span> Previous</a><?php endif; ?><span>Page <?php echo esc_html( $student_page ); ?> of <?php echo esc_html( $student_total_pages ); ?></span><?php if ( $student_page < $student_total_pages ) : ?><a aria-label="Next page of students" href="<?php echo esc_url( add_query_arg( 'student_page', $student_page + 1 ) ); ?>">Next <span aria-hidden="true">→</span></a><?php endif; ?></nav><?php endif; ?><?php else : ?><div class="dashboard-empty"><strong>No students in your class yet.</strong><p>Students appear here after they choose you in their profile.</p></div><?php endif; ?></section>
</section>
<?php get_footer(); ?>
