% NONLINEAR LOW-PASS FILTERING STAGE (LPF)

% constructed by a cascade of a simple point-by-point squaring operation
% and a moving window integration or su,mation system.

% 30 samples wide

function y = LPF(x, I)
% input: - x: input data, output of HPF
%        - summation_interval: 30
% outpu: - y: output data, format [y1, y2, y3, ..., yn]

x_len = length(x);

x_squared = zeros(1, x_len);
y = zeros(1, x_len);

for i = 1 : x_len
    x_squared(i) = x(i) ^ 2;
end

for n = I : x_len 
    % sum
    for m = 0 : I - 1
       y(n) = y(n) + x_squared(n - m); 
    end
end