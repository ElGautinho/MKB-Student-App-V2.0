<?php
/* Template Name: Instructor Profile */
if ( ! sslms_is_instructor() ) {
  get_header();
    echo '<section class="lms-page"><div class="survey-permission"><strong>Instructor profile</strong><br>Please sign in with an instructor account to access your profile.</div></section>';
    get_footer(); return;
}
$status = sslms_handle_instructor_profile();
if ( $status ) {
  wp_safe_redirect( add_query_arg( 'sslms_status', $status, get_permalink() ) );
  exit;
}
$status = sanitize_key( $_GET['sslms_status'] ?? '' );
$user = wp_get_current_user();
$photo = sslms_student_profile_photo_url( $user->ID, 'medium' );
$profile = function( $key ) use ( $user ) { return sslms_profile_value( $key, $user->ID ); };
get_header();
?>
<section class="lms-page instructor-profile-page">
  <div class="profile-hero"><div><p class="lms-kicker">Instructor account</p><h1>Your profile</h1><p>Keep your public teaching information current so students can recognize and choose the right instructor.</p></div><a class="lms-btn lms-btn--ghost" href="<?php echo esc_url( sslms_instructor_dashboard_url() ); ?>">Back to dashboard <span aria-hidden="true">→</span></a></div>
  <?php if ( 'saved' === $status ) : ?><div class="profile-notice profile-notice--success">Your instructor profile has been updated.</div><?php elseif ( 'error' === $status ) : ?><div class="profile-notice profile-notice--error">We could not save your profile. Please try again.</div><?php endif; ?>
  <form class="lms-card instructor-profile-form" method="post" enctype="multipart/form-data">
    <?php wp_nonce_field( 'sslms_save_instructor_profile', 'sslms_instructor_profile_nonce' ); ?>
    <div class="profile-section-heading"><p class="lms-kicker">Public teaching profile</p><h2>Tell students about you</h2></div>
    <div class="profile-photo-panel"><div class="profile-photo-wrap"><img src="<?php echo esc_url( $photo ); ?>" alt="Instructor profile photo"></div><label class="lms-file-field"><span>Choose profile photo</span><input type="file" name="profile_photo" accept="image/jpeg,image/png,image/webp"></label></div>
    <div class="profile-fields-grid"><label><span>First name</span><input type="text" name="first_name" value="<?php echo esc_attr( $user->first_name ); ?>" required></label><label><span>Last name</span><input type="text" name="last_name" value="<?php echo esc_attr( $user->last_name ); ?>" required></label><label><span>Email address</span><input type="email" value="<?php echo esc_attr( $user->user_email ); ?>" disabled></label><label><span>Phone number</span><input type="tel" name="phone" value="<?php echo esc_attr( $profile( 'phone' ) ); ?>"></label><label><span>Institution</span><input type="text" name="institution" value="<?php echo esc_attr( $profile( 'institution' ) ); ?>"></label><label><span>Program / subject</span><input type="text" name="program" value="<?php echo esc_attr( $profile( 'program' ) ); ?>" placeholder="e.g. Mathematics"></label><label><span>City</span><input type="text" name="city" value="<?php echo esc_attr( $profile( 'city' ) ); ?>"></label><label><span>Country</span><input type="text" name="country" value="<?php echo esc_attr( $profile( 'country' ) ); ?>"></label></div>
    <label class="profile-bio"><span>Teaching bio</span><textarea name="bio" rows="6" placeholder="Tell students about your teaching approach..."><?php echo esc_textarea( $profile( 'bio' ) ); ?></textarea></label>
    <div class="profile-form-actions"><a class="lms-btn lms-btn--ghost" href="<?php echo esc_url( sslms_instructor_dashboard_url() ); ?>">Cancel</a><button class="lms-btn" type="submit">Save profile <span aria-hidden="true">→</span></button></div>
  </form>
  <div class="profile-summary lms-card"><div><p class="lms-kicker">Profile overview</p><h2><?php echo esc_html( $user->display_name ); ?></h2><p><?php echo esc_html( $profile( 'program' ) ?: 'Instructor' ); ?><?php if ( $profile( 'institution' ) ) : ?> · <?php echo esc_html( $profile( 'institution' ) ); ?><?php endif; ?></p></div><img src="<?php echo esc_url( $photo ); ?>" alt="<?php echo esc_attr( $user->display_name ); ?>"></div>
</section>
<?php get_footer(); ?>
