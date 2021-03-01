slice = im2double(imread('shape.png'));
fslice = conv2(slice, calcGauss(5), 'same');
mag = zeros(size(fslice));
ang = zeros(size(fslice));

for x=2:size(fslice,1)
    for y=2:size(fslice,2)
        gx = fslice(x,y)-fslice(x-1,y);
        gy = fslice(x,y)-fslice(x,y-1);
        mag(x,y) = sqrt(gx^2 + gy^2);
        ang(x,y) = atan2(gy, gx); % 4-quadrant atan function
    end
end