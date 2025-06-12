% 3
%
% grayscale_methods.m - Implements and compares different grayscale conversion methods.
%
% This script loads a color image and converts it to grayscale using three
% distinct algorithms:
%   1. Average Method: A simple average of the R, G, and B channels.
%   2. Luminosity Method: A weighted average that accounts for human perception
%      of brightness. This is the standard method used in functions like rgb2gray.
%   3. Desaturation Method: Calculates the lightness component by averaging the
%      brightest and dimmest color channels for each pixel.
%
% The script then displays the original and all three grayscale versions
% side-by-side for a direct visual comparison.


clear; clc; close all;

pkg load image; % Load the image package

imagePath = './test-images/peppers.jpeg';


if ~exist(imagePath, 'file')
  error('Image file not found at: %s\nPlease check the path.', imagePath);
end

original_image = imread(imagePath);



img_double = im2double(original_image);

% Separate the Red, Green, and Blue channels
R = img_double(:, :, 1);
G = img_double(:, :, 2);
B = img_double(:, :, 3);

fprintf('--- Implementing Grayscale Conversions ---\n');

% Method 1: The Average Method ---
% Formula: Gray = (R + G + B) / 3

fprintf('1. Applying Average Method...\n');
gray_avg = (R + G + B) / 3;

%  Method 2: The Luminosity (Weighted Average) Method ---

% Formula: Gray = 0.299*R + 0.587*G + 0.114*B
% This formula accounts for the fact that the human eye is most sensitive
% to green light and least sensitive to blue light. This is the standard
% used by NTSC and is implemented in Octave `rgb2gray` function.

fprintf('2. Applying Luminosity Method...\n');
gray_lum = 0.299 * R + 0.587 * G + 0.114 * B;

% Method 3: The Desaturation Method ---
% Formula: Gray = (max(R,G,B) + min(R,G,B)) / 2
% This method finds the lightness component of the HSL color model. It
% takes the average of the most and least prominent colors in a pixel.

fprintf('3. Applying Desaturation Method...\n');
max_val = max(img_double, [], 3);
min_val = min(img_double, [], 3); 
gray_desat = (max_val + min_val) / 2;

fprintf('Conversions complete. Displaying results.\n');

% Comparison ---
figure('Name', 'Grayscale Conversion Comparison', 'NumberTitle', 'off');


% Original Image
subplot(2, 2, 1);
imshow(original_image);
title('Original Color Image');

% Average Method
subplot(2, 2, 2);
imshow(gray_avg);
title('Grayscale (Average Method)');

% Luminosity Method
subplot(2, 2, 3);
imshow(gray_lum);
title('Grayscale (Luminosity Method)');

% Desaturation Method
subplot(2, 2, 4);
imshow(gray_desat);
title('Grayscale (Desaturation Method)');