% Brett Esworthy
% CMPEN 455
% MATLAB Project 3
% Performs the wavelet decomposition using Daubechies order four wavelets.
% Displays the first and second level decomposition and reconstructs the
% image three different times: setting the lowest level's approximation
% coefficient to zero, setting the lowest level's horizontal approximation
% coefficient to zero and setting the lowest level's vertical approximation
% coefficient to zero.
function [one two three]=wavelets(f)
%taking the odd rows only, leaving the even rows behind (or deleting)
f = f(1:2:end, 1:2:end);
%figure, imshow(f, []);
[M, N] = size(f);

%padding the image using zeros and scaling appropriately
Pad = zeros(512, 'uint8');
Pad(512/2+(1:M)-floor(M/2), 512/2+(1:N)-floor(N/2)) = f;
%figure, imshow(Pad, []);


%first level wavelet decomposition and coefficients
[CA1,CH1,CV1,CD1] = dwt2(Pad, 'db4');
%converting each coefficient to uint8 from the default double
CA1 = uint8(CA1);
CH1 = uint8(CH1);
CV1 = uint8(CV1);
CD1 = uint8(CD1);

%displaying the first level decomposition
decompoutput = [CA1 CH1;...
                CV1 CD1];
figure, imshow(decompoutput, []);
title('First level decomposition');

%second level wavelet decomposition and coefficients
[CA2,CH2,CV2,CD2] = dwt2(CA1, 'db4');
%converting each coefficient to uint8 from the default double
CA2 = uint8(CA2);
CH2 = uint8(CH2);
CV2 = uint8(CV2);
CD2 = uint8(CD2);

%displaying the second level decomposition
decompoutput = CA2;
decompoutput = [decompoutput CH2;...
                CV2 CD2];
figure, imshow(decompoutput, []);
title('Second level decomposition');

%producing the tiled image for comparision
%%%%%%%%%%%%%%%%%Arranging the tile image%%%%%%%%%%%%%%%%%%%%
[m1, n1] = size(CH1);
[m2, n2] = size(CV1);
[m3, n3] = size(CD1);
            
%padding the images slightly just to make it fit on a tiled image
PadCH1 = zeros(266, 'uint8');
PadCH1(266/2+(1:m1)-floor(m1/2), 266/2+(1:n1)-floor(n1/2)) = CH1;
PadCV1 = zeros(266, 'uint8');
PadCV1(266/2+(1:m2)-floor(m2/2), 266/2+(1:n2)-floor(n2/2)) = CV1;
PadCD1 = zeros(266, 'uint8');
PadCD1(266/2+(1:m3)-floor(m3/2), 266/2+(1:n3)-floor(n3/2)) = CD1;

decompoutput = [decompoutput PadCH1;...
                PadCV1 PadCD1];

figure, imshow(decompoutput, []);
title('First and second level decompositions');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%gathering the sizes of the two levels of decomposition to reconstruct
[CA2X, CA2Y] = size(CA2);

sizeONE = size(CA1);
sizeTWO = size(Pad);

%setting approximation coefficients to zero
CA2zero = zeros(CA2X, CA2Y, 'uint8');

First_level2 = idwt2(CA2zero, CH2, CV2, CD2, 'db4', sizeONE);
First_level2 = uint8(First_level2);
First_level1 = idwt2(First_level2, CH1, CV1, CD1, 'db4', sizeTWO);
First_level1 = uint8(First_level1);
%figure, imshow(First_level1, []);

%setting horizontal detail coefficients to zero
CH2zero = zeros(CA2X, CA2Y, 'uint8');

Second_level2 = idwt2(CA2, CH2zero, CV2, CD2, 'db4', sizeONE);
Second_level2 = uint8(Second_level2);
Second_level1 = idwt2(Second_level2, CH1, CV1, CD1, 'db4', sizeTWO);
Second_level1 = uint8(Second_level1);
%figure, imshow(Second_level1, []);

%setting vertical detail coefficients to zero
CV2zero = zeros(CA2X, CA2Y, 'uint8');

Third_level2 = idwt2(CA2, CH2, CV2zero, CD2, 'db4', sizeONE);
Third_level2 = uint8(Third_level2);
Third_level1 = idwt2(Third_level2, CH1, CV1, CD1, 'db4', sizeTWO);
Third_level1 = uint8(Third_level1);
%figure, imshow(Third_level1, []);

%return all three
one = First_level1;
two = Second_level1;
three = Third_level1;

end
