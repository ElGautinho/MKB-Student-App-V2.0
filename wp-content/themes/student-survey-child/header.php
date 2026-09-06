<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?php wp_head(); ?>
</head>
<body <?php body_class('lms-app'); ?>>
<?php wp_body_open(); ?>
<header class="site-header lms-header">
    <div class="lms-header__inner">
        <a class="lms-brand" href="<?php echo esc_url(home_url('/')); ?>" aria-label="Student Survey App home">
            <span class="lms-brand__mark" aria-hidden="true">S</span>
            <span class="lms-brand__text">
                <strong>Student<span>Survey</span></strong>
                <small>Learning platform</small>
            </span>
        </a>
        <div class="lms-header__nav">
            <?php echo do_shortcode('[dynamic_main_menu]'); ?>
        </div>
    </div>
</header>
<main class="lms-main">
