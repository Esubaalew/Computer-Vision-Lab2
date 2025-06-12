% 5
%
% interpolation_comparison.m - Implements and compares image resizing using
% different interpolation techniques.
%
% This script demonstrates resizing an image using:
%   1. Nearest Neighbor Interpolation
%   2. Bilinear Interpolation
%   3. Bicubic Interpolation
%
% It provides a visual comparison of the output quality and a quantitative
% comparison of the computational efficiency (execution time) for each method.
% Upscaling is used to make the differences more apparent.


clear; clc; close all;
pkg load image; 


imagePath = './test-images/peppers.jpeg';

% Define the scaling factor. >1 for upscaling, <1 for downscaling.
scale_factor = 4;


if ~exist(imagePath, 'file')
  error('Image file not found at: %s\nPlease check the path.', imagePath);
end

original_image = imread(imagePath);
[orig_height, orig_width, ~] = size(original_image);


new_height = round(orig_height * scale_factor);
new_width = round(orig_width * scale_factor);

fprintf('--- Image Interpolation Comparison ---\n');
fprintf('Original Image Size: %d x %d\n', orig_width, orig_height);
fprintf('Upscaling by a factor of %d to new size: %d x %d\n\n', scale_factor, new_width, new_height);



% Method 1: Nearest Neighbor
fprintf('1. Applying Nearest Neighbor interpolation...');
tic; % Start timer
resized_nearest = imresize(original_image, [new_height, new_width], 'nearest');
time_nearest = toc; % Stop timer
fprintf(' Done. (Time: %.4f seconds)\n', time_nearest);

% Method 2: Bilinear
fprintf('2. Applying Bilinear interpolation...');
tic; % Start timer
resized_bilinear = imresize(original_image, [new_height, new_width], 'bilinear');
time_bilinear = toc; % Stop timer
fprintf(' Done. (Time: %.4f seconds)\n', time_bilinear);

% Method 3: Bicubic
fprintf('3. Applying Bicubic interpolation (Default)...');
tic; 
resized_bicubic = imresize(original_image, [new_height, new_width], 'bicubic');
time_bicubic = toc;
fprintf(' Done. (Time: %.4f seconds)\n\n', time_bicubic);


figure('Name', 'Interpolation Method Comparison', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 800]);



subplot(2, 2, 1);
imshow(original_image);
title(sprintf('Original (%d x %d)', orig_width, orig_height));


subplot(2, 2, 2);
imshow(resized_nearest);
title(sprintf('Nearest Neighbor (%.4f s)', time_nearest));


subplot(2, 2, 3);
imshow(resized_bilinear);
title(sprintf('Bilinear (%.4f s)', time_bilinear));


subplot(2, 2, 4);
imshow(resized_bicubic);
title(sprintf('Bicubic (%.4f s)', time_bicubic));

disp('Comparison complete. See the figure window for visual results.');