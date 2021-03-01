function canny = cannyEdge (image, window_size)
    % Performs canny edge algorithm

    [width, height, d] = size(image);
    sigma = min(size(image)) * 0.005;
    
    %figure; imshow(image, [])
    %title('Original image')
    % --------------------------------- %

    % ---------- Gaussian smoothing ---------- %

    fslice = imgaussfilt(im2double(image), sigma);
    %fslice = imnoise(im2double(image), 'poisson');
    %figure; imshow(fslice, [min(fslice(:)),max(fslice(:))]); 

    % Visualize:
    %figure; imshow(fslice, [min(fslice(:)),max(fslice(:))]); 
    %title('Gaussian smoothing');

    % ---------- Prewitt mask ---------- %

    % 1:
    %kx = [-1, 1]; 
    %ky = [-1; 1]; 
    
    % 2:
    %kx = [-1 0 +1; -1 0 +1; -1 0 +1];
    %ky = [-1 -1 -1; 0 0 0; +1 +1 +1];
    
    %3: 
    kx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
    ky = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
    
    %4 mod:
    %kx = [0 -1 -1; 1 0 -1; 1 1 0];
    %ky = [-1 -1 0; -1 0 1; 0 1 1];
    
    %5 mod:
    %kx = [0 -1 -2; 1 0 -1; 2 1 0];
    %ky = [-2 -1 0; -1 0 1; 0 1 2];

    % ---------- Gradient ---------- %

    gx = conv2(fslice, kx, 'same');
    gy = conv2(fslice, ky, 'same');

    % Visualize both gradients: 
    %figure; imshow(gx,[]); title('gx : horizontal gradient');
    %figure; imshow(gy,[]); title('gy : vertical gradient');

    % ---------- Magnitude and angle ---------- %

    mag = sqrt(gx.^2 + gy.^2);
    ang = atan2(gy, gx); 
    
    % Visualize: 
    %figure; imshow(mag, [min(mag(:)),max(mag(:))]); title('Magnitude');
    %figure; imshow(ang, [min(ang(:)),max(ang(:))]); title('Angle');

    % ---------- Edge thinning ---------- %

    ang = round((round((ang + pi).* 4./ pi).* pi./ 4 - pi).* 10)./ 10;
    image_thinned = zeros(size(image));

    %th_low = max(max(mag)) * 0.17;
    %th_high = max(max(mag)) * (0.17 / 2); 

    th_low = max(max(mag)) * 0.2;
    th_high = max(max(mag)) * 0.1;
    
    % gremo cez vse piksle

    %window:
    d = 4;
    
    for n = 2 : width - 1
        for m = 2 : height - 1
            % ce nima najvecje vrednosti v okolici, mu vrednost nastavimo na 0
            if mag(n, m) < th_low
                image_thinned(n, m) = 0;
            % sicer nastavimo na 1 
            else
                ang_input = ang(n - 1 : n + 1, m - 1 : m + 1);
                mag_input = mag(n - 1 : n + 1, m - 1 : m + 1);
                pixel = edgeThinner(ang_input, mag_input);
                if pixel > th_high
                    image_thinned(n, m) = 1;
                elseif pixel < th_low 
                    image_thinned(n, m) = 0;
                    
                % 8-connectivity, determine window size above, d!!!!!!
                elseif (image_thinned(n+d,m)>th_high || image_thinned(n-d,m)>th_high || image_thinned(n,m+d)>th_high || image_thinned(n,m-d)>th_high || image_thinned(n-d, m-d)>th_high || image_thinned(n-d, m+d)>th_high || image_thinned(n+d, m+d)>th_high || image_thinned(n+d, m-d)>th_high)
                    image_thinned(n, m) = 1;
                end
            end
        end
    end


    %figure; imshow(image_thinned, []);
    %title('Canny edge detected');
    
    % Se posebej za connectivity... ni treba, je dovolj tuki v tej skripti
    %window_size = 4;
    %image_connected = edgeConnectivity(image_thinned, window_size);
    canny = image_thinned;
    
    %figure; imshow(image_connected, []);
    %title('Edge connectivity');
