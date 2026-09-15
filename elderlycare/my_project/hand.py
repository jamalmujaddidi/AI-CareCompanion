# # # import cv2
# # # import mediapipe as mp
# # # import numpy as np
# # #
# # # mp_hands = mp.solutions.hands
# # # mp_drawing = mp.solutions.drawing_utils
# # #
# # # # Load reference image and detect landmarks
# # # def get_hand_landmarks(image_path):
# # #     image = cv2.imread(image_path)
# # #     if image is None:
# # #         print(f"Failed to load image at {image_path}")
# # #         return None
# # #     with mp_hands.Hands(static_image_mode=True, max_num_hands=1) as hands:
# # #         results = hands.process(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
# # #         if results.multi_hand_landmarks:
# # #             return results.multi_hand_landmarks[0], image
# # #     return None, image
# # #
# # # def landmarks_to_np(landmarks):
# # #     return np.array([[lm.x, lm.y, lm.z] for lm in landmarks.landmark])
# # #
# # # # Compare two sets of landmarks
# # # def compare_landmarks(landmarks1, landmarks2):
# # #     if landmarks1 is None or landmarks2 is None:
# # #         return False
# # #     arr1 = landmarks_to_np(landmarks1)
# # #     arr2 = landmarks_to_np(landmarks2)
# # #     # Normalize (remove translation and scale)
# # #     arr1 -= arr1[0]
# # #     arr2 -= arr2[0]
# # #     arr1 /= np.linalg.norm(arr1)
# # #     arr2 /= np.linalg.norm(arr2)
# # #     diff = np.linalg.norm(arr1 - arr2)
# # #     return diff < 0.2  # threshold for similarity
# # #
# # # # Paths to hand images
# # # image1_path = r"C:\Users\amaya\OneDrive\Desktop\yoga-main\hand.jpg"
# # # image2_path = r"C:\Users\amaya\OneDrive\Desktop\yoga-main\hand.jpg"  # second image
# # #
# # # # Get landmarks from both images
# # # landmarks1, image1 = get_hand_landmarks(image1_path)
# # # landmarks2, image2 = get_hand_landmarks(image2_path)
# # #
# # # # Compare and display results
# # # if landmarks1:
# # #     mp_drawing.draw_landmarks(image1, landmarks1, mp_hands.HAND_CONNECTIONS)
# # # if landmarks2:
# # #     mp_drawing.draw_landmarks(image2, landmarks2, mp_hands.HAND_CONNECTIONS)
# # #
# # # match = compare_landmarks(landmarks1, landmarks2)
# # # text = "Match" if match else "No Match"
# # # color = (0, 255, 0) if match else (0, 0, 255)
# # #
# # # # Display images with result
# # # cv2.putText(image1, text, (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, color, 2)
# # # cv2.imshow("Image 1", image1)
# # # cv2.imshow("Image 2", image2)
# # # cv2.waitKey(0)
# # # cv2.destroyAllWindows()
# #
# #
# # # hand.py
# # import sys
# # import cv2
# # import mediapipe as mp
# # import numpy as np
# #
# # mp_hands = mp.solutions.hands
# #
# # def get_hand_landmarks(image_path):
# #     image = cv2.imread(image_path)
# #     if image is None:
# #         return None, None
# #     with mp_hands.Hands(static_image_mode=True, max_num_hands=1) as hands:
# #         results = hands.process(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
# #         if results.multi_hand_landmarks:
# #             return results.multi_hand_landmarks[0], image
# #     return None, image
# #
# # def landmarks_to_np(landmarks):
# #     return np.array([[lm.x, lm.y, lm.z] for lm in landmarks.landmark])
# #
# # def compare_landmarks(landmarks1, landmarks2):
# #     if landmarks1 is None or landmarks2 is None:
# #         return False
# #     arr1 = landmarks_to_np(landmarks1)
# #     arr2 = landmarks_to_np(landmarks2)
# #     arr1 -= arr1[0]
# #     arr2 -= arr2[0]
# #     arr1 /= np.linalg.norm(arr1)
# #     arr2 /= np.linalg.norm(arr2)
# #     diff = np.linalg.norm(arr1 - arr2)
# #     return diff < 0.2
# #
# # if __name__ == "__main__":
# #     if len(sys.argv) != 3:
# #         print("Usage: python hand.py <captured_path> <reference_path>")
# #         sys.exit(1)
# #
# #     captured_path = sys.argv[1]
# #     reference_path = sys.argv[2]
# #
# #     lm1, _ = get_hand_landmarks(captured_path)
# #     lm2, _ = get_hand_landmarks(reference_path)
# #
# #     k="match" if compare_landmarks(lm1, lm2) else "no_match"
# #     print(k)
# #
# #
# #
#
#
# import sys
# import cv2
# import mediapipe as mp
# import numpy as np
#
# mp_hands = mp.solutions.hands
#
# def get_hand_landmarks(image_path):
#     image = cv2.imread(image_path)
#     if image is None:
#         return None, None
#     with mp_hands.Hands(static_image_mode=True, max_num_hands=1) as hands:
#         results = hands.process(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
#         if results.multi_hand_landmarks:
#             return results.multi_hand_landmarks[0], image
#     return None, image
#
# def landmarks_to_np(landmarks):
#     return np.array([[lm.x, lm.y, lm.z] for lm in landmarks.landmark])
#
# def compare_landmarks(landmarks1, landmarks2):
#     if landmarks1 is None or landmarks2 is None:
#         return False
#     arr1 = landmarks_to_np(landmarks1)
#     arr2 = landmarks_to_np(landmarks2)
#
#     # Normalize: translate and scale
#     arr1 -= arr1[0]
#     arr2 -= arr2[0]
#     arr1 /= np.linalg.norm(arr1)
#     arr2 /= np.linalg.norm(arr2)
#
#     diff = np.linalg.norm(arr1 - arr2)
#     return diff < 0.2  # Adjustable threshold
#
# def get_open_fingers(landmarks):
#     fingers_open = []
#
#     if landmarks is None:
#         return fingers_open
#
#     coords = landmarks_to_np(landmarks)
#
#     # Index, Middle, Ring, Pinky
#     tips = [8, 12, 16, 20]
#     pips = [6, 10, 14, 18]
#
#     for tip, pip in zip(tips, pips):
#         if coords[tip][1] < coords[pip][1]:  # Tip higher than pip
#             fingers_open.append(True)
#         else:
#             fingers_open.append(False)
#
#     # Thumb (basic logic: right hand only, left-hand check may vary)
#     if coords[4][0] > coords[3][0]:  # Thumb tip > IP x-position
#         fingers_open.insert(0, True)
#     else:
#         fingers_open.insert(0, False)
#
#     return fingers_open
#
# if __name__ == "__main__":
#     if len(sys.argv) != 3:
#         print("Usage: python hand.py <captured_path> <reference_path>")
#         sys.exit(1)
#
#     captured_path = sys.argv[1]
#     reference_path = sys.argv[2]
#
#     lm1, _ = get_hand_landmarks(captured_path)
#     lm2, _ = get_hand_landmarks(reference_path)
#
#     fingers = get_open_fingers(lm1)
#     print("Open fingers:", fingers)
#     print("Number of fingers open:", sum(fingers))
#
#     result = "match" if compare_landmarks(lm1, lm2) else "no_match"
#     print(result)


# import cv2
# import mediapipe as mp
# import numpy as np
#
# mp_hands = mp.solutions.hands
#
#
# # Jalaludheen
# # Returns a list like [thumb, index, middle, ring, pinky]
# # 1 meaning  nammude finger expanded aaanennum
# # 0 mean close aayirikkunnu ennathaanu
#
# def get_finger_states(landmarks):
#     finger_states = []
#     thumb_tip = landmarks[4]
#     thumb_mcp = landmarks[2]
#     finger_states.append(1 if thumb_tip[0] > thumb_mcp[0] else 0)
#     tips = [8, 12, 16, 20]
#     pips = [6, 10, 14, 18]
#     for tip, pip in zip(tips, pips):
#         finger_states.append(1 if landmarks[tip][1] < landmarks[pip][1] else 0)
#     return finger_states
#
#
# def extract_landmarks(image):
#     with mp_hands.Hands(static_image_mode=True, max_num_hands=1) as hands:
#         results = hands.process(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
#         if results.multi_hand_landmarks:
#             hand_landmarks = results.multi_hand_landmarks[0]
#             return np.array([[lm.x, lm.y, lm.z] for lm in hand_landmarks.landmark])
#     return None
#
#
# def compare_finger_gestures(image1, image2):
#     lm1 = extract_landmarks(image1)
#     lm2 = extract_landmarks(image2)
#
#     if lm1 is None or lm2 is None:
#         return False
#
#     fingers1 = get_finger_states(lm1)
#     fingers2 = get_finger_states(lm2)
#
#     print("Fingers1:", fingers1)
#     print("Fingers2:", fingers2)
#
#     return fingers1 == fingers2
#
#
# image1 = cv2.imread('4fig.jpg')
# image2 = cv2.imread('4fignew.jpg')
#
# same_gesture = compare_finger_gestures(image1, image2)
# print("Same Finger Gesture:" if same_gesture else "Different Finger Gestures")



import cv2
import mediapipe as mp
import numpy as np
import sys

mp_hands = mp.solutions.hands

# Returns a list like [thumb, index, middle, ring, pinky]
# 1 means the finger is extended, 0 means closed
def get_finger_states(landmarks):
    finger_states = []
    thumb_tip = landmarks[4]
    thumb_mcp = landmarks[2]
    finger_states.append(1 if thumb_tip[0] > thumb_mcp[0] else 0)

    tips = [8, 12, 16, 20]
    pips = [6, 10, 14, 18]
    for tip, pip in zip(tips, pips):
        finger_states.append(1 if landmarks[tip][1] < landmarks[pip][1] else 0)
    return finger_states

def extract_landmarks(image):
    with mp_hands.Hands(static_image_mode=True, max_num_hands=1) as hands:
        results = hands.process(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
        if results.multi_hand_landmarks:
            hand_landmarks = results.multi_hand_landmarks[0]
            return np.array([[lm.x, lm.y, lm.z] for lm in hand_landmarks.landmark])
    return None

def compare_finger_gestures(image1, image2):
    lm1 = extract_landmarks(image1)
    lm2 = extract_landmarks(image2)

    if lm1 is None or lm2 is None:
        return False

    fingers1 = get_finger_states(lm1)
    fingers2 = get_finger_states(lm2)

    print("Fingers1:", fingers1)
    print("Fingers2:", fingers2)

    return fingers1 == fingers2

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python hand.py <captured_path> <reference_path>")
        sys.exit(1)

    captured_path = sys.argv[1]
    reference_path = sys.argv[2]

    image1 = cv2.imread(captured_path)
    image2 = cv2.imread(reference_path)

    if image1 is None or image2 is None:
        print("Error reading one or both images")
        sys.exit(1)

    same_gesture = compare_finger_gestures(image1, image2)
    print("match" if same_gesture else "no match")





# import cv2
# import mediapipe as mp
# import numpy as np
# import sys
#
# mp_hands = mp.solutions.hands
#
# # Jalaludheen
# # Returns a list like [thumb, index, middle, ring, pinky]
# # 1 meaning nammude finger expanded aaanennum
# # 0 mean close aayirikkunnu ennathaanu
# def get_finger_states(landmarks):
#     finger_states = []
#     thumb_tip = landmarks[4]
#     thumb_mcp = landmarks[2]
#     finger_states.append(1 if thumb_tip[0] > thumb_mcp[0] else 0)
#     tips = [8, 12, 16, 20]
#     pips = [6, 10, 14, 18]
#     for tip, pip in zip(tips, pips):
#         finger_states.append(1 if landmarks[tip][1] < landmarks[pip][1] else 0)
#     return finger_states
#
# def extract_landmarks(image):
#     with mp_hands.Hands(static_image_mode=True, max_num_hands=1) as hands:
#         results = hands.process(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
#         if results.multi_hand_landmarks:
#             hand_landmarks = results.multi_hand_landmarks[0]
#             return np.array([[lm.x, lm.y, lm.z] for lm in hand_landmarks.landmark])
#     return None
#
# def compare_finger_gestures(image1, image2):
#     lm1 = extract_landmarks(image1)
#     lm2 = extract_landmarks(image2)
#
#     if lm1 is None or lm2 is None:
#         return False
#
#     fingers1 = get_finger_states(lm1)
#     fingers2 = get_finger_states(lm2)
#
#     print("Fingers1:", fingers1)
#     print("Fingers2:", fingers2)
#
#     return fingers1 == fingers2
#
# if __name__ == "__main__":
#     if len(sys.argv) != 3:
#         print("Usage: python hand_finger_match.py <captured_path> <reference_path>")
#         sys.exit(1)
#
#     captured_path = sys.argv[1]
#     reference_path = sys.argv[2]
#
#     image1 = cv2.imread(captured_path)
#     image2 = cv2.imread(reference_path)
#
#     if image1 is None or image2 is None:
#         print("Error loading one of the images.")
#         sys.exit(1)
#
#     same_gesture = compare_finger_gestures(image1, image2)
#     print("Same Finger Gesture" if same_gesture else "Different Finger Gestures")
