# AI CareCompanion

## A Smart System for Elderly Wellness and Monitoring

AI CareCompanion is a modular elderly-care platform developed using
**Flutter**, **Python/Django**, and **MySQL**. It combines a mobile
application with AI and computer-vision capabilities to support elderly
users in physical safety, rehabilitation, cognitive engagement,
emotional awareness, and healthcare management.

The system provides role-based functionality for **Patients, Caretakers,
Doctors, and Administrators**.

------------------------------------------------------------------------

## Overview

The platform integrates:

-   AI-based fall detection
-   Malayalam handwriting recognition for stroke rehabilitation
-   Facial emotion recognition
-   Cognitive engagement activities
-   Object and person recognition
-   Camera-based activity and motor-skill monitoring
-   Doctor appointment management
-   Medication and reminder notifications
-   Patient task and schedule management
-   Role-based interfaces for Admins, Doctors, Caretakers, and Patients

The system is organized as a Flutter client connected to a Python/Django
backend, with MySQL used for persistent application data.

------------------------------------------------------------------------

## Key Features

### Fall Detection

The dedicated fall-detection implementation uses **YOLOv7-Pose**, human
pose estimation, Python/PyTorch components, and video/image processing.

The pretrained `yolov7-w6-pose.pt` weight is intentionally excluded from
Git because of its size and must be supplied locally when running the
fall-detection module.

### Malayalam Handwriting Recognition

The Flutter application provides an interactive drawing interface for
Malayalam handwriting exercises. The implementation captures the
drawing, sends it to the Django backend, processes the recognition
workflow, and records exercise results.

This functionality is intended particularly for stroke-rehabilitation
exercises.

### Emotion Recognition

The project includes facial emotion recognition based on a deep-learning
model trained using the **FER-2013** dataset.

The implementation includes face processing, emotion classification,
model-training code, and locally stored model artifacts.

Detailed experimental metrics are not listed here because different
sections of the academic documentation report different experiment
results.

### Cognitive Engagement

The patient application includes:

-   Word rearrangement
-   Scrambled-word activities
-   Puzzle solving
-   Image-based puzzles
-   Anagram activities
-   Word pronunciation
-   Object recognition

### Object and Person Recognition

The patient module provides separate object-recognition and
person-recognition workflows connected to backend processing.

### Motor-Skill and Activity Monitoring

The project includes camera-based activity monitoring and
rehabilitation-oriented functionality. The academic documentation
describes physical activity evaluation using **MediaPipe-based hand pose
estimation**.

### Healthcare Management

The system includes:

-   Doctor registration and profiles
-   Doctor search
-   Appointments
-   Previous bookings
-   Patient management
-   Doctor-patient communication
-   Doctor schedules
-   Patient schedules
-   Feedback
-   Complaints and replies

### Medication and Reminders

The application includes:

-   Pill/medication time management
-   Pill notifications
-   Patient reminders
-   Tasks
-   Schedules

------------------------------------------------------------------------

## User Roles

### Admin

The administrator interface includes management workflows for patients,
caretakers, doctors, doctor verification, appointments, feedback,
complaints, patient activity, fall notifications, emotion information,
medication notifications, schedules, puzzles, videos, and words.

### Doctor

Doctor functionality includes registration, profile management,
schedules, patient viewing, patient activity, appointments, fall
notifications, and patient communication.

### Caretaker

Caretaker functionality includes patient management, patient
information, tasks, schedules, medication times, activity information,
fall notifications, and healthcare coordination.

### Patient

The patient application provides access to profile management, tasks,
reminders, medication notifications, doctors, appointments, fall
information, emotion recognition, Malayalam handwriting exercises,
object recognition, person recognition, cognitive activities, word
pronunciation, and videos.

------------------------------------------------------------------------

## System Architecture

``` text
┌──────────────────────────────────────┐
│          Flutter Application         │
│                                      │
│ Patient • Caretaker • Doctor • Admin │
└──────────────────┬───────────────────┘
                   │ HTTP
                   ▼
┌──────────────────────────────────────┐
│        Python / Django Backend       │
│                                      │
│ Views • URLs • Models • AI workflows │
│ Notifications • Application logic   │
└───────────────┬───────────────┬──────┘
                │               │
                ▼               ▼
       ┌────────────────┐  ┌─────────────────┐
       │     MySQL      │  │ AI / CV Models  │
       │    Database    │  │                 │
       └────────────────┘  │ YOLOv7-Pose     │
                           │ Emotion model   │
                           │ Handwriting     │
                           │ Recognition     │
                           └─────────────────┘
```

------------------------------------------------------------------------

## Repository Structure

``` text
AI-CareCompanion/
│
├── ElderlyCare-Flutter/       # Flutter application
│
├── elderlycare/               # Django project/backend
│   ├── elderlycare/           # Django project configuration
│   ├── my_project/            # Main Django application
│   ├── templates/             # Admin/Doctor/login templates
│   └── manage.py              # Django management entry point
│
├── cfg/                       # YOLO configuration files
├── models/                    # YOLO model implementation
├── utils/                     # YOLO/supporting utilities
│
├── main.py                    # Fall-detection entry point
├── poseEstimation.py          # Pose-estimation functionality
├── tools.py                   # Fall-detection/data utilities
├── DBConnection.py            # Database connection support
├── requirements.txt           # Python dependencies
├── .gitignore
└── README.md
```

------------------------------------------------------------------------

## Technology Stack

### Frontend

-   Flutter
-   Dart
-   HTTP communication
-   Shared preferences
-   Camera/image functionality
-   Video playback
-   Local notifications
-   Speech-to-text
-   Activity and chart interfaces

### Backend

-   Python
-   Django
-   Django views and URL routing
-   Django models
-   HTML templates
-   Static web resources

### Database

-   MySQL

### AI and Computer Vision

-   YOLOv7-Pose
-   PyTorch
-   Keras/TensorFlow model artifacts
-   OpenCV
-   MediaPipe-based activity/hand pose processing
-   Facial emotion recognition
-   Handwriting recognition
-   Object recognition
-   Person recognition

------------------------------------------------------------------------

## Flutter Application

The Flutter application is located in:

``` text
ElderlyCare-Flutter/
```

Its main source is:

``` text
ElderlyCare-Flutter/lib/
```

Patient-specific features are organized under:

``` text
ElderlyCare-Flutter/lib/Patient/
```

Important patient screens include:

``` text
Patient/
├── Emotion recognition.dart
├── handwriting.dart
├── Object recognition.dart
├── Recognize person.dart
├── new detection.dart
├── viewFall.dart
├── Word rearrangement.dart
├── solvepuzzle.dart
├── scrambleword_new.dart
├── Word pronouncialtion.dart
├── Pill notifications.dart
└── Patient home.dart
```

------------------------------------------------------------------------

## Django Backend

The Django project is located under:

``` text
elderlycare/
```

The management entry point is:

``` text
elderlycare/manage.py
```

The main Django application is:

``` text
elderlycare/my_project/
```

Important files include:

``` text
my_project/
├── admin.py
├── apps.py
├── classes.csv
├── detection_emotion.py
├── emotions_training.py
├── functions.py
├── hand.py
├── models.py
├── scan.py
├── tests.py
├── urls.py
└── views.py
```

------------------------------------------------------------------------

## AI Model Dependencies

### Fall Detection

The fall-detection code expects:

``` text
yolov7-w6-pose.pt
```

in the repository root:

``` text
AI-CareCompanion/
├── yolov7-w6-pose.pt
├── main.py
├── poseEstimation.py
├── models/
├── utils/
└── cfg/
```

The weight file is intentionally not committed to Git.

### Django/Keras Models

The original Django project contains:

``` text
elderlycare/my_project/model.h5
elderlycare/my_project/emo_model_full.h5
```

These `.h5` artifacts are excluded by `.gitignore`.

`model.h5` is referenced by the Django scanning workflow. The current
source uses an absolute Windows path for this model, so that path may
need to be adapted when the application is run on another machine.

`emo_model_full.h5` is produced by the emotion-model training workflow.
The repository should be treated as containing the training
implementation and local model artifact rather than assuming it is
loaded by every runtime path.

------------------------------------------------------------------------

## Datasets and Local Resources

Large/local resources are intentionally excluded from GitHub:

``` text
fall_dataset/
Mydata/
my_model/
yolov7-w6-pose.pt
*.h5
```

These exclusions keep the source repository manageable while preserving
the original local project environment.

------------------------------------------------------------------------

## Installation and Setup

Because the project combines Flutter, Django, MySQL, and AI components,
setup consists of several parts.

### Clone the Repository

``` bash
git clone https://github.com/jamalmujaddidi/AI-CareCompanion.git
cd AI-CareCompanion
```

### Python Environment

Create and activate a virtual environment:

``` bash
python -m venv venv
```

Windows:

``` bash
venv\Scriptsctivate
```

Install the Python dependencies:

``` bash
pip install -r requirements.txt
```

> Additional Python packages required by the Django application may
> depend on the original development environment.

### MySQL

Configure the MySQL database according to the Django project's local
configuration.

Then enter the Django directory:

``` bash
cd elderlycare
```

Run migrations:

``` bash
python manage.py migrate
```

Start the Django server:

``` bash
python manage.py runserver
```

### Flutter

From the repository root, enter:

``` bash
cd ElderlyCare-Flutter
```

Install Flutter dependencies:

``` bash
flutter pub get
```

Run the application:

``` bash
flutter run
```

The current Flutter implementation allows the backend IP address to be
supplied through the application interface.

### Fall Detection Model

Supply the required YOLOv7-Pose weight:

``` text
yolov7-w6-pose.pt
```

and place it in the repository root.

------------------------------------------------------------------------

## Running the System

The project contains multiple connected components, so the exact startup
sequence depends on the intended workflow and local environment.

### Django

From:

``` text
AI-CareCompanion/elderlycare/
```

run:

``` bash
python manage.py runserver
```

### Flutter

From:

``` text
AI-CareCompanion/ElderlyCare-Flutter/
```

run:

``` bash
flutter run
```

### Fall Detection

The dedicated fall-detection implementation uses:

``` text
main.py
poseEstimation.py
tools.py
yolov7-w6-pose.pt
```

Refer to the source code and local environment for the exact execution
workflow.

------------------------------------------------------------------------

## Feature-to-Repository Mapping

  -----------------------------------------------------------------------------------------------
  Functionality                       Main Repository Location
  ----------------------------------- -----------------------------------------------------------
  Fall Detection                      `main.py`, `poseEstimation.py`, `models/`, `utils/`, `cfg/`

  Fall Notifications                  `elderlycare/my_project/views.py` and Flutter notification
                                      screens

  Malayalam Handwriting               `ElderlyCare-Flutter/lib/Patient/handwriting.dart` and
                                      Django handwriting workflow

  Emotion Recognition                 `elderlycare/my_project/detection_emotion.py`,
                                      `emotions_training.py`, and Flutter emotion screen

  Cognitive Activities                `ElderlyCare-Flutter/lib/Patient/`

  Object Recognition                  `ElderlyCare-Flutter/lib/Patient/Object recognition.dart`
                                      and backend

  Person Recognition                  `ElderlyCare-Flutter/lib/Patient/Recognize person.dart` and
                                      backend

  Activity Monitoring                 `ElderlyCare-Flutter/lib/view activity monitoring.dart` and
                                      Django activity workflows

  Doctor Management                   Flutter doctor screens and Django templates/views

  Appointments                        Flutter appointment screens and Django backend

  Medication Notifications            Flutter pill/notification screens and Django notification
                                      workflows

  Tasks and Schedules                 Flutter task/schedule screens and Django backend

  Feedback and Complaints             Flutter feedback/complaint screens and Django
                                      templates/views

  User Roles                          Flutter role-based navigation and Django role-specific
                                      templates/views
  -----------------------------------------------------------------------------------------------

------------------------------------------------------------------------

## Project Results and Evaluation

The academic project documentation evaluates the implemented system
through functional testing and AI-model experiments.

The thesis reports evaluation results for the AI components and
functional modules. Different sections of the academic document contain
different experimental metric tables, so this README intentionally does
not present one metric set as the single definitive result.

For the complete experimental methodology, datasets, model architecture,
testing procedures, and reported results, refer to the academic thesis
associated with the project.

------------------------------------------------------------------------

## Future Enhancements

The academic project identifies additional enhancements for future
versions.

One documented future direction is a **cloud-based family
monitoring/dashboard capability** for broader remote monitoring and
access.

Future work can also improve deployment portability, model management,
and integration among the existing modules.

------------------------------------------------------------------------

## Repository Notes

The repository is maintained on the `main` branch.

The repository intentionally excludes generated and large resources such
as:

-   Python cache files
-   Flutter build artifacts
-   IDE metadata
-   Large video files
-   Dataset directories
-   Large neural-network weights
-   `.h5` model artifacts

Some portions of the original project contain absolute Windows/PyCharm
paths from the original development environment. These may need to be
adapted when deploying the project on another machine.

The source code has not been rewritten in this README to hide those
original implementation details.

------------------------------------------------------------------------

## Academic Project Information

**Project:** AI CareCompanion -- A Smart System for Elderly Wellness and
Monitoring

**Application Technologies:**

-   Python
-   Django
-   Flutter
-   Dart
-   MySQL
-   PyTorch
-   Keras/TensorFlow model artifacts
-   OpenCV
-   MediaPipe

**Primary Areas:**

-   Elderly wellness and monitoring
-   Fall detection
-   Stroke rehabilitation
-   Malayalam handwriting recognition
-   Emotion recognition
-   Cognitive engagement
-   Motor-skill/activity training
-   Healthcare management

------------------------------------------------------------------------

## License

No project-specific open-source license has been established in the
current repository. Unless a license is added, the repository should not
be assumed to grant broad rights to reuse, modify, or redistribute the
project.

------------------------------------------------------------------------

## Repository

GitHub: https://github.com/jamalmujaddidi/AI-CareCompanion
