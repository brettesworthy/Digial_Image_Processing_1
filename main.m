% Brett Esworthy
% CMPEN 455
% MATLAB Project 3
% main.m to test the functions

%%%%%%%%%%%%PROBLEM ONE%%%%%%%%%%%%%%%%%%%
% Testing the color image enhancement by histogram processing
f = imread('bottom_left_stream.tif');
A = histeq_color(f);
figure, imshow(A, []);
title('Result after histogram equalizing each color component');

% Increasing the intensity only
B = intensityenhance(f);
figure, imshow(B, []);
title('Result after histogram equalizing the intensity component only');

%%%%%%%%%%%%PROBLEM TWO%%%%%%%%%%%%%%%%%%%
g = imread('characters_test_pattern.tif');
[one, two, three] = wavelets(g);

figure, imshow(one, []);
title('Reconstruction and setting second level approximation coefficient to zero');
figure, imshow(two, []);
title('Reconstruction and setting second level horizontal coefficient to zero');
figure, imshow(three, []);
title('Reconstruction and setting second level vertical coefficient to zero');
