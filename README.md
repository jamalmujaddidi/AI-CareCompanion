# AI CareCompanion — Fall Detection

> **A Smart System for Elderly Wellness & Monitoring**

The **Fall Detection** module is a core safety component of the AI CareCompanion Master's project. It analyzes video frames, estimates human body poses using **YOLOv7-Pose**, and applies geometric body-position rules to identify potential falls.

The module is designed to support elderly monitoring and caregiver notification by detecting fall events from video input.

---

## Overview

The Fall Detection pipeline follows these main stages:

```text
Input Video
    ↓
Frame-by-Frame Processing
    ↓
YOLOv7-Pose Human Pose Estimation
    ↓
17 Body Keypoints
    ↓
Body Geometry / Position Analysis
    ↓
Fall Detection Decision
    ↓
Fall Notification & Evidence Image
```

For each detected person, the pose-estimation model provides **17 body keypoints** representing important body parts. These keypoints are then used by the fall-detection logic to evaluate the person's body position.

---

## Key Features

- Video-based human fall detection
- Human pose estimation using YOLOv7-Pose
- 17 body keypoints for each detected person
- Rule-based fall detection using body-part positions and bounding-box geometry
- Fall-event image capture
- Database notification support
- CPU/GPU support through PyTorch
- Processing of multiple videos from the configured video directory

---

## Technology Stack

| Technology | Purpose |
|---|---|
| Python | Core implementation |
| PyTorch | Deep-learning model execution |
| YOLOv7-Pose | Human pose estimation |
| OpenCV | Video and image processing |
| NumPy | Numerical processing |
| MySQL | Fall notification storage |
| tqdm | Processing progress display |

---

## Project Structure

```text
AI-CareCompanion/
│
├── main.py                  # Main fall-detection pipeline
├── poseEstimation.py        # Pose-estimation related functionality
├── DBConnection.py          # MySQL database connection and queries
├── requirements.txt         # Python dependencies
│
├── models/                  # YOLO model architecture/code
├── utils/                   # YOLOv7 utility modules
├── cfg/                     # Model configuration files
│
├── fall_dataset/            # Local dataset and test videos
├── Mydata/                  # Local project data/examples
├── my_model/                # Local model/checkpoint files
│
└── yolov7-w6-pose.pt        # YOLOv7-Pose pretrained weights (local)
```

> **Note:** Large datasets, generated results, local model weights, and machine-specific files are intentionally excluded from the public Git repository where appropriate. They should be obtained or prepared locally according to the setup instructions below.

---

## Requirements

The project requires Python and the packages listed in:

```text
requirements.txt
```

Install the dependencies with:

```bash
pip install -r requirements.txt
```

A compatible PyTorch installation is required for the available CPU/GPU environment.

---

## YOLOv7-Pose Model

The Fall Detection module uses the **YOLOv7-Pose** model for human pose estimation.

The pretrained weight file is:

```text
yolov7-w6-pose.pt
```

Because the model weights are large, they are not stored directly in this GitHub repository.

Download the required YOLOv7-Pose weights and place the file in the project root:

```text
AI-CareCompanion/
└── yolov7-w6-pose.pt
```

---

## Dataset and Test Videos

The Fall Detection module uses fall/non-fall image data and video examples for development and testing.

The expected local structure includes:

```text
fall_dataset/
├── images/
│   ├── fall/
│   └── not-fall/
│
├── videos/
│   ├── video_1.mp4
│   ├── video_2.mp4
│   └── ...
│
├── old/
├── data/
└── results/
```

The complete dataset and generated video results are not included in the public repository to keep the repository focused on source code and documentation.

---

## How the Fall Detection Works

The system first processes the input video and obtains human pose information using YOLOv7-Pose.

The detected pose contains 17 keypoints. The fall-detection algorithm then examines relationships between body landmarks and the person's bounding box.

The current implementation considers factors such as:

- Relative vertical positions of shoulders and lower-body/foot keypoints
- Body-length relationships
- Bounding-box width and height
- Whether the detected person's body orientation is consistent with a possible fall

When the conditions indicate a possible fall, the system can:

1. Mark the event as a fall.
2. Save an image associated with the event.
3. Create a fall notification in the configured database.

This approach was selected after an initial LSTM-based approach did not achieve satisfactory results on the available image dataset.

---

## Experimental Results

The original Fall Detection experiments reported the following results on the project's own data:

| Metric | Result |
|---|---:|
| Accuracy | **81.18%** |
| Precision | **83.27%** |
| Recall | **83.58%** |
| F1 Score | **83.42%** |

The original project also reported processing video at approximately **15 FPS** when using an NVIDIA Tesla K80 GPU.

These figures describe the experimental results reported for this Fall Detection implementation and should not be interpreted as a universal performance guarantee for different datasets or hardware.

---

## Database Configuration

The Fall Detection module includes database functionality for storing fall notifications.

The original implementation uses a MySQL database and expects the required database/table structure to be available.

Before enabling database notifications, configure the database connection in:

```text
DBConnection.py
```

For a public deployment, database credentials should be supplied through environment variables or another secure configuration mechanism rather than committed to source control.

> **Security note:** Never commit real database passwords, API keys, or other credentials to GitHub.

---

## Running the Fall Detection Module

After installing the dependencies and placing the required model weights and test videos in their expected locations:

```bash
python main.py
```

The current implementation processes the videos configured under:

```text
fall_dataset/videos
```

Make sure the YOLOv7-Pose weights are available in the project root before running the program.

---

## Example Results

The original implementation generated processed video examples showing pose estimation and fall-detection results.

Generated result files are treated as local output rather than required source files for the public repository.

---

## Relationship to AI CareCompanion

Fall Detection is one component of the broader **AI CareCompanion — A Smart System for Elderly Wellness & Monitoring** project.

The overall system is intended to combine:

- Elderly safety monitoring
- AI-based fall detection
- Caregiver alerts
- Rehabilitation support
- Malayalam handwriting recognition for stroke rehabilitation
- Cognitive activities
- Doctor appointment booking
- Personalized reminders
- Motor-skill training using pose estimation

The Fall Detection module provides the safety-monitoring foundation for the wider system.

---

## Limitations

The current Fall Detection implementation is a research/project prototype and has limitations.

Performance can vary depending on:

- Camera position
- Lighting conditions
- Person visibility
- Multiple people in a frame
- Video resolution
- Body occlusion
- Dataset characteristics
- Hardware and processing environment

The reported experimental metrics should therefore be considered results for the project's evaluation setup rather than a guarantee of real-world clinical performance.

---

## Future Improvements

Possible future improvements include:

- Real-time camera/RTSP support
- Improved fall-event filtering to reduce repeated notifications
- More diverse training and evaluation data
- Improved handling of multiple people
- Better configuration management
- Integration with the Flutter application
- More robust caregiver alert delivery
- Continuous monitoring and real-time event handling

---

## Academic Project

**Project:** AI CareCompanion — A Smart System for Elderly Wellness & Monitoring

**Module:** Fall Detection

**Implementation:** Python-based computer vision and pose-estimation pipeline

This module forms part of a Master's final project focused on AI-assisted elderly wellness, monitoring, rehabilitation, and caregiver support.

---

## Acknowledgements

This project uses the YOLOv7-Pose architecture and related open-source components for human pose estimation.

Please refer to the original YOLOv7 project and its documentation for model details and licensing information.

---

## License

No project license has currently been selected for this repository.

If this project is later released for public reuse, an appropriate open-source license should be selected and added after confirming the licensing requirements of all included dependencies and source components.
