function importAndDisplayImages(directoryPath)
  % importAndDisplayImages - Imports and displays multiple images from a directory.
  %
  % This function scans a specified directory for common image formats (PNG,
  % JPG, BMP, TIF), imports them, and displays each one in a new figure window.
  % A rotating selection of colormaps is applied to grayscale or converted-to-grayscale images.
  %
  % It includes error handling for files that cannot be read as images or
  % if the specified directory does not exist.
  %
  % SYNTAX:
  %   importAndDisplayImages(directoryPath)
  %
  % INPUTS:
  %   directoryPath - A string containing the path to the directory where
  %                   the image files are located.
  %
  % OUTPUTS:
  %   (None explicitly returned) - This function generates figure windows,
  %   each displaying an image.
  %
  % NOTES:
  %   Colormap Influence on Visual Perception:
  %   Colormaps are crucial for visualizing data, especially in grayscale images
  %   where intensity variations represent data values. The choice of colormap
  %   can significantly affect how features are perceived:
  %     - 'gray': A linear grayscale map, good for representing intensity
  %       without introducing perceptual biases. Differences in lightness
  %       directly correspond to data differences.
  %     - 'jet': A perceptually non-uniform map (rainbow). While colorful, it
  %       can introduce false boundaries or mask subtle details due to abrupt
  %       changes in color and lightness. It's often discouraged for scientific
  %       visualization but can be useful for highlighting specific ranges.
  %     - 'hot': Transitions from black through red, orange, yellow, to white.
  %       Good for emphasizing high-intensity values (hotspots).
  %     - 'cool': Transitions from cyan to magenta. Useful for highlighting
  %       variations in a different part of the intensity spectrum compared to 'hot'.
  %     - 'parula': MATLAB's default colormap (and often Octave's if available).
  %       Designed to be more perceptually uniform than 'jet', meaning changes
  %       in color correspond more closely to changes in data values, making it
  %       better for quantitative interpretation.
  %
  %   RGB images are converted to grayscale before a colormap is applied, as
  %   colormaps are typically used for single-channel (intensity) data.
  %
  % EXAMPLE:
  %   importAndDisplayImages('./test-images');
  %
  % See also: dir, fileparts, imread, figure, imshow, colormap, rgb2gray, colorbar, title



  if ~exist(directoryPath, 'dir')
    error('The specified directory does not exist: %s', directoryPath);
    return;
  end

  
  supportedExtensions = {'.png', '.jpg', '.jpeg', '.bmp', '.tif', '.tiff'};

  
  colormapsToUse = {'gray', 'hot', 'jet', 'cool', 'parula'};

  fprintf('Scanning directory: %s\n', directoryPath);

  
  allFiles = dir(directoryPath);
  imageFiles = {}; % Use a cell array to store names of image files

  for i = 1:length(allFiles)
    [~, ~, ext] = fileparts(allFiles(i).name);
    if ~allFiles(i).isdir && any(strcmpi(ext, supportedExtensions))
      imageFiles{end+1} = allFiles(i).name;
    end
  end

  if isempty(imageFiles)
    warning('No supported image files found in the specified directory.');
    return;
  end

  fprintf('Found %d image(s). Starting import process...\n\n', numel(imageFiles));

 
  for i = 1:numel(imageFiles)
    filename = imageFiles{i};
    fullFilePath = fullfile(directoryPath, filename);

    fprintf('--- Processing file: %s ---\n', filename);

    
    try
      
      img = imread(fullFilePath);
      fprintf('Successfully imported "%s".\n', filename);

      
      
      colormapIndex = mod(i - 1, numel(colormapsToUse)) + 1;
      selectedColormap = colormapsToUse{colormapIndex};

      
      figure('Name', filename);

      % Colormaps only apply to grayscale (2D matrix) or indexed images.
      % Most JPEGs are RGB (3D matrix). We must convert them to grayscale
      % to demonstrate the effect of a colormap.
      if ndims(img) == 3
        fprintf('Image is RGB. Converting to grayscale for colormap display.\n');
        img_display = rgb2gray(img);
      else
        % Image is already grayscale or indexed
        img_display = img;
      end

      
      imshow(img_display);
      colormap(gca, selectedColormap); 
      colorbar; 

      
      title(sprintf('File: %s\nColormap: %s', filename, selectedColormap), 'Interpreter', 'none');
      fprintf('Displayed with "%s" colormap.\n\n', selectedColormap);

    catch ME
      % This block executes if imread() or another command fails
      fprintf('ISSUE: Failed to import or process "%s".\n', filename);
      fprintf('ERROR DETAILS: %s\n\n', ME.message);
      
      continue;
    end
  end
  fprintf('--- All files processed. ---\n');
end