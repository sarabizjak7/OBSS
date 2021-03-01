% --------------------------------- %
% ---------- MAIN SCRIPT ---------- %
% --------------------------------- %

clear all;
% Select the image:

image = imread('0001.png');

% Set parameters:

% gledamo 8 sosedov
window_size = 4;

% Canny edge detector:

Canny_img = cannyEdge(image, window_size);

%Canny_img = edge(image, 'Canny');
figure; imshow(Canny_img, []);
axis('on', 'image');

%imwrite(Canny_img, "0090_canny.png");