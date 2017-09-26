% Read the image
imageFile = 'image.jpg';
image = imread(imageFile);

imshow(image);
pause;

% Select the green channel
% Note: There is no need to convert the image to gray as it is almost gray already
image = image(:, :, 2);

imshow(image);
pause;

% Convert to double: required if you use Octave
im2double(image);

imshow(image);
pause;

% Resize the image to the 1/4th size
image = imresize(image, 0.25);

imshow(image);
pause;

% Some noise smoothing
image = imsmooth(image, 'Gaussian', 1.00);



% Create an accumulator to store maximum filter response
accum = zeros(size(image));

% Create kernels of different widths
for w = 0 : 4
  % Create the current kernel
  kernel = double([-1; zeros(w, 1); 2; zeros(w, 1); -1]);
  
  % Calculate absolute response
  response = abs(conv2(image, kernel,  'same'));

  % Store the maximum filter response in the accumulator
  accum = max(accum, response);
end

imshow(image);
pause;

% Smoothen the result by median filtering
accum = medfilt2(accum, [17, 17]);

% Thresholding can be improved later, now use a fixed one
binary = accum > 22;

% Median filter again for noise and shape smoothing
binary = medfilt2(binary, [17, 17]);

imshow(image);
pause;


% Apply morphological operations to remove thin regions
binary = imerode(binary, ones(17));
binary = imdilate(binary, ones(13));

imshow(image);
pause;