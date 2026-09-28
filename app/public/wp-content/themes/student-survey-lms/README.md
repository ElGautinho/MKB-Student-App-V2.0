# Student Survey LMS — Standalone Theme

> **Repository notice:** This folder contains the complete `student-survey-lms` WordPress theme for MKB Student Survey. It includes the student, instructor, and administrator experiences, survey management, private chat, profile tools, notifications, responsive styling, and the supporting documentation listed below.

This package is a **complete standalone WordPress theme** for the Student Survey application. It does not depend on Twenty Twenty-Four or Twenty Twenty-Five.

## Included

- Professional LMS-style visual design
- Responsive student home/dashboard
- Operational student profile page with editable information and profile photo
- Available Surveys page
- Completed Surveys / My Progress page
- Dedicated My Feedback page with complete instructor feedback and survey/instructor information
- Survey-taking interface with progress indicator
- Existing survey question types supported by the app
- Instructor feedback display (full message, with pending-review state)
- Private chat between students and instructors, and between instructors and administrators
- Header profile avatar and unread notifications for surveys, feedback, responses, and chat messages
- Survey cover image support through WordPress Featured Image
- Dynamic role-aware navigation with student Profile access
- Student / Instructor / Administrator roles (single Instructor role; legacy Teacher role is consolidated automatically)
- Instructor Survey Responses admin screen
- Login/logout redirects
- Built-in education imagery with documented source references
- Mobile/tablet/desktop responsive layout

## Important

The theme bundles the `survey` and `question` CPT registration modules, so it can run independently. If you are using the original project, its existing `wp-content/mu-plugins/custom-post-type-surveys.php` and `custom-post-type-questions.php` are detected and are not loaded a second time.

Install this folder as:
`wp-content/themes/student-survey-lms/`

Then activate **Student Survey LMS** under **Appearance → Themes**.

If your existing WordPress pages already use the supplied templates, they can remain. The theme also provides `front-page.php` so the homepage can render without relying on Twenty Twenty-Five.

## Student profile

The theme creates a `Student Profile` page on activation. Students can update their first/last name, phone, student ID, program, level, city, country, short bio and profile photo. The profile page displays a completion indicator and a profile summary.

## About page

The About page is based on the original Student Survey Application README: feedback loops between instructors and students, structured surveys/questions, validation and duplicate-submission protection, role-based access, instructor feedback and responsive access.

## Survey cover image

When creating or editing a survey, use the WordPress **Featured Image / Image mise en avant** box in the survey editor to upload or choose a cover image. The image is automatically used on the survey cards and on the survey-taking page. If no image is selected, the theme keeps its built-in African education imagery as a fallback.

For an Instructor account, the theme also enables the media upload capability required to select a survey cover image.

## My Feedback

The theme creates a **My Feedback** page on activation. Students see their completed surveys in a dedicated menu item. Each entry shows the survey cover, title, description, creator/instructor, number of questions, availability dates, completion date and the complete instructor feedback when it has been provided.

## Chat and notifications

The theme creates a **Student Chat** page and an **Instructor Admin Chat** page automatically. Students can choose an instructor and continue a private conversation. Instructors can switch between student and administrator conversations. The header notification button reports unseen surveys, feedback, survey responses, and chat messages. Opening the related content marks that notification as seen for the current user.

## Documentation map

- `DYNAMIC_MENU_GUIDE_EN.md` and `DYNAMIC_MENU_GUIDE.md`: role-aware navigation setup in English and French.
- `SURVEY_IMAGES_AND_FEEDBACK.md`: survey cover images and the student feedback workflow.
- `PHOTO_SOURCES.md`: image source and licensing notes for maintainers.
- `inc/`: reusable role, survey, profile, chat, and notification modules.

## Version 3.6.0

- Profile navigation remains visibly active on the Student Profile page.
- Student profile includes profile photo and roll number.
- Completed survey history shows four recent responses first, with older responses behind an archive toggle.
- Archived responses automatically open when an older selected response is viewed.
- Student response selection is restricted to the logged-in student's own responses.
- Home and Student Dashboard now use the bundled modern computer-lab student image.
- Theme, CSS and JavaScript cache versions bumped to 3.6.0.
