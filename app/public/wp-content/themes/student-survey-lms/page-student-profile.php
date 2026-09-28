<?php
/* Template Name: Student Profile */
if ( ! sslms_is_student() ) {
  get_header();
    echo '<section class="lms-page"><div class="survey-permission"><strong>Student profile</strong><br>Please sign in with a student account to access your profile.</div></section>';
    get_footer(); return;
}

$status = sslms_handle_student_profile();
if ( $status ) {
  wp_safe_redirect( add_query_arg( 'sslms_status', $status, get_permalink() ) );
  exit;
}
$status = sanitize_key( $_GET['sslms_status'] ?? '' );
$user = wp_get_current_user();
$photo = sslms_student_profile_photo_url( $user->ID, 'medium' );
$completion = sslms_profile_completeness( $user->ID );
$assignment = sslms_get_student_assignment( $user->ID );
$instructor_classes = sslms_get_instructor_classes( $assignment['instructor_id'] );
get_header();
?>
<section class="lms-page student-profile-page">
  <div class="profile-hero">
    <div>
      <p class="lms-kicker">Student account</p>
      <h1>Your profile</h1>
      <p>Keep your student information up to date so your learning and feedback experience stays personal and easy to manage.</p>
    </div>
    <div class="profile-completion">
      <span>Profile completeness</span>
      <strong><?php echo esc_html( $completion ); ?>%</strong>
      <div class="profile-progress"><i style="width:<?php echo esc_attr( $completion ); ?>%"></i></div>
    </div>
  </div>

  <?php if ( 'saved' === $status ) : ?>
    <div class="profile-notice profile-notice--success">✓ Your profile has been updated successfully.</div>
  <?php elseif ( 'error' === $status ) : ?>
    <div class="profile-notice profile-notice--error">We could not save your profile. Please refresh the page and try again.</div>
  <?php endif; ?>

  <form class="lms-card student-profile-form" method="post" enctype="multipart/form-data">
    <?php wp_nonce_field( 'sslms_save_student_profile', 'sslms_profile_nonce' ); ?>
    <div class="profile-form-grid">
      <aside class="profile-photo-panel">
        <div class="profile-photo-wrap"><img id="sslms-profile-preview" src="<?php echo esc_url( $photo ); ?>" alt="Student profile photo"></div>
        <h2>Profile photo</h2>
        <p>Use a clear photo so instructors can easily recognize your student profile.</p>
        <label class="lms-file-field"><span>Choose photo</span><input id="sslms-profile-photo" type="file" name="profile_photo" accept="image/jpeg,image/png,image/webp"></label>
        <small>JPG, PNG or WebP. A square or portrait photo works best.</small>
      </aside>

      <div class="profile-fields">
        <div class="profile-section-heading"><p class="lms-kicker">Personal information</p><h2>Tell us about you</h2></div>
        <div class="profile-fields-grid">
          <label><span>First name</span><input type="text" name="first_name" value="<?php echo esc_attr( sslms_profile_value( 'first_name', $user->ID ) ); ?>" required></label>
          <label><span>Last name</span><input type="text" name="last_name" value="<?php echo esc_attr( sslms_profile_value( 'last_name', $user->ID ) ); ?>" required></label>
          <label><span>Email address</span><input type="email" value="<?php echo esc_attr( $user->user_email ); ?>" disabled><small>Your account email is managed by WordPress.</small></label>
          <label><span>Phone number</span><input type="tel" name="phone" value="<?php echo esc_attr( sslms_profile_value( 'phone', $user->ID ) ); ?>" placeholder="+243 ..."></label>
          <label><span>Student ID</span><input type="text" name="student_id" value="<?php echo esc_attr( sslms_profile_value( 'student_id', $user->ID ) ); ?>" placeholder="e.g. STU-2026-001"></label>
          <label><span>Roll number</span><input type="text" name="roll_number" value="<?php echo esc_attr( sslms_profile_value( 'roll_number', $user->ID ) ); ?>" placeholder="e.g. 24"></label>
          <label><span>Program / field of study</span><input type="text" name="program" value="<?php echo esc_attr( sslms_profile_value( 'program', $user->ID ) ); ?>" placeholder="Your program"></label>
          <label><span>Year / level</span><input type="text" name="level" value="<?php echo esc_attr( sslms_profile_value( 'level', $user->ID ) ); ?>" placeholder="e.g. Year 1"></label>
          <label><span>City</span><input type="text" name="city" value="<?php echo esc_attr( sslms_profile_value( 'city', $user->ID ) ); ?>" placeholder="Your city"></label>
          <label><span>Country</span><input type="text" name="country" value="<?php echo esc_attr( sslms_profile_value( 'country', $user->ID ) ); ?>" placeholder="Your country"></label>
          <label><span>Assigned instructor</span>
            <select name="assigned_instructor_id">
              <option value="">Select an instructor</option>
              <?php foreach ( sslms_get_instructor_users() as $instructor ) : ?>
                <option value="<?php echo esc_attr( $instructor->ID ); ?>" <?php selected( absint( get_user_meta( $user->ID, '_sslms_assigned_instructor_id', true ) ), $instructor->ID ); ?>><?php echo esc_html( $instructor->display_name ); ?></option>
              <?php endforeach; ?>
            </select>
          </label>
          <label><span>Class / group</span>
            <select name="student_class">
              <option value="">Select a class</option>
              <?php foreach ( $instructor_classes as $class ) : ?><option value="<?php echo esc_attr( $class ); ?>" <?php selected( $assignment['class'], $class ); ?>><?php echo esc_html( $class ); ?></option><?php endforeach; ?>
            </select>
            <?php if ( ! $instructor_classes ) : ?><small>Select an instructor with survey classes first.</small><?php endif; ?>
          </label>
        </div>
        <label class="profile-bio"><span>Short bio</span><textarea name="bio" rows="5" placeholder="Tell your instructors a little about your interests, goals or learning journey..."><?php echo esc_textarea( sslms_profile_value( 'bio', $user->ID ) ); ?></textarea></label>
        <div class="profile-form-actions"><a class="lms-btn lms-btn--ghost" href="<?php echo esc_url( home_url( '/' ) ); ?>">Cancel</a><button class="lms-btn" type="submit">Save profile <span aria-hidden="true">→</span></button></div>
      </div>
    </div>
  </form>

  <div class="profile-summary lms-card">
    <div><p class="lms-kicker">Profile overview</p><h2><?php echo esc_html( $user->display_name ?: $user->user_login ); ?></h2><p><?php echo esc_html( sslms_profile_value( 'program', $user->ID ) ?: 'Student' ); ?><?php if ( sslms_profile_value( 'city', $user->ID ) ) : ?> · <?php echo esc_html( sslms_profile_value( 'city', $user->ID ) ); ?><?php endif; ?></p></div>
    <img src="<?php echo esc_url( $photo ); ?>" alt="<?php echo esc_attr( $user->display_name ); ?>">
  </div>
</section>
<script>
document.addEventListener('DOMContentLoaded', function () {
  const input = document.getElementById('sslms-profile-photo');
  const preview = document.getElementById('sslms-profile-preview');
  if (!input || !preview) return;
  input.addEventListener('change', function () {
    const file = this.files && this.files[0];
    if (file) preview.src = URL.createObjectURL(file);
  });
});
</script>
<?php get_footer(); ?>
