% Brett Esworthy
% CMPEN 455
% MATLAB Project 3
% intensityenhance(f) function
% Takes an image and converts it into HSI and performs a histogram
% equalization only over the intensity and concatenates the HS and new I to
% the final image.
function g=intensityenhance(f)
%converting the image to HSI
theimage = rgb2hsv(f);

%setting the HSI channels to variables
Hue = theimage(:, :, 1);
Saturation = theimage(:, :, 2);
Intensity = theimage(:, :, 3);

%Test display of the hue, saturation and intensity
%figure, imshow(Hue, []);
%figure, imshow(Saturation, []);
%figure, imshow(Intensity, []);

%histogram equalization of the intensity
Ieq = histeq(Intensity);

%concatenating the unchanged hue, unchanged saturation and 
%histogram equalized intensity
equalized = cat(3, Hue, Saturation, Ieq);

%convert back to RGB
final = hsv2rgb(equalized);

g = final;

end
