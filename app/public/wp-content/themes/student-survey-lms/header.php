<!doctype html>
<html <?php language_attributes(); ?>>
<head>
    <meta charset="<?php bloginfo( 'charset' ); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?php wp_head(); ?>
</head>
<body <?php body_class( 'lms-app' ); ?>>
<?php wp_body_open(); ?>
<header class="site-header lms-header">
    <div class="lms-header__inner">
        <a class="lms-brand" href="<?php echo esc_url( home_url( '/' ) ); ?>" aria-label="MKB Student Survey home">
            <span class="lms-brand__mark" aria-hidden="true">M</span>
            <span class="lms-brand__text">
                <strong>MKB <span>Student Survey</span></strong>
                <small>Learning &amp; feedback platform</small>
            </span>
        </a>
        <button class="lms-menu-toggle" type="button" aria-expanded="false" aria-controls="site-main-menu">
            <span></span><span></span><span></span><b>Menu</b>
        </button>
        <div class="lms-header__nav" id="site-main-menu">
            <?php echo do_shortcode( '[dynamic_main_menu]' ); ?>
            <?php echo sslms_render_header_tools(); ?>
        </div>
    </div>
</header>
<main class="lms-main">
