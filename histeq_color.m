% Brett Esworthy
% CMPEN 455
% MATLAB Project 1
% histeq_color(f) function
% Takes an image and applies a histogram equalization amongst the RGB
% channels seperately and concatenates them into a final image.
function g=histeq_color(f)
%setting the RGB channels to variables from the image
R = f(:, :, 1);
G = f(:, :, 2);
B = f(:, :, 3);

%Test display showing the three seperate color channels
%figure, imshow(R, []);
%figure, imshow(G, []);
%figure, imshow(B, []);

%histogram equalizing each channel RGB
Req = histeq(R);
Geq = histeq(G);
Beq = histeq(B);

%concatenating the histogram equalized channels to form one image
equalized = cat(3, Req, Geq, Beq);

% Converting the image to 8 bit unsigned integar
equalized = im2uint8(equalized);

g = equalized;
end
