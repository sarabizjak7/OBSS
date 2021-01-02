function entropy_sig3 = entropy(record)
%%%
% Calculates entropy for signal 2 and signal 3 of a record file
%%%

%%%%%%
% PE : 'tpehg1203m.mat'
%%%%%%
% PL : 'tpehg1007m.mat'
%%%%%%
% TE : 'tpehg1118m.mat'
%%%%%%
% TL : 'tpehg1027m.mat'
% TL : 'tpehg1022m.mat'
%%%%%%

% Load file
file_name = sprintf('Data/%sm.mat', record);
f = load(file_name);

% Parameters
m = 3;
r = 0.15;
start = 0.3; %Hz
stop = 4; %Hz

% Butter: 
Fs = 20;
n = 4; % order
filter_type = 'bandpass';

% Entropy for signal 3 : x
sig3 = f.val(9, :);
%figure(1);
%plot(sig3(1: length(sig3) / 5));
sig3 = butter_filter(sig3, start, stop, n, Fs, filter_type);
sig3 = sig3(181 * Fs : end - 181 * Fs);
entropy_sig3 = sampleEntropy(sig3, m, r);

%doSpectrogram(sig3, Fs, 256);

% Entropy for signal 2 : y
%sig2 = f.val(5, :);
%figure(2);
%plot(sig2);
%sig2 = butter_filter(sig2, start, stop, n, Fs, filter_type);
%sig2 = sig2(181 * Fs : end - 181 * Fs);
%entropy_y = sampleEntropy(sig2, m, r);

