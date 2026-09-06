<?php
/* Template Name: Home Context */
get_header();
?>
<section class="lms-page">
    <div class="lms-hero">
        <div class="lms-hero__copy">
            <p class="lms-kicker">Student learning hub</p>
            <h1>Learn, reflect, and <span>make an impact.</span></h1>
            <p>Welcome to your modern learning feedback space. Discover surveys, share thoughtful feedback, and help instructors create better learning experiences.</p>
            <div class="lms-actions">
                <?php if (is_user_logged_in() && current_user_can('student')) : ?>
                    <a class="lms-btn" href="<?php echo esc_url(home_url('/survey/')); ?>">Explore surveys <span aria-hidden="true">&nbsp;→</span></a>
                <?php else : ?>
                    <a class="lms-btn" href="<?php echo esc_url(wp_login_url()); ?>">Get started <span aria-hidden="true">&nbsp;→</span></a>
                <?php endif; ?>
                <a class="lms-btn lms-btn--ghost" href="<?php echo esc_url(home_url('/about/')); ?>">Learn more</a>
            </div>
        </div>
        <div class="lms-hero__visual">
            <img class="lms-hero__image" src="https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&w=900&q=85" alt="Students collaborating while studying">
            <div class="lms-float-card">
                <span class="lms-float-icon" aria-hidden="true">✓</span>
                <span><strong>Feedback matters</strong><small>Every response helps improve learning</small></span>
            </div>
        </div>
    </div>

    <div class="lms-feature-grid">
        <article class="lms-card lms-feature"><div class="lms-feature__icon">🎯</div><h3>Focused learning</h3><p>Find the surveys and activities that matter to your learning journey.</p></article>
        <article class="lms-card lms-feature"><div class="lms-feature__icon">💬</div><h3>Your voice matters</h3><p>Share clear, useful feedback with instructors in a simple experience.</p></article>
        <article class="lms-card lms-feature"><div class="lms-feature__icon">📈</div><h3>Track your progress</h3><p>Review completed surveys and keep a record of your submitted responses.</p></article>
    </div>
</section>
<?php get_footer(); ?>
