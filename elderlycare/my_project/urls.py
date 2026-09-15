"""elderlycare URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from my_project import views

urlpatterns = [

    path('logout/',views.logout),
    path('login_get/',views.login_get),
    path('login_post/',views.login_post),
    path('Admin_home_get/',views.Admin_home_get),

    path('change_password_get/',views.Change_password_get),
    path('Change_password_post/', views.Change_password_post),

    path('add_caretaker_get/',views.add_caretaker_get),
    path('add_caretaker_post/',views.add_caretaker_post),


    path('add_puzzle_get/',views.add_puzzle_get),
    path('add_puzzle_post/',views.add_puzzle_post),


    path('add_video_get/',views.add_video_get),
    path('add_video_post/',views.add_video_post),


    path('add_word_get/',views.add_word_get),
    path('add_word_post/',views.add_word_post),


    # path('change_password_get/',views.change_password_get),
    # path('change_password_post/',views.change_password_post),


    path('edit_caretaker_get/<id>',views.edit_caretaker_get),
    path('edit_caretaker_post/',views.edit_caretaker_post),


    path('edit_video_get/<id>',views.edit_video_get),
    path('edit_video_post/',views.edit_video_post),


    path('edit_word_get/<id>',views.edit_word_get),
    path('edit_word_post/', views.edit_word_post),


    path('edit_puzzle_get/<id>',views.edit_puzzle_get),
    path('edit_puzzle_post/',views.edit_puzzle_post),


    path('send_reply_get/',views.send_reply_get),
    path('send_reply_post/',views.send_reply_post),


    path('View_doctor_get/',views.View_doctor_get),
    path('View_doctor_post/',views.View_doctor_post),

    path('accept/<id>',views.accept_doctor),
    path('view_accepted_doctor_get/',views.view_accepted_doctor_get),
    path('view_accepted_doctor_post/',views.view_accepted_doctor_post),


    path('View_activity_of_patient_get/',views.view_activity_of_patient_get),
    path('View_activity_of_patient_post/',views.view_activity_of_patient_post),


    path('view_caretaker_get/',views.view_caretaker_get),
    path('view_caretaker_post/',views.view_caretaker_post),
    path('delete_caretaker_get/<id>',views.delete_caretaker_get),


    path('view_complaint_get/',views.view_complaint_get),
    path('view_complaint_post/',views.view_complaint_post),

    path('view_sendreply_get/<id>',views.view_sendreply_get),
    path('view_sendreply_post/',views.view_sendreply_post),


    path('view_feedback_get/',views.view_feedback_get),
    path('view_feedback_post/',views.view_feedback_post),


    path('view_patient_reprt_get/<id>',views.view_patient_report_get),
    path('view_patient_reprt_post/',views.view_patient_report_post),


    path('View_patient_get/<id>',views.view_patient_get),
    path('View_patient_post/',views.view_patient_post),


    path('view_puzzle_get/',views.view_puzzle_get),
    path('view_puzzle_post/',views.view_puzzle_post),
    path('delete_Puzzle_get/<id>',views.delete_Puzzle_get),


    path('view_video_get/',views.view_video_get),
    path('view_video_post/',views.view_video_post),
    path('delete_Video_get/<id>',views.delete_Video_get),


    path('view_word_get/',views.view_word_get),
    path('view_word_post/',views.view_word_post),
    path('delete_word_list_get/<id>',views.delete_word_list_get),

    path('reject/<id>',views.reject_doctor),
    path('view_rejected_doctor_get/',views.view_rejected_doctor_get),
    path('view_rejected_doctor_post/',views.view_rejected_doctor_post),


    path('view_appointment_get/',views.view_appointment_get),
    path('view_appointment_post/',views.view_appointment_post),


    path('view_schedule_get/', views.view_schedule_get),
    path('view_schedule_post/', views.view_schedule_post),


    path('view_fall_notification_get/', views.view_fall_notification_get),
    path('view_fall_notification_post/', views.view_fall_notification_post),


    path('view_photo_get/', views.view_photo_get),
    path('view_photo_post/', views.view_photo_post),


    path('view_pill_notification_get/', views.view_pill_notification_get),
    path('view_pill_notification_post/', views.view_pill_notification_post),


    path('view_pill_time_get/', views.view_pill_time_get),
    path('view_pill_time_post/', views.view_pill_time_post),


    path('view_emotion_get/', views.view_emotion_get),
    path('view_emotion_post/', views.view_emotion_post),


    #===========Doctor====================

    path('doc_registration_get/',views.doc_registration_get),
    path('doc_registration_post/', views.doc_registration_post),

    path('doc_add_schedule_get/', views.doc_add_schedule_get),
    path('doc_add_schedule_post/', views.doc_add_schedule_post),

    path('doc_change_password_get/', views.doc_change_password_get),
    path('doc_change_password_post/', views.doc_change_password_post),

    path('doc_chat_with_pathient_get/', views.doc_chat_with_pathient_get),
    path('doc_chat_with_pathient_post/', views.doc_chat_with_pathient_post),

    path('doc_edit_profile_get/',views.doc_edit_profile_get),
    path('doc_edit_profile_post/', views.doc_edit_profile_post),

    path('doc_edit_scedule_get/<id>', views.doc_edit_scedule_get),
    path('doc_edit_schedule_post/', views.doc_edit_schedule_post),


    path('doctor_home_page_get/', views.doctor_home_page_get),


    path('doc_view_activity_of_patient_get/<id>',views.doc_view_activity_of_patient_get),
    path('doc_view_activity_of_patient_post/', views.doc_view_activity_of_patient_post),

    path('doc_view_appointment_get/<id>',views.doc_view_appointment_get),
    path('doc_view_appointment_post/', views.doc_view_appointment_post),

    path('doc_view_fall_notification_get/',views.doc_view_fall_notification_get),
    path('doc_view_fall_notification_post/', views.doc_view_fall_notification_post),

    path('doc_view_patient_get/',views.doc_view_patient_get),
    path('doc_view_patient_post/', views.doc_view_patient_post),

    path('doc_view_profile_get/',views.doc_view_profile_get),
    path('doc_registration_post/', views.doc_view_profile_post),

    path('doc_view_schedule_get/', views.doc_view_schedule_get),
    path('doc_view_schedule_post/', views.doc_view_schedule_post),
    path('delete_schedule_get/<id>', views.delete_schedule_get),

                #######CARETAKER############

    path('and_login_post/', views.and_login_post),

    path('caretaker_change_password_post/',views.caretaker_change_password_post),

    path('caretaker_view_proile/', views.caretaker_view_proile),

    path('caretaker_add_patient_post/', views.caretaker_add_patient_post),

    path('caretaker_view_patient_post/',views.caretaker_view_patient_post),

    path('caretaker_view_patient_getss/',views.caretaker_view_patient_getss),

    path('careteker_edit_patient_post/',views.careteker_edit_patient_post),

    path('caretaker_delete_patient_post/', views.caretaker_delete_patient_post),

    path('caretaker_view_doctor_post/' , views.caretaker_view_doctor_post),

    path('caretaker_view_schedule_post/',views.caretaker_view_schedule_post),

    path('caretaker_make_appointment_post/',views.caretaker_make_appointment_post),

    path('caretaker_view_previous_booking_post/',views.caretaker_view_previous_booking_post),

    path('caretaker_add_photo_post/',views.caretaker_add_photo_post),

    path('caretaker_view_photo_post/',views.caretaker_view_photo_post),

    path('caretaker_delete_photo_post/',views.caretaker_delete_photo_post),

    path('caretaker_add_task_post/', views.caretaker_add_task_post),

    path('caretaker_view_task_post/', views.caretaker_view_task_post),

    path('caretaker_delete_task_post/', views.caretaker_delete_task_post),


    path('caretaker_view_fall_notification_and_its_photo_post/',views.caretaker_view_fall_notification_and_its_photo_post),

    path('caretaker_add_pill_time_post/',views.caretaker_add_pill_time_post),

    path('caretaker_view_pill_time_post/',views.caretaker_view_pill_time_post),

    path('delete_pill_post/',views.delete_pill_post),

    path('caretaker_view_patient_activity_post/',views.caretaker_view_patient_activity_post),

    path('caretaker_edit_pill_time_post/',views.caretaker_edit_pill_time_post),

    path('caretaker_view_fall_notification_post/',views.caretaker_view_fall_notification_post),

    path('caretaker_view_emotion_graph_of_patient_post/',views.caretaker_view_emotion_graph_of_patient_post),

    path('caretaker_view_reply_post/',views.caretaker_view_reply_post),

    path('caretaker_send_complaints_post/',views.caretaker_send_complaints_post),

    path('caretaker_monitor_activity_of_patient_post/',views.caretaker_monitor_activity_of_patient_post),

    path('caretaker_send_Feedback_post/',views.caretaker_send_Feedback_post),

    path('caretaker_view_Feedback_post/', views.caretaker_view_Feedback_post),


    ###########################Patient############################

    path('patient_view_profile_post/', views.patient_view_profile_post),

    path('patient_change_password_post/', views.patient_change_password_post),


    path('patient_emotion_recognition_post/', views.patient_emotion_recognition_post),


    path('patient_view_puzzle_post/', views.patient_view_puzzle_post),


    path('patient_word_pronounciation_post/', views.patient_word_pronounciation_post),


    path('patient_object_recognition_post/', views.patient_object_recognition_post),





    path('patient_view_reminder_post/', views.patient_view_reminder_post),


    path('patient_recognize_person_post/', views.patient_recognize_person_post),


    path('patient_view_videos_post/', views.patient_view_videos_post),


    path('patient_handwriting_analysis_post/', views.patient_handwriting_analysis_post),

    path('patient_progress_post/', views.patient_progress_post),
    path('patient_progress_fail/', views.patient_progress_fail),

    path('patient_view_Word_List_post/', views.patient_view_Word_List_post),

    path('handwriting/', views.handwriting),

    path('handwritingpass/', views.handwritingpass),

    path('handwritingfail/', views.handwritingfail),

    path('person_detection_post/', views.person_detection_post),

    path('viewfallnotification/', views.viewfallnotification),
    path('newviewfallnotification/', views.newviewfallnotification),

    path('viewNotification/', views.viewNotification),

    path('ana_progress_solve/', views.ana_progress_solve),

    path('view_Pill_notification/', views.view_Pill_notification),

    path('ana_progress_fail/', views.ana_progress_fail),

    path('patient_view_pill_notifications_post/', views.patient_view_pill_notifications_post),

    path('compare_pose/', views.compare_pose),

    path('view_emotion_graph_post/', views.view_emotion_graph_post),

   path('viewfallnotification_new/', views.viewfallnotification_new),

]

