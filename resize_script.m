% 2
%
% resize_script.m - Resizes an image to fit within specified dimensions
% while maintaining the original aspect ratio.
%
% This script demonstrates:
% 1. Loading an image.
% 2. Calculating the correct new dimensions to preserve aspect ratio.
% 3. Resizing the image using the 'imresize' function.
% 4. Displaying the original and resized images side-by-side for comparison.
% 5. Printing the resolution and quality comparison to the command window.


clear; clc; close all;

pkg load image; % Load the image package


imagePath = './test-images/flower.jpg'; 


target_width = 300;
target_height = 250;


if ~exist(imagePath, 'file')
  error('Image file not found at: %s\nPlease check the path.', imagePath);
end

original_image = imread(imagePath);
[orig_height, orig_width, num_channels] = size(original_image);

fprintf('--- Image Resizing Analysis ---\n');
fprintf('Original Image Resolution: %d x %d pixels\n', orig_width, orig_height);



scale_ratio_width = target_width / orig_width;
scale_ratio_height = target_height / orig_height;


scale_factor = min(scale_ratio_width, scale_ratio_height);


new_width = round(orig_width * scale_factor);
new_height = round(orig_height * scale_factor);

fprintf('Target Bounding Box: %d x %d pixels\n', target_width, target_height);
fprintf('Calculated Resized Resolution: %d x %d pixels (Aspect Ratio Preserved)\n\n', new_width, new_height);


% The 'imresize' function handles the interpolation. The default method
% is 'bicubic', which provides a good balance of quality and speed.
resized_image = imresize(original_image, [new_height, new_width]);



figure('Name', 'Image Resizing Comparison', 'NumberTitle', 'off');


subplot(1, 2, 1);
imshow(original_image);
title(sprintf('Original (%d x %d)', orig_width, orig_height));
axis on;


subplot(1, 2, 2);
imshow(resized_image);
title(sprintf('Resized (%d x %d)', new_width, new_height));
axis on;




fprintf('--- Comparison Notes ---\n');
disp('See the generated figure for a visual comparison.');
disp('Detailed analysis on quality and resolution is provided in the documentation.');