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

  y_1 = HPF(x, M);
  
  %figure();
  %sig = hpf(1 : length(x) / 100);
  %plot(sig);
  %hold on;
  
  % 2nd step:
  % LPF : nonlinear low-pass filter stage
  
  y = LPF(y_1, I);
  
  %figure();
  %sig = y(1 : y_len / 100);
  %plot(sig);
  %hold off;
  
  % 3rd step:
  % DM : decision-making stage
  
  th = max(y(1 : step));
  y_len = length(y);
  
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
