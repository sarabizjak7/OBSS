function [ krnel ] = calcGauss( sigma )
  kSize = ceil(sigma*6);
  if rem(kSize,2)==0 kSize=kSize+1; end
  hSize=floor(kSize/2);
  [X,Y]=meshgrid(-hSize:hSize,-hSize:hSize);
  krnel = exp(-(X.^2+Y.^2)/(2*sigma^2))/(2*pi*sigma^2);
  %normalize the kernel so that the sum of all coefficients equals 1
  krnel = krnel/sum(krnel(:));
  %uncomment the following line to calculate integer coefficients
  %krnel = round(krnel*(1/krnel(1,1))); 
end