<?php
/**
 * Template Name: My Profile
 */
if ( ! is_user_logged_in() ) { auth_redirect(); exit; }

$user_id = get_current_user_id();
$user = wp_get_current_user();
$photo_id = absint( get_user_meta( $user_id, 'sslms_profile_photo_id', true ) );
$photo = $photo_id ? wp_get_attachment_image_url( $photo_id, 'medium' ) : get_avatar_url( $user_id, array( 'size' => 180 ) );
$first = get_user_meta( $user_id, 'first_name', true );
$last = get_user_meta( $user_id, 'last_name', true );
$phone = get_user_meta( $user_id, 'description_phone', true );
$country = get_user_meta( $user_id, 'description_country', true );
$city = get_user_meta( $user_id, 'description_city', true );
$institution = get_user_meta( $user_id, 'description_institution', true );
$program = get_user_meta( $user_id, 'description_program', true );
$bio = get_user_meta( $user_id, 'description_bio', true );
?>
<?php get_header(); ?>
<main class="lms-main student-profile-page">
  <div class="lms-container">
    <div class="profile-header-card">
      <div class="profile-avatar-wrap">
        <img class="profile-avatar" src="<?php echo esc_url( $photo ); ?>" alt="<?php echo esc_attr( $user->display_name ); ?>">
      </div>
      <div>
        <p class="lms-kicker">Student Profile</p>
        <h1><?php echo esc_html( $first || $last ? trim( "$first $last" ) : $user->display_name ); ?></h1>
        <p><?php echo esc_html( $user->user_email ); ?></p>
      </div>
    </div>

    <?php if ( isset( $_GET['profile_updated'] ) ) : ?>
      <div class="survey-info profile-success">Your profile has been updated successfully.</div>
    <?php endif; ?>

    <div class="profile-grid">
      <section class="lms-card">
        <div class="card-heading-row">
          <div><p class="lms-kicker">Personal information</p><h2>Your information</h2></div>
        </div>
        <div class="profile-details">
          <div><span>First name</span><strong><?php echo esc_html( $first ?: 'Not provided' ); ?></strong></div>
          <div><span>Last name</span><strong><?php echo esc_html( $last ?: 'Not provided' ); ?></strong></div>
          <div><span>Phone</span><strong><?php echo esc_html( $phone ?: 'Not provided' ); ?></strong></div>
          <div><span>Country</span><strong><?php echo esc_html( $country ?: 'Not provided' ); ?></strong></div>
          <div><span>City</span><strong><?php echo esc_html( $city ?: 'Not provided' ); ?></strong></div>
          <div><span>Institution</span><strong><?php echo esc_html( $institution ?: 'Not provided' ); ?></strong></div>
          <div><span>Program</span><strong><?php echo esc_html( $program ?: 'Not provided' ); ?></strong></div>
          <div class="profile-bio"><span>About me</span><strong><?php echo nl2br( esc_html( $bio ?: 'Not provided' ) ); ?></strong></div>
        </div>
      </section>

      <section class="lms-card profile-form-card">
        <p class="lms-kicker">Update profile</p>
        <h2>Edit my information</h2>
        <form method="post" enctype="multipart/form-data" class="profile-form">
          <?php wp_nonce_field( 'sslms_save_profile', 'sslms_profile_nonce' ); ?>
          <label>First name<input type="text" name="first_name" value="<?php echo esc_attr( $first ); ?>"></label>
          <label>Last name<input type="text" name="last_name" value="<?php echo esc_attr( $last ); ?>"></label>
          <label>Phone<input type="text" name="phone" value="<?php echo esc_attr( $phone ); ?>"></label>
          <label>Country<input type="text" name="country" value="<?php echo esc_attr( $country ); ?>"></label>
          <label>City<input type="text" name="city" value="<?php echo esc_attr( $city ); ?>"></label>
          <label>Institution<input type="text" name="institution" value="<?php echo esc_attr( $institution ); ?>"></label>
          <label>Program / Course<input type="text" name="program" value="<?php echo esc_attr( $program ); ?>"></label>
          <label>About me<textarea name="bio" rows="4"><?php echo esc_textarea( $bio ); ?></textarea></label>
          <label>Profile photo<input type="file" name="profile_photo" accept="image/jpeg,image/png,image/webp"></label>
          <button class="lms-button" type="submit">Save profile</button>
        </form>
      </section>
    </div>
  </div>
</main>
<?php get_footer(); ?>
