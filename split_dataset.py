import os
import shutil
import random

# Settings
image_dir = "dataset1/images"
label_dir = "dataset1/labels"
train_ratio = 0.8  # 80% train, 20% val

# Output folders
output_dirs = [
    "dataset1/images/train", "dataset1/images/val",
    "dataset1/labels/train", "dataset1/labels/val"
]
for d in output_dirs:
    os.makedirs(d, exist_ok=True)

# Collect image files (jpg or png)
image_files = [f for f in os.listdir(image_dir) if f.endswith(('.jpg', '.png'))]
random.shuffle(image_files)

# Split
split_idx = int(len(image_files) * train_ratio)
train_files = image_files[:split_idx]
val_files = image_files[split_idx:]

def move_files(file_list, split):
    for img_file in file_list:
        label_file = os.path.splitext(img_file)[0] + ".txt"

        src_img = os.path.join(image_dir, img_file)
        src_label = os.path.join(label_dir, label_file)

        dst_img = os.path.join(f"dataset1/images/{split}", img_file)
        dst_label = os.path.join(f"dataset1/labels/{split}", label_file)

        if os.path.exists(src_label):
            shutil.copyfile(src_img, dst_img)
            shutil.copyfile(src_label, dst_label)
        else:
            print(f"Warning: label not found for {img_file}, skipping.")

# Execute move
move_files(train_files, "train")
move_files(val_files, "val")

print("Dataset split complete!")