clc;
clear all;
close all;
xx=1; big=-999;

I=imread('aravind1.tif');
I=rgb2gray(I);
for l=20:15
PSF = fspecial('motion',l,7);
Blurred = I;
UNDERPSF = ones(size(PSF)-4);
[J1, P1] = deconvblind(Blurred,UNDERPSF);
OVERPSF = padarray(UNDERPSF,[4 4],'replicate','both');
[J2, P2] = deconvblind(Blurred,OVERPSF);
INITPSF = padarray(UNDERPSF,[2 2],'replicate','both');
[J3, P3] = deconvblind(Blurred,INITPSF);
WEIGHT = edge(Blurred,'sobel',.08);
se = strel('disk',2);
WEIGHT = 1-double(imdilate(WEIGHT,se));
WEIGHT([1:3 end-(0:2)],:) = 0;
WEIGHT(:,[1:3 end-(0:2)]) = 0;
[J, P] = deconvblind(Blurred,INITPSF,30,[],WEIGHT);
[snr1, snr2] = psnr(I,J);
snr_arr(xx)=snr1;

[val, ind] = max(snr_arr(:));
if ind > big
new_img = J;
big=ind;
l
xx=xx+1;
end
end
figure, imshow(new_img);title('Deblurred Image with highest PSNR value:');