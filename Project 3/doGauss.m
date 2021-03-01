  I=imread('0001.png');
  sigma=min(size(I))*0.005; % sigma=0.5% of min. image size dimension in pixels
  % calculate the kernel coefficients and visualize the kernel with a 3d mesh
  k1 = calcGauss(sigma);
  %mesh(k1); 

  % filter the image using the imfilter function and the kernel
  G = imfilter(I, k1);
  % instead it is possible to use 2d convolution
  % G = conv2(im2double(I), k1, 'same');
  figure;
  subplot(1,2,1); imshow(I); % original
  subplot(1,2,2); imshow(G); % filtered
  
  % use the fspecial function to calculate the Gaussian kernel 
  % coefficients, then filter the image and show the results
  %k2 = fspecial('gaussian', 17, sigma);
  %G = imfilter(I, k2);

  %figure;
  %subplot(1,2,1); imshow(I); % original
  %subplot(1,2,2); imshow(G); % filtered