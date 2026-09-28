<?php
if ( ! defined( 'ABSPATH' ) ) { exit; }

add_action( 'init', function() {
    if ( ! get_role( 'student' ) ) {
        add_role( 'student', 'Student', array( 'read' => true ) );
    }
    if ( ! get_role( 'instructor' ) ) {
        add_role( 'instructor', 'Instructor', array( 'read' => true, 'edit_posts' => true, 'edit_surveys' => true, 'manage_classes' => true, 'upload_files' => true ) );
    }
});

add_action( 'init', function() {
    $role = get_role( 'instructor' );
    if ( $role ) {
        $role->add_cap( 'upload_files' );
    }
});

add_action( 'init', function() {
    // Consolidate the legacy duplicate Teacher role into the single Instructor role.
    if ( ! get_option( 'sslms_teacher_role_consolidated_v34' ) ) {
        $teacher_users = get_users( array( 'role' => 'teacher', 'fields' => 'ID' ) );
        foreach ( $teacher_users as $user_id ) {
            $user = new WP_User( $user_id );
            if ( ! in_array( 'instructor', (array) $user->roles, true ) ) {
                $user->add_role( 'instructor' );
            }
            $user->remove_role( 'teacher' );
        }
        remove_role( 'teacher' );
        update_option( 'sslms_teacher_role_consolidated_v34', 1 );
    }
});

add_action( 'init', function() {
    if ( get_option( 'users_can_register' ) !== '1' ) {
        update_option( 'users_can_register', 1 );
    }
});

add_action( 'user_register', function( $user_id ) {
    $user = new WP_User( $user_id );
    if ( $user ) { $user->set_role( 'student' ); }
});
