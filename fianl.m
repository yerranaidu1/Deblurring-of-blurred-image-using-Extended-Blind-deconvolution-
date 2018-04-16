y= imread('aravind1.tif');
I=im2double(y);
z=1;

str='dfigure';
[snr1, snr2] = psnr(y,y);  
fprintf('\n The SNR of blurred image value is %0.4f', snr2);

figure
imshow(I)
title('blurredimage');
xx=1; big1=-1;big5=-1;big2=-1;big3=-1;big4=-1;
for l=25.0:-5.3:0.0
    for t=25.0:-5.2:0.0
PSF = fspecial('motion',l,t);
INITPSF = ones(size(PSF));
[J, P] = deconvblind(I,PSF,3);
figure
imshow(J)
title([str ':' num2str(z)])
[snr4, snr3] = psnr(I,J);
snr3_arr(xx)=snr3;
xx=xx+1;
z=z+1;
  end
end

[val1, ind1] = max(snr3_arr(:));
if ind1 > big1
    new_img1 = J;
    big1=ind1;
   
end
 figure
    imshow(J);
    title('blind');
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%wnier
yy=1;
for l=18.0:-6.3:0.0
    for t=15.0:-6.2:0.0
PSF = fspecial('motion',l,t);
INITPSF = ones(size(PSF));
J = deconvwnr(I,INITPSF,0);
figure,imshow(J)
title([str ':' num2str(z)])
[snr6,snr5] = psnr(I,J);
snr5_arr(yy)=snr5;
yy=yy+1;
z=z+1;
  end
end

[val2, ind2] = max(snr5_arr(:));
if ind2 > big2
    new_img2 = J;
    big2=ind2;
    
end
figure
    imshow(J);
    title('wnr');
    


%%%%%%%%%%%%%%%%%%%%%%%reg
zz=1;
for l=18.0:-6.3:0.0
    for t=15.0:-6.2:0.0
PSF = fspecial('motion',l,t);
INITPSF = ones(size(PSF));
[J, P] = deconvreg(I,INITPSF,2); 
figure
imshow(J)
title([str ':' num2str(z)])
[snr8, snr7] = psnr(I,J);
snr7_arr(zz)=snr7;
zz=zz+1;
z=z+1;
  end
end

[val3, ind3] = max(snr7_arr(:));
if ind3 > big3
    new_img3 = J;
    big3=ind3;
    
end
figure
    imshow(J);
    title('reg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%lucy
aa=1;
for l=18.0:-6.3:0.0
    for t=15.0:-6.2:0.0
PSF = fspecial('motion',l,t);
INITPSF = ones(size(PSF));
J = deconvlucy(I,INITPSF,100);
figure
imshow(J)
%title([str ':' num2str(z)])
[snr10, snr9] = psnr(I,J);
snr9_arr(aa)=snr9;
aa=aa+1;
z=z+1;
  end
end

[val4, ind4] = max(snr9_arr(:));
if ind4 > big4
    new_img4 = J;
    big4=ind4;
    
end
figure
    imshow(J);
    title('lucy');
dz=[val1 ,val2 , val3 , val4];
[rrr, sss] = max(dz(:));
if rrr == val1
    new_img5 = new_img1;
    figure, imshow(new_img5);
title(['dfigure:' num2str(ind1),    'snr' [num2str(rrr)]])
elseif rrr==val2
    new_imag5=new_img2;
 figure, imshow(new_img5);
title(['dfigure:' num2str(ind2),    'snr' [num2str(rrr)]])
elseif rrr==val3
    new_img5=new_img3;
    figure, imshow(new_img5);
title(['dfigure:' num2str(ind3),    'snr' [num2str(rrr)]])
else 
    new_img5=new_img4;
    figure, imshow(new_img5);
title(['dfigure:' num2str(ind4),    'snr' [num2str(rrr)]])
end