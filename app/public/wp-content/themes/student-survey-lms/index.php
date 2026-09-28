<?php get_header(); ?>
<section class="lms-page"><div class="lms-content">
<?php if ( have_posts() ) : while ( have_posts() ) : the_post(); the_title( '<h1>', '</h1>' ); the_content(); endwhile; else : ?><h1>Welcome</h1><p>No content found.</p><?php endif; ?>
</div></section>
<?php get_footer(); ?>
