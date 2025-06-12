      
% 4
%
% demo_crop.m - A script to demonstrate the use of the cropImage function.


clear; clc; close all;

pkg load image; 
imagePath = './test-images/peppers.jpeg';


if ~exist(imagePath, 'file')
  error('Image file not found at: %s\nPlease check the path.', imagePath);
end

original_image = imread(imagePath);



% Let us crop the yellow pepper from the 'peppers.png' image.
topLeft_x = 180;
topLeft_y = 50;
bottomRight_x = 380;
bottomRight_y = 200;
cropBox = [topLeft_x, topLeft_y, bottomRight_x, bottomRight_y];

fprintf('Original Image Size: %d x %d\n', size(original_image, 2), size(original_image, 1));
fprintf('Cropping to region: [x1=%d, y1=%d] to [x2=%d, y2=%d]\n', cropBox);


try
  cropped_image = cropImage(original_image, cropBox);
  fprintf('Successfully cropped image.\n');
  fprintf('New Cropped Image Size: %d x %d\n', size(cropped_image, 2), size(cropped_image, 1));
catch ME
  error('An error occurred during cropping: %s', ME.message);
end


figure('Name', 'Image Cropping Demonstration', 'NumberTitle', 'off');


subplot(1, 2, 1);
imshow(original_image);
title('Original Image with Crop Box');
hold on; % Allow plotting on top of the image
rectangle('Position', [topLeft_x, topLeft_y, bottomRight_x - topLeft_x, bottomRight_y - topLeft_y], ...
          'EdgeColor', 'r', 'LineWidth', 2);
hold off;


subplot(1, 2, 2);
imshow(cropped_image);
title('Cropped Result');

    