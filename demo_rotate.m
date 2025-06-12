% 6 demo for 6
%

% demo_rotate.m - A script to demonstrate the rotateImage function.


clear; clc; close all;
pkg load image; 

imagePath = './test-images/flower.jpg';


rotationAngle = 25;


if ~exist(imagePath, 'file')
  error('Image file not found at: %s\nPlease check the path.', imagePath);
end

original_image = imread(imagePath);
[orig_h, orig_w, ~] = size(original_image);


fprintf('Rotating image by %.1f degrees...\n', rotationAngle);
rotated_image = rotateImage(original_image, rotationAngle);
[rot_h, rot_w, ~] = size(rotated_image);
fprintf('Rotation complete.\n\n');


fprintf('--- Comparison ---\n');
fprintf('Original Dimensions:  %d x %d (W x H)\n', orig_w, orig_h);
fprintf('Rotated Dimensions:   %d x %d (W x H)\n', rot_w, rot_h);

figure('Name', 'Image Rotation Comparison', 'NumberTitle', 'off');



subplot(1, 2, 1);
imshow(original_image);
title(sprintf('Original (%d x %d)', orig_w, orig_h));


subplot(1, 2, 2);
imshow(rotated_image);
title(sprintf('Rotated (%d x %d)', rot_w, rot_h));