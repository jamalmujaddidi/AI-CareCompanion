# # detect_emotion.py
# import sys
# import cv2
# from fer import FER
#
# if len(sys.argv) != 2:
#     print("error")
#     sys.exit(1)
#
# image_path = sys.argv[1]
# image = cv2.imread(image_path)
#
# if image is None:
#     print("error")
#     sys.exit(1)
#
# detector = FER(mtcnn=True)
# result = detector.top_emotion(image)
#
# if result:
#     emotion, score = result
#     print(emotion)
# else:
#     print("no_face")
import sys
import cv2
from fer import FER

if len(sys.argv) != 2:
    print("error")
    sys.exit(1)

image_path = sys.argv[1]
image = cv2.imread(image_path)

if image is None:
    print("error")
    sys.exit(1)

detector = FER(mtcnn=True)
result = detector.top_emotion(image)

if result:
    emotion, score = result
    print(emotion)  # 👈 Keep this as the LAST and ONLY meaningful output
else:
    print("no_face")
