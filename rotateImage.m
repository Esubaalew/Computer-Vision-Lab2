% 6
%

function rotatedImage = rotateImage(inputImage, angleDegrees)
  
  % rotateImage - Rotates an image by a specified angle, adjusting canvas size.
  %
  % This function rotates an image by any angle around its center point.
  % It automatically expands the output images canvas size to ensure that
  % the entire original image is visible after rotation (no cropping).
  %
  % SYNTAX:
  %   rotatedImage = rotateImage(inputImage, angleDegrees)
  %
  % INPUTS:
  %   inputImage   - The source image matrix (grayscale or RGB).
  %   angleDegrees - The angle of counter-clockwise rotation in degrees.
  %                  Negative values produce clockwise rotation.
  %
  % OUTPUTS:
  %   rotatedImage - The new, rotated image matrix. Its dimensions will be
  %                  larger than the input image to accommodate the rotation.
  %
  % DETAILS:
  % This function uses 'bicubic' interpolation for high-quality results
  % and the 'loose' bounding box option to prevent the corners of the
  % rotated image from being cropped.
  %
  % EXAMPLE:
  %   original = imread('portrait.jpg');
  %   % Rotate the image by 30 degrees counter-clockwise
  %   rotated_30 = rotateImage(original, 30);
  %   % Rotate the image by 15 degrees clockwise
  %   rotated_neg_15 = rotateImage(original, -15);
  %   imshow(rotated_30);
  %
  % See also: imrotate, imread, imshow


  if ~isnumeric(inputImage) || ~any(ndims(inputImage) == [2, 3])
      error('Input must be a 2D (grayscale) or 3D (color) image matrix.');
  end
  if ~isnumeric(angleDegrees) || ~isscalar(angleDegrees)
      error('Rotation angle must be a single numeric value.');
  end


  % The key is to use the 'imrotate' function with specific options:
  %   'bicubic': A high-quality interpolation method to calculate the new
  %              pixel values. It produces smoother results than 'nearest'
  %              or 'bilinear'.
  %   'loose':   This  option tells imrotate to make the output image
  %              large enough to contain the entire rotated source image.
  %              The alternative, 'crop', would make the output the same
  %              size as the input, cutting off the corners.

  rotatedImage = imrotate(inputImage, angleDegrees, 'bicubic', 'loose');

end