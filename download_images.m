% 7
%


% download_images.m - Downloads images from URLs using urlwrite.
%
% This script iterates through a predefined list of image URLs and attempts to
% download and display each one.
%
% PREREQUISITE: This script requires the 'urlwrite' function from the 'io'
% package. If you get an error that 'urlwrite' is undefined, run these
% commands in the Octave console:
%   >> pkg install -forge io
%   >> pkg load io
%
% It includes robust error handling for network issues, invalid URLs, and
% non-image content.


clear; clc; close all;
pkg load io;



if ~exist('urlwrite', 'file')
  error(['The function "urlwrite" was not found. It is part of the "io" package.\n' ...
         'Please run the following commands first:\n' ...
         '>> pkg install -forge io\n' ...
         '>> pkg load io']);
end


imageUrls = {
    % A valid JPEG image
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/%E9%87%91%E6%B2%99%E9%95%87%28%E6%B2%99%E7%BE%8E%29_-_Jinsha_Township_-_2014.05_-_panoramio.jpg/960px-%E9%87%91%E6%B2%99%E9%95%87%28%E6%B2%99%E7%BE%8E%29_-_Jinsha_Township_-_2014.05_-_panoramio.jpg',

    % A valid PNG image (with transparency)
    'https://www.octave.org/img/octave-logo.png',

    % A valid GIF image
    'https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif',

    % An invalid URL that will result in a 404 error
    'https://example.com/this-image-does-not-exist.png',

    % A valid URL that points to a non-image (HTML page)
    'https://www.gnu.org/home.html'
};


downloadDir = 'downloaded_images';


if ~exist(downloadDir, 'dir')
    fprintf('Creating directory: %s\n', downloadDir);
    mkdir(downloadDir);
end
fprintf('Files will be saved in ''%s'' directory.\n\n', downloadDir);



for i = 1:numel(imageUrls)
    currentUrl = imageUrls{i};
    fprintf('--- Processing URL %d of %d: %s ---\n', i, numel(imageUrls), currentUrl);

    try
        
        [~, name, ext] = fileparts(currentUrl);
        if isempty(name) || isempty(ext)
            error('Could not determine a valid filename from the URL.');
        end
        filename = [name, ext];
        savePath = fullfile(downloadDir, filename);

       
        
        fprintf('Downloading to: %s\n', savePath);
        urlwrite(currentUrl, savePath); % <-- This is the corrected line
        fprintf('Download successful.\n');

        
        img = imread(savePath);
        figure('Name', filename, 'NumberTitle', 'off');
        imshow(img);
        title(filename, 'Interpreter', 'none');
        fprintf('Successfully displayed image.\n\n');

    catch ME
        
        fprintf('ISSUE ENCOUNTERED: Could not download or process this URL.\n');
        fprintf('REASON: %s\n\n', ME.message);
        continue;
    end
end

fprintf('--- All URLs processed. ---\n');