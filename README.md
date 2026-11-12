Author：
Xiangjun Meng

Overview

Visual inspection is an important part of bridge condition assessment, but manually reviewing large collections of inspection images can be time-consuming. This repository explores deep-learning-based identification and localization of visible surface damage in bridge images.

The available code and experiment artifacts support the following workflow:
1. Prepare bridge inspection images and corresponding annotations.
2. Convert or organize labels and split the dataset into training and validation sets.
3. Train YOLO object-detection models on five labeled categories.
4. Evaluate the trained models using precision, recall, mAP, confusion matrices, and validation predictions.
5. Run inference on new inspection images using an appropriate trained model checkpoint.

Note: Spalling and Spalling2 are separate labels in the present dataset. Their precise annotation distinction should be confirmed before merging or renaming them.

The experiment directories are archived training outputs, not a single end-to-end application entry point.
Requirements

- Python 3 and pip
- Ultralytics YOLO
- PyTorch (installed through a compatible Ultralytics environment)
- Optional for preprocessing: OpenCV, NumPy, SciPy, and Matplotlib
- Optional: MATLAB for working with the original .mat annotations and juanpath.m

Install the Python dependencies:

pip install ultralytics opencv-python numpy scipy matplotlib

A CUDA-compatible GPU is recommended for training large images; CPU inference is also possible.

Getting Started

1. Clone the repository
git clone https://github.com/XiangjunMeng/bridgeDetection.git
cd bridgeDetection
2. Prepare the dataset
The repository provides source images in images/ and corresponding YOLO text labels in labels/. Each YOLO detection annotation has the form:
class_id x_center y_center width height
Bounding-box coordinates are normalized to the image dimensions.

For a standard Ultralytics training layout, organize the data as follows:
dataset/

├── images/

│   ├── train/

│   └── val/

└── labels/

    ├── train/
    
    └── val/
    
Both datasplit.py and split_dataset.py implement an 80/20 training/validation split, but their input and output paths must be edited for your machine. The first utility expects uppercase .JPG filenames and uses a fixed random seed; the second expects lowercase .jpg or .png and does not set a random seed. Use only one split script for a given dataset.

Important: Inspect the image/label filenames before splitting: some repository labels may not have matching images in the current checkout. Validate the resulting pairs before training.
3. Train an object detector
One saved YOLO11 experiment (detect/train20/args.yaml) used yolo11s.pt, 50 epochs, batch size 16, and image size 640. A corresponding training command is:

yolo detect train model=yolo11s.pt data=dataset.yaml epochs=50 imgsz=640 batch=16

This command illustrates how to reproduce that configuration, not a guarantee of identical results across dataset splits, hardware, or software versions.

Earlier saved experiments also include a YOLOv8-based setup, so results from different experiment directories may not be directly comparable.
Potential Applications
- Automated screening of bridge inspection photographs
- Multi-class localization of visible concrete surface damage
- Research on computer vision for infrastructure condition monitoring
- Evaluation of object-detection architectures on domain-specific image data

Acknowledgments

This repository uses the Ultralytics YOLO ecosystem. Please follow the upstream project's license and attribution requirements. Ownership and reuse permissions for inspection images and annotation data should be verified independently.
License
No project-specific license is currently documented in this repository. Unless a license is added, public visibility alone does not grant broad permission to reuse or redistribute its contents.
