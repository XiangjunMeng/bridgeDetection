import os 
import random 
import shutil

random.seed(42)
images_folder = 'c:/Users/robot/Desktop/BridgeLabelingJQ/dataset1/images'
labels_folder = 'c:/Users/robot/Desktop/BridgeLabelingJQ/dataset1/labels'

output_images_train ='c:/Users/robot/Desktop/BridgeLabelingJQ/dataset/train/images'
output_labels_train ='c:/Users/robot/Desktop/BridgeLabelingJQ/dataset/train/labels'
output_images_val ='c:/Users/robot/Desktop/BridgeLabelingJQ/dataset/val/images'
output_labels_val ='c:/Users/robot/Desktop/BridgeLabelingJQ/dataset/val/labels'

os.makedirs(output_images_train, exist_ok = True)
os.makedirs(output_labels_train, exist_ok = True)
os.makedirs(output_images_val, exist_ok = True)
os.makedirs(output_labels_val, exist_ok = True)

image_files = [f for f in os.listdir(images_folder) if f.endswith(('.JPG'))]
random.shuffle(image_files)
train_ratio = 0.8
train_count = int(len(image_files) * train_ratio)
print(int(len(image_files)))

train_files = image_files[:train_count]
val_files = image_files[train_count:]
for file in train_files:
    shutil.copy(os.path.join(images_folder, file), output_images_train)
    label_file = file.replace('.JPG', '.txt')
    if os.path.exists(os.path.join(labels_folder, label_file)):
        shutil.copy(os.path.join(labels_folder, label_file), output_labels_train)

for file in val_files:
    shutil.copy(os.path.join(images_folder, file), output_images_val)
    label_file = file.replace('.JPG', '.txt')
    if os.path.exists(os.path.join(labels_folder, label_file)):
        shutil.copy(os.path.join(labels_folder, label_file), output_labels_val)

print("finished!")
