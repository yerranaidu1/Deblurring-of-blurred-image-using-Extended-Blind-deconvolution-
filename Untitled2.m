I = im2double((imread('download.jpg')));
len=20;


theta=25;

psf = fspecial('motion',len,theta);
blurred = imfilter(I,psf,'conv','circular');
figure,imshow(blurred);
title('blurred image');
recovered=deconvblind(blurred,psf,12);
figure,imshow(recovered);
title('deconvoblind');

X= deconvreg(blurred,psf,2);
figure,imshow(X);
title('deconvreg');
J = deconvlucy(blurred,psf,100);
figure,imshow(J);
title('deconvlucy');
r = deconvwnr(blurred,psf,0);
figure,imshow(r);
title('dewnr');