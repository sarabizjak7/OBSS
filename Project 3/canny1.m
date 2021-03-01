% Coding for CANNY Edge Detection 
%Written by Krishna Prasad Satamraju, Assisttant Professor, Dept. of ECE,
%/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\
%========================================================================%
close all;
clear all;
I = imread('0090.png');
[w, h, d] = size(I)
ID = im2double(I);
%imshow(I);
%ex = edge(ID,'canny');
[h, w] = size(ID);
filter = [0.0174 0.348 0.04348 0.0348 0.0174; 0.0348 0.0782 0.1043 0.0782 0.0348; 0.0435 0.1043 0.1304 0.1043 0.0435;0.0348 0.0782 0.1043 0.0782 0.0348; 0.0174 0.348 0.04348 0.0348 0.0174];
Mx = [-1 0 1; -2 0 2; -1 0 1];
My = [-1 -2 -1; 0 0 0; 1 2 1];
for v = 2 : h
    for u = 2 : w
        sum = 0;
        for i = -2 : 2
            for j = -2 : 2
                sum = sum + (ID(u, v) * filter(i+3, j+3));
            end
        end
        IDx(u,v) = sum;
    end
end
%APPLYING SOBEL MASK ON X-DIRECTION
for v = 2:w-1
         for u = 2:h-1
             
             sum1 = 0;
            
              for i=-1:1
                for j=-1:1
                    sum1 = sum1 + IDx(u + i, v + j)* Mx(i + 2,j + 2);
                end
            end
            IDxx(u,v) = sum1;
         end;
end
%APPLYING SOBEL MASK ON Y-DIRECTION
for v = 2:w-1
         for u = 2:h-1
             
             sum2 = 0;
             
              for i=-1:1
                for j=-1:1
                 sum2 = sum2 + IDx(u + i, v + j)* My(i + 2,j + 2);
                end
            end
            IDyy(u,v) = sum2;
         end;
end
for v = 2:w-1
   for u = 2:h-1
        mod(u,v) = abs(IDxx(u,v)) + abs(IDyy(u,v));
   end
end
supimg(u,v) = 0;
for v = 2 : w-2
    for u = 2 : h-2
        theta(u,v) = abs(atand(IDyy(u,v)/IDxx(u,v))); 
        ntheta(u, v) = 0;
        if ((theta(u,v) >= 0) && (theta(u,v) <= 22.5) || (theta(u,v) >= 157.5) && (theta(u,v) <= 180))
            ntheta(u,v) = 0;
        end;
        
        if ((theta(u,v) >= 22.5) && (theta(u,v) <= 67.5))
            ntheta(u,v) = 45;
        end;
        
        if ((theta(u,v) >= 67.5) && (theta(u,v) <= 112.5))
            ntheta(u,v) = 90;
        end;
        
        if ((theta(u,v) >= 112.5) && (theta(u,v) <= 180))
            ntheta(u,v) = 135;
        end;
                       
        %     N O N - M A X I M U M   S U P P R E S S I O N
        if (ntheta(u,v) == 0)
                if (mod(u, v) < mod(u-1, v) || mod(u, v) < mod(u+1, v))
                    supimg(u,v) = 0;
                else supimg(u,v)= mod(u,v);
                end; 
            end;
            if (ntheta(u,v) == 45)
                if (mod(u, v) < mod(u+1, v-1) || mod(u, v) < mod(u-1, v+1))
                    supimg(u,v) = 0;
                else supimg(u,v)= mod(u,v);
                end;
            end;
                
            
            if (ntheta(u,v) == 90)
                if (mod(u, v) < mod(u, v-1) || mod(u, v) < mod(u, v+1))
                    supimg(u,v) = 0;
                else supimg(u,v)= mod(u,v);
                end;
            end;
               
            if (ntheta(u,v) == 135)
                if (mod(u, v) < mod(u-1, v-1) || mod(u, v) < mod(u+1, v+1))
                    supimg(u,v) = 0;
                else supimg(u,v) = mod(u,v);%Supimg -- Image obtained after Non-mSupression
                end ;
            end;
                
            %    E N D  O F  N O N - M A X I M U M   S U P P R E S S I O N
    end
end
%T H R E S H O L D I N G
th = 8.0;   %High Threshhold
%th = max(supimg);
tl = th/6; %Low Threshhold
gnh(u,v) = 0;
gnl(u,v) = 0;
for v = 2 : w-1
    for u = 2 : h-1
        if(supimg(u,v) >= th)
            gnh(u,v) = supimg(u,v);
        end
        if(supimg(u,v) >= tl)
            gnl(u,v) = supimg(u,v);
        end
     
    end
    
end
% E N D  OF T H R E S H O L D I N G
resimg = gnl - gnh;   %Edge of the Image 
   
%subplot (1, 2, 1),imshow(ID);axis image; title('Original Image');
%subplot (1, 2, 2),imshow(resimg);axis image; title('Canny Edge Image');
subplot (2, 3, 1),imshow(ID);axis image; title('Original Image');
subplot (2, 3, 2),imshow(IDx);axis image; title('Filtered Image');
subplot (2, 3, 3),imshow(IDxx);axis image; title('X- Direction Image');
subplot (2, 3, 4),imshow(IDyy);axis image; title('Y- Direction Image');
subplot (2, 3, 5),imshow(supimg);axis image; title('Non-Max Suppress');
subplot (2, 3, 6),imshow(resimg);axis image; title('Canny Edge');

                