% 4
%
function croppedImage = cropImage(inputImage, cropRegion)

  % cropImage - Crops an image to a specified rectangular region.
  %
  % This function extracts a sub-image from a larger image based on the
  % coordinates of a bounding box. It handles both grayscale and color images.
  %
  % SYNTAX:
  %   croppedImage = cropImage(inputImage, cropRegion)
  %
  % INPUTS:
  %   inputImage - The source image matrix (can be MxN for grayscale or
  %                MxNx3 for RGB color).
  %
  %   cropRegion - A 1x4 vector defining the crop area in the format:
  %                [x1, y1, x2, y2]
  %                where:
  %                  (x1, y1) are the coordinates of the TOP-LEFT corner.
  %                  (x2, y2) are the coordinates of the BOTTOM-RIGHT corner.
  %                'x' corresponds to the column index (horizontal).
  %                'y' corresponds to the row index (vertical).
  %
  % OUTPUTS:
  %   croppedImage - The new, smaller image matrix containing only the pixels
  %                  from the specified region.
  %
  % EXAMPLE:
  %   % Load an image
  %   original = imread('peppers.png');
  %   % Define a crop region [topLeftX, topLeftY, bottomRightX, bottomRightY]
  %   region = [100, 50, 300, 250];
  %   % Crop the image
  %   my_crop = cropImage(original, region);
  %   % Display the result
  %   imshow(my_crop);
  %
  % See also: imread, imshow, size


  if numel(cropRegion) ~= 4
    error('cropRegion must be a 4-element vector: [x1, y1, x2, y2]');
  end


  [imgHeight, imgWidth, ~] = size(inputImage);


  x1 = round(cropRegion(1));
  y1 = round(cropRegion(2));
  x2 = round(cropRegion(3));
  y2 = round(cropRegion(4));


  if x1 >= x2 || y1 >= y2
    error('Invalid crop region: x1 must be < x2 and y1 must be < y2.');
  end


  x1 = max(1, x1);
  y1 = max(1, y1);
  x2 = min(imgWidth, x2);
  y2 = min(imgHeight, y2);


  % The core of cropping is selecting a sub-matrix.
  % The format is Image(rows, columns, channels).
  % The ':' for the third dimension means 'take all color channels' (e.g., R, G, and B).
  % This works for both grayscale (1 channel) and color (3 channels) images.
  croppedImage = inputImage(y1:y2, x1:x2, :);

end