clear all;
slice = imread('0001.png');

% ALTERNATIVE 1: using calcLoG to calculate the Laplacian of Gaussian kernel
% using calcLoG to compute kernel with integer coefficients
% and kernel size as a function of sigma (see calcLoG)
kernel1 = calcLoG(1); size(kernel1) % also print kernel size
kernel2 = calcLoG(1.5); size(kernel2)
kernel3 = calcLoG(2); size(kernel3)
kernel4 = calcLoG(5); size(kernel4)
% ALTERNATIVE 2: with fspecial LoG kernel, negative and mean centered (same kernel size as CalcLoG)
% kernel1 = -fspecial('log', 7, 1.0);
% kernel1 = kernel1 - mean(kernel1(:));
% kernel2 = -fspecial('log', 9, 1.5);
% kernel2 = kernel2 - mean(kernel2(:));
% kernel3 = -fspecial('log', 13, 2.0);
% kernel3 = kernel3 - mean(kernel3(:));
% kernel4 = -fspecial('log', 29, 5.0);
% kernel4 = kernel4 - mean(kernel4(:));
% % ALTERNATIVE 3: two-step approach, Gaussian kernel + Laplacian kernel
% k1 = calcGauss(5.0); 
% k2 = [-1 -1 -1; -1 8 -1; -1 -1 -1];
% f1 = conv2(double(slice), k1, 'same'); % 1st step
% f2 = conv2(f1, k2, 'same'); % 2nd step
% figure; imshow(f2, [min(f2(:)),max(f2(:))]); % show normalized to range [0..255]

% LoG of image using different kernels (i.e. with different sigma values)
fslice1 = conv2(double(slice), kernel1, 'same'); % LoG image
fslice2 = conv2(double(slice), kernel2, 'same');
fslice3 = conv2(double(slice), kernel3, 'same');
fslice4 = conv2(double(slice), kernel4, 'same');
figure;
subplot(2,4,1); imshow(fslice1, [min(fslice1(:)),max(fslice1(:))]); title('\sigma=1.0');
subplot(2,4,2); imshow(fslice2, [min(fslice2(:)),max(fslice2(:))]); title('\sigma=1.5');
subplot(2,4,3); imshow(fslice3, [min(fslice3(:)),max(fslice3(:))]); title('\sigma=2.0');
subplot(2,4,4); imshow(fslice4, [min(fslice4(:)),max(fslice4(:))]); title('\sigma=5.0');

% simple thresholding (show black pixel if LoG value <=0, otherwise show white pixel)
% (note: is is better to perform edge thinning/zero-corssing detection prior to 
% thresholding and compare opposing values with a defined fixed or adaptive threshold)
fth1 = im2bw(fslice1, 0);
fth2 = im2bw(fslice2, 0); 
fth3 = im2bw(fslice3, 0); 
fth4 = im2bw(fslice4, 0); 
subplot(2,4,5); imshow(fth1); title('\sigma=1.0');
subplot(2,4,6); imshow(fth2); title('\sigma=1.5');
subplot(2,4,7); imshow(fth3); title('\sigma=2.0');
subplot(2,4,8); imshow(fth4); title('\sigma=5.0');

% N1: Zero-crossing detection