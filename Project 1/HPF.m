% LINEAR HIGH-PASS FILTERING STAGE (HPF)

% M-point moving average filter (odd values -- 5 or 7)
% an ideal delayed system with a group delay of (M + 1) / 2 samples

function y = HPF(x, M)
% input: - x: input data, format [x1, x2, x3, ... , xn]
%        - M: filter length (odd value -- 5 or 7)
% outpu: - y: output data, format [y1, y2, y3, ..., yn]

%x_len = length(x);

x_len = length(x);
y = zeros(1, x_len);
  
for n = M : x_len
    y1 = 0;
    % sum
    for m = 0 : (M - 1)      
        y1 = y1 + x(n - m);
    end
    y1 = y1 / M;
    
    y2 = x(n - ((M + 1) / 2));
    y(n) = y2- y1;
end
