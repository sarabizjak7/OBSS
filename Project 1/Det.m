% QRS DETECTOR

function PEAKS = QRSdetector(file) 

  f = load(file);
  x = f.val(1, :);
  
  % Setting parameters
  
  % M : moving average window : 5 or 7
  M = 5; 
  % I : summation interval : 30
  I = 10; 
  % alpha : forgetting factor : 0.01 - 0.1
  alpha = 0.05; 
  % gamma : weighting factor : 0.15 - 0.2
  gamma = 0.15;
  % step : step in ms for peak searching
  step = 180; 
  
  %figure();
  %sig = x(1 : length(x) / 100);
  %plot(sig);
  %hold on;
  
  % 1st step:
  % HPF : linear high-pass filter stage
  x_len = length(x);

  % prepare vectors
  y = zeros(1, x_len);
  
  %for n = M : x_len
   % y1   = (1 / M) * sum(x((n - (M - 1)) : n));
   % y2   = x(n - ((M + 1) / 2));
   % y(n) = y2 - y1;
 % end
    
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

  %figure();
  %sig = hpf(1 : length(x) / 100);
  %plot(sig);
  %hold on;
  
  % 2nd step:
  % LPF : nonlinear low-pass filter stage
  
  x_squared = zeros(1, x_len);

  for i = 1 : x_len
    x_squared(i) = y(i) ^ 2;
  end

  y = zeros(1, x_len);
  for n = I : x_len 
    % sum
    for m = 0 : I - 1
       y(n) = y(n) + x_squared(n - m); 
    end
  end

  y_len = length(y);
  
  %figure();
  %sig = y(1 : y_len / 100);
  %plot(sig);
  %hold off;
  
  % 3rd step:
  % DM : decision-making stage
  
  th = max(y(1 : step));
  
  % Iterate with the step
  for i = 1 : step : y_len
      window_end = min(i + step, y_len);
      [PEAK, idx] = max(y(i : window_end));
      if PEAK >= th
          % sign 
          y(idx + i) = - Inf;        
          % update the threshold
          th = alpha * gamma * PEAK + (1 - alpha) * th;
      end
  end
  %y(step:step + step)
  PEAKS = find(y == - Inf);
  
end 
