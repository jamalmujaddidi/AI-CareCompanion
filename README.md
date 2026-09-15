# AI CareCompanion

### A Smart System for Elderly Wellness and Monitoring

AI CareCompanion is a modular elderly-care platform developed using **Python, Django, Flutter, MySQL, and AI/computer-vision technologies**. The system brings together physical safety monitoring, rehabilitation support, emotional awareness, cognitive engagement, motor-skill training, and healthcare-management functions within a unified application.

The project is designed particularly to support elderly users and people requiring additional assistance, including users affected by **stroke, autism, and Alzheimer's-related challenges**. It provides separate interfaces and workflows for **Patients, Caretakers, Doctors, and Administrators**.

---

## Overview

Elderly users may require support across several areas at the same time: physical safety, rehabilitation, cognitive stimulation, emotional well-being, medication and appointment management, and communication with caregivers or healthcare professionals.

AI CareCompanion addresses these needs through a combination of:

- **Flutter** for the user-facing application
- **Python/Django** for server-side application logic
- **MySQL** for persistent data management
- **Computer vision and deep-learning models** for intelligent monitoring
- **Pose estimation** for fall and activity-related analysis
- **Facial emotion recognition**
- **Malayalam handwriting recognition** for rehabilitation exercises
- **Object and person recognition**
- **Healthcare and reminder-management workflows**

The project is organized as a modular system so that AI-based components and conventional application features can work together through the backend.

---

## Key Features

### 1. Fall Detection and Physical Safety

The system includes an AI-based fall-detection component that analyzes human pose information to identify potential falls.

The dedicated fall-detection implementation uses:

- **YOLOv7-Pose**
- Human pose estimation
- Video/image-based analysis
- Fall-event processing
- Caregiver notification functionality
- Fall-related image/video handling

The repository's fall-detection implementation loads the pretrained:

```text
yolov7-w6-pose.pt
```

This model file is intentionally not stored in the Git repository because of its large size.

---

### 2. Malayalam Handwriting Recognition for Stroke Rehabilitation

AI CareCompanion provides an interactive handwriting exercise designed to support stroke rehabilitation.

The patient can:

1. Draw a Malayalam character using the application's drawing interface.
2. Capture the drawing as an image.
3. Encode the image for transmission.
4. Send the handwriting data to the Django backend.
5. Receive recognition/evaluation results.
6. Record whether the exercise was successfully completed.

The Flutter implementation communicates with the backend through the handwriting-related Django endpoints and records exercise results.

This feature is intended to provide an interactive approach to fine-motor rehabilitation and handwriting practice.

---

### 3. Facial Emotion Recognition

The system includes facial emotion recognition using a deep-learning model trained with the **FER-2013 dataset**.

The emotion-recognition component supports:

- Face detection
- Facial-expression analysis
- Emotion classification
- Model-based inference
- Integration with the elderly-care application

The backend contains the emotion-training and inference components, including the trained emotion model.

> **Note:** The thesis contains different reported training/validation/test figures in different sections. This README therefore does not present a single accuracy figure as the definitive project result.

---

### 4. Cognitive Engagement Activities

AI CareCompanion includes activities intended to provide cognitive stimulation and engagement.

Examples include:

- Word rearrangement
- Scrambled-word activities
- Image puzzles
- Puzzle-solving activities
- Object recognition
- Person recognition
- Word pronunciation-related functionality

These activities are integrated into the patient-facing Flutter application.

---

### 5. Motor-Skill and Activity Training

The platform includes camera-based activity and motor-skill monitoring functionality.

The system can use computer-vision/pose information to support physical exercises and activity monitoring. The project documentation describes **MediaPipe-based hand/pose analysis** for rehabilitation-oriented activity tracking.

The purpose is to provide interactive exercises and support monitoring of rehabilitation-related activities.

---

### 6. Healthcare Management

The platform provides application-level healthcare-management functionality for patients, caretakers, doctors, and administrators.

Functions represented in the application include:

- Doctor registration
- Doctor search
- Doctor viewing
- Doctor-patient interaction
- Appointment creation
- Appointment viewing
- Appointment management
- Patient registration
- Patient management
- Caretaker-related workflows
- Complaints
- Feedback
- Doctor communication/chat functionality

---

### 7. Medication and Reminder Management

The application includes reminder and medication-related functionality.

Examples include:

- Pill/medication notifications
- Pill-time management
- Reminder viewing
- Task creation
- Task editing
- Schedule creation
- Schedule editing
- Notification functionality

These features are integrated into the patient and caretaker workflows.

---

## User Roles

AI CareCompanion provides different functionality according to the user's role.

### Patient

The patient-facing application provides access to:

- Fall-related information
- Handwriting rehabilitation
- Emotion recognition
- Cognitive activities
- Object recognition
- Person recognition
- Word activities
- Tasks and reminders
- Pill notifications
- Appointments
- Profile management
- Activity monitoring
- Rehabilitation-related activities

### Caretaker

Caretakers can interact with patient-related information and monitoring functionality, including:

- Patient management
- Fall notifications
- Patient activities
- Appointments
- Tasks and schedules
- Medication-related information
- Profile-related functions

### Doctor

Doctors have application functionality related to:

- Doctor registration
- Patient/doctor interaction
- Appointments
- Patient-related information
- Communication
- Feedback and related workflows

### Administrator

The backend includes administrator-oriented functionality for managing system data and users.

---

## System Architecture

At a high level, AI CareCompanion follows a layered architecture:

```text
┌──────────────────────────────────────┐
│          Flutter Application         │
│                                      │
│ Patient │ Caretaker │ Doctor │ Admin│
└──────────────────┬───────────────────┘
                   │
                   │ HTTP Requests
                   ▼
┌──────────────────────────────────────┐
│          Python / Django Backend     │
│                                      │
│ Authentication │ Views │ URLs        │
│ Application Logic │ Notifications    │
│ Healthcare Management │ AI Endpoints │
└───────────────┬───────────────┬──────┘
                │               │
                ▼               ▼
┌─────────────────────┐  ┌──────────────────────┐
│     AI / CV Models  │  │       MySQL           │
│                     │  │                       │
│ Fall Detection      │  │ Users / Patients      │
│ Emotion Recognition │  │ Appointments          │
│ Handwriting         │  │ Tasks / Schedules     │
│ Object Recognition  │  │ Notifications         │
│ Pose / Activity     │  │ Other application data│
└─────────────────────┘  └──────────────────────┘
```

### Application Flow

A typical interaction follows this pattern:

```text
User
  ↓
Flutter UI
  ↓
HTTP Request
  ↓
Django URL / View
  ↓
Application Logic
  ↓
AI Model and/or Database
  ↓
Response
  ↓
Flutter UI
```

---

## Repository Structure

The repository contains the major components of the complete AI CareCompanion system.

```text
AI-CareCompanion/
│
├── ElderlyCare-Flutter/          # Flutter mobile/application frontend
│   ├── android/
│   ├── ios/
│   ├── linux/
│   ├── macos/
│   ├── web/
│   ├── windows/
│   ├── assets/
│   ├── lib/
│   │   ├── Patient/
│   │   └── ...
│   ├── test/
│   └── pubspec.yaml
│
├── elderlycare/                  # Django project configuration
│   ├── settings.py
│   ├── urls.py
│   ├── asgi.py
│   └── wsgi.py
│
├── my_project/                   # Django application
│   ├── views.py
│   ├── urls.py
│   ├── models.py
│   ├── functions.py
│   ├── detection_emotion.py
│   ├── emotions_training.py
│   ├── hand.py
│   ├── scan.py
│   ├── model.h5
│   ├── emo_model-full.h5
│   ├── classes.csv
│   ├── migrations/
│   ├── static/
│   └── ...
│
├── templates/                    # Django HTML templates
│   ├── Admin/
│   ├── Caretaker/
│   ├── Doctor/
│   ├── login.html
│   └── login_index.html
│
├── cfg/                          # YOLO configuration files
├── models/                       # YOLO/model implementation components
├── utils/                        # Supporting YOLO utilities
│
├── DBConnection.py               # Database connection component
├── main.py                       # Fall-detection entry point
├── poseEstimation.py             # Pose-estimation component
├── requirements.txt              # Python dependencies
├── .gitignore
└── README.md
```

---

## Technology Stack

### Frontend

- **Flutter**
- **Dart**
- HTTP communication
- Shared preferences/local application state
- Camera/image functionality
- Video functionality
- Speech-related functionality
- Local notifications
- Charts and activity visualization

### Backend

- **Python**
- **Django**
- Django views and URL routing
- Application/business logic
- HTTP-based communication with the Flutter client

### Database

- **MySQL**

The database layer is used for persistent application information such as users, patients, appointments, schedules, tasks, notifications, and related records.

### Artificial Intelligence / Computer Vision

- **YOLOv7-Pose**
- Pose estimation
- Deep-learning-based facial emotion recognition
- FER-2013
- Handwriting recognition
- Object recognition
- Person recognition
- Computer-vision-based activity monitoring
- MediaPipe-based pose/hand analysis for rehabilitation-oriented activities

---

## AI Components

### Fall Detection

The dedicated fall-detection component is based on **YOLOv7-Pose**.

Important files include:

```text
main.py
poseEstimation.py
models/
utils/
cfg/
```

The implementation expects the pretrained model:

```text
yolov7-w6-pose.pt
```

to be available in the project root.

---

### Emotion Recognition

The Django application contains emotion-recognition components including:

```text
my_project/detection_emotion.py
my_project/emotions_training.py
my_project/emo_model-full.h5
```

The project documentation identifies **FER-2013** as the dataset used for emotion-recognition model training.

---

### Malayalam Handwriting Recognition

Relevant implementation is located in the Flutter patient module and Django backend.

Flutter:

```text
ElderlyCare-Flutter/lib/Patient/handwriting.dart
```

Backend-related functionality includes:

```text
my_project/hand.py
```

The Flutter handwriting module captures the user's drawing and communicates with the Django backend for recognition/evaluation.

---

### Object and Person Recognition

The project includes patient-facing functionality for:

- Object recognition
- Person recognition

Relevant Flutter screens include:

```text
ElderlyCare-Flutter/lib/Patient/Object recognition.dart
ElderlyCare-Flutter/lib/Patient/Recognize person.dart
```

The Django application also contains corresponding backend processing/routes.

---

## Datasets and Model Dependencies

### FER-2013

The emotion-recognition component uses the **FER-2013 facial-expression dataset**.

### Fall Detection Data

The fall-detection implementation uses project-specific fall-detection data and preprocessing components. The repository's fall-detection code references the local fall-detection dataset structure.

Large datasets and runtime-generated data are intentionally not included in the Git repository when they are not required as source code.

### Pretrained YOLOv7-Pose Weights

The fall-detection system requires:

```text
yolov7-w6-pose.pt
```

The weight file is intentionally excluded from Git because of its large size.

Place the file in:

```text
AI-CareCompanion/
└── yolov7-w6-pose.pt
```

alongside:

```text
main.py
poseEstimation.py
models/
utils/
cfg/
```

---

## Installation and Setup

> The project consists of multiple components. Setup should therefore be performed for the Django/Python backend, database, Flutter application, and AI dependencies.

### 1. Clone the Repository

```bash
git clone https://github.com/jamalmujaddidi/AI-CareCompanion.git
cd AI-CareCompanion
```

---

### 2. Python Environment

Create and activate a Python virtual environment:

```bash
python -m venv venv
```

Windows:

```bash
venv\Scripts\activate
```

Linux/macOS:

```bash
source venv/bin/activate
```

Install the Python dependencies:

```bash
pip install -r requirements.txt
```

> The exact dependency requirements should be taken from the repository's `requirements.txt`.

---

### 3. Configure MySQL

Create/configure the MySQL database required by the Django application.

The Django project's database configuration is located in:

```text
elderlycare/settings.py
```

Database credentials and local environment-specific configuration should be supplied according to the local development environment.

---

### 4. Django Setup

From the repository root:

```bash
python manage.py migrate
```

Start the Django development server:

```bash
python manage.py runserver
```

The backend is used by the Flutter application for authentication, healthcare workflows, notifications, AI-related requests, and other application operations.

---

### 5. Flutter Setup

Open:

```text
ElderlyCare-Flutter/
```

Install Flutter dependencies:

```bash
flutter pub get
```

Run the Flutter application using an appropriate emulator, connected device, or supported desktop/web target.

```bash
flutter run
```

---

### 6. Configure Backend Address in Flutter

The Flutter application contains an IP-address configuration flow.

The application constructs the backend URL in the form:

```text
http://<IP_ADDRESS>:8000/my_project
```

The IP address should correspond to the machine running the Django server when the Flutter application is communicating with a backend running on another device.

---

### 7. Fall Detection Model

Before running the fall-detection component, make sure:

```text
yolov7-w6-pose.pt
```

is available in the repository root.

The source code loads the model from that location.

---

## Running the System

Because AI CareCompanion contains multiple interconnected components, the general development workflow is:

```text
1. Start MySQL
       ↓
2. Start Django backend
       ↓
3. Configure backend IP in Flutter
       ↓
4. Run Flutter application
       ↓
5. Use the required patient/caretaker/doctor workflow
       ↓
6. Invoke the corresponding AI or healthcare feature
```

For standalone fall-detection development, the YOLOv7-Pose component can be run through the dedicated Python implementation.

---

## Backend API / Endpoint Integration

The Flutter application communicates with the Django backend using HTTP requests.

Examples of application-level backend functionality include endpoints related to:

- Login/authentication
- Handwriting recognition
- Handwriting exercise result recording
- Fall notifications
- Emotion recognition
- Object recognition
- Person recognition
- Pose/activity monitoring
- Pill notifications
- Doctors
- Caretakers
- Patients
- Appointments
- Tasks
- Schedules

The exact routes and implementation are defined in:

```text
my_project/urls.py
my_project/views.py
```

The Flutter client stores and uses the configured backend URL for these requests.

---

## Database

MySQL is used as the persistent database layer.

The Django application contains the database model definitions in:

```text
my_project/models.py
```

The database supports application information associated with the platform's healthcare and monitoring workflows.

The repository also contains:

```text
my_project/migrations/
```

for Django database migrations.

---

## Application Modules

The Flutter application contains screens and workflows covering areas such as:

```text
Authentication
├── Login
├── Signup
└── Profile

Patient
├── Patient Home
├── Fall Information
├── Handwriting Rehabilitation
├── Emotion Recognition
├── Object Recognition
├── Person Recognition
├── Cognitive Activities
├── Word Rearrangement
├── Puzzles
├── Reminders
├── Pill Notifications
├── Appointments
└── Activity Monitoring

Healthcare
├── Doctor Registration
├── Doctor Search
├── Doctor View
├── Appointment Creation
├── Appointment View
└── Doctor Communication

Care Management
├── Patient Management
├── Tasks
├── Schedules
├── Notifications
├── Feedback
└── Complaints
```

---

## Project Evaluation

The thesis documents evaluation of the system through functional and model-related testing.

The evaluation covers areas including:

- Functional testing
- Integration testing
- AI/model evaluation
- Application workflows
- User-oriented system functionality

The thesis contains multiple experiment/result sections with differing reported emotion-recognition metrics. To avoid presenting conflicting experimental figures as one definitive result, this README focuses on the implemented system and its documented evaluation methodology rather than selecting one metric set.

---

## Thesis and Implementation Alignment

The academic thesis describes the intended architecture, objectives, modules, datasets, and evaluation of AI CareCompanion. The GitHub repository contains the implemented project components.

Where the thesis and implementation use different terminology or contain multiple descriptions, this README follows the **actual repository implementation for code-specific details**.

Important examples:

- The dedicated fall-detection source code uses **YOLOv7-Pose** and loads `yolov7-w6-pose.pt`.
- The thesis contains references to pose-estimation technologies in different contexts; therefore, this README identifies the concrete YOLOv7-Pose implementation for the dedicated fall-detection component.
- The thesis contains different handwriting input-size descriptions; no specific input size is asserted here unless required by the verified implementation.
- The thesis contains more than one set of emotion-recognition result figures; no single set is selected as the definitive project result.
- The thesis discusses cloud-based family monitoring as a future enhancement rather than an implemented current feature.

---

## Future Enhancements

The project can be extended with additional functionality described in the academic work, including:

- Cloud-based family/caregiver monitoring
- Expanded remote monitoring
- Additional rehabilitation exercises
- Further AI model improvements
- Broader healthcare-management capabilities
- Additional patient-support activities

Future enhancements should be distinguished from the functionality currently implemented in the repository.

---

## Repository Notes

### Large Files

Some project resources are intentionally not stored in Git because of their size or because they are generated/runtime data.

Examples include:

```text
yolov7-w6-pose.pt
fall_dataset/
my_model/
Mydata/
runtime media
generated build files
```

The source code that references these resources remains in the repository.

### Flutter Generated Files

Generated Flutter/build directories such as:

```text
.dart_tool/
build/
.idea/
```

are not part of the committed source distribution.

The repository contains the Flutter source under:

```text
ElderlyCare-Flutter/
```

---

## Academic Project Information

**Project:** AI CareCompanion – A Smart System for Elderly Wellness and Monitoring

**Project Type:** Master's Final Project

**Primary Technologies:**

- Python
- Django
- Flutter
- Dart
- MySQL
- Deep Learning
- Computer Vision
- YOLOv7-Pose
- MediaPipe-based activity/pose analysis

**Core Areas:**

- Elderly wellness
- Fall detection
- Stroke rehabilitation
- Malayalam handwriting recognition
- Emotion recognition
- Cognitive engagement
- Motor-skill training
- Healthcare management
- Medication/reminder support

---

## Project Architecture at a Glance

```text
                         AI CareCompanion
                                │
             ┌──────────────────┴──────────────────┐
             │                                     │
       Flutter Frontend                     Django Backend
             │                                     │
             │                         ┌───────────┴───────────┐
             │                         │                       │
             │                    AI / Computer Vision      MySQL
             │                         │                       │
             │              ┌──────────┼──────────┐            │
             │              │          │          │            │
             │          Fall       Emotion   Handwriting    Application
             │        Detection   Recognition Recognition      Data
             │              │          │          │
             └──────────────┴──────────┴──────────┴────────────┘
                                │
                       Elderly Care Platform
                                │
              ┌─────────────────┼─────────────────┐
              │                 │                 │
           Patient          Caretaker          Doctor/Admin
```

---

## Conclusion

AI CareCompanion combines AI-powered monitoring and rehabilitation features with healthcare-management and daily-care functionality in a single elderly-care platform.

By integrating a **Flutter application**, **Python/Django backend**, **MySQL database**, and multiple **AI/computer-vision components**, the project provides a foundation for supporting elderly users across physical safety, rehabilitation, cognitive engagement, emotional awareness, and healthcare management.

The repository represents the complete multi-component implementation of the AI CareCompanion project, including its Flutter frontend, Django application, AI-related Python modules, and supporting model/configuration files.
