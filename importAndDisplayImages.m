function importAndDisplayImages(directoryPath)
  % importAndDisplayImages - Imports and displays multiple images from a directory.
  %
  % This function scans a specified directory for common image formats (PNG,
  % JPG, BMP, etc.), imports them, and displays each one in a new figure window
  % using a rotating selection of colormaps.
  %
  % It includes error handling for files that cannot be read as images.
  %
  % SYNTAX:
  %   importAndDisplayImages(directoryPath)
  %
  % INPUTS:
  %   directoryPath - A string containing the path to the directory with images.
  %                   
  %



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