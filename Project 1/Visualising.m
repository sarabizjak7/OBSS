%%% VISUALISING STAGES


f = load('Data/209m.mat');
%x = (f.val(1, :) + f.val(2, :)) / 2;
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
  
hpf = HPF(x, M);
lpf = LPF(hpf, I);

%title('First stage')

figure();
sig = x(1 : length(x) / 200);
plot(sig);
hold on;

sig = hpf(1 : length(x) / 200);
plot(sig);
hold on;

sig = lpf(1 : length(x) / 200);
plot(sig);
hold off

legend('Unfiltered', 'Filter 1 - HPF', 'Filter 2 - LPF')

  
  