<?php
/* Template Name: About */
get_header();
?>
<section class="lms-page about-page">
  <div class="about-hero">
    <div class="about-hero__grid">
      <div>
        <p class="lms-kicker" style="color:#c7c9ff;">About Student Survey</p>
        <h1>Feedback that helps students and instructors move forward.</h1>
        <p>Student Survey is a focused WordPress learning platform built to create a reliable feedback loop between students and instructors — from creating surveys to submitting answers, reviewing progress and reading instructor feedback.</p>
        <div class="about-hero-actions"><a class="lms-btn" href="<?php echo esc_url( home_url('/survey/') ); ?>">Explore surveys <span aria-hidden="true">→</span></a><a class="lms-btn lms-btn--ghost" href="#how-it-works">How it works</a></div>
      </div>
      <img class="about-hero__image" src="<?php echo esc_url( sslms_image_url( 3 ) ); ?>" alt="Students learning together">
    </div>
  </div>

  <div class="about-intro about-section">
    <div><p class="lms-kicker">Why the platform exists</p><h2>A simple bridge between student experience and meaningful improvement.</h2></div>
    <p>The original project is designed around feedback loops between instructors and students. It uses structured surveys and questions to collect responses, validate submissions and keep student feedback organized in one academic-focused environment.</p>
  </div>

  <div id="how-it-works" class="about-section">
    <p class="lms-kicker">How it works</p><h2>From survey creation to useful feedback.</h2>
    <div class="about-steps">
      <article><span>01</span><h3>Build a survey</h3><p>Instructors create structured surveys and question sets suited to the learning context.</p></article>
      <article><span>02</span><h3>Students respond</h3><p>Students access available surveys through a focused, role-aware interface and submit their answers.</p></article>
      <article><span>03</span><h3>Review responses</h3><p>Submissions stay organized so instructors can review responses and add meaningful feedback.</p></article>
      <article><span>04</span><h3>Learn & improve</h3><p>Students can revisit completed surveys and instructor feedback as part of their learning journey.</p></article>
    </div>
  </div>

  <div class="about-section">
    <p class="lms-kicker">What powers the experience</p><h2>Built around the needs of an academic feedback loop.</h2>
    <div class="features-grid">
      <div class="feature-card"><div class="feature-card__icon">🎯</div><h3>Role-based access</h3><p>Specialized Student, Instructor and Administrator roles keep each experience focused on the right tools.</p></div>
      <div class="feature-card"><div class="feature-card__icon">📝</div><h3>Survey management</h3><p>Instructors can work with structured surveys and flexible question sets for different feedback needs.</p></div>
      <div class="feature-card"><div class="feature-card__icon">🛡️</div><h3>Reliable submissions</h3><p>Validation and duplicate-submission controls help protect response integrity and keep feedback dependable.</p></div>
      <div class="feature-card"><div class="feature-card__icon">💬</div><h3>Instructor feedback</h3><p>Students can return to their completed submissions and see the feedback attached by instructors.</p></div>
      <div class="feature-card"><div class="feature-card__icon">📈</div><h3>Progress visibility</h3><p>Students have a clear view of completed surveys and their activity, without unnecessary complexity.</p></div>
      <div class="feature-card"><div class="feature-card__icon">📱</div><h3>Responsive by design</h3><p>The LMS interface is designed to remain useful across desktop, tablet and mobile screens.</p></div>
    </div>
  </div>

  <div class="about-purpose">
    <div><p class="lms-kicker">Our principle</p><h2>Make feedback useful, simple and human.</h2><p>The platform is not only about collecting answers. It is about making the feedback loop easier to use for students and instructors, while keeping the experience calm, organized and focused on learning.</p></div>
    <div class="about-purpose__quote">“Good feedback should help people understand where they are — and what they can do next.”</div>
  </div>
</section>
<?php get_footer(); ?>
