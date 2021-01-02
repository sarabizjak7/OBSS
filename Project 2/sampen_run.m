% SampEn.m run

function e = sampen_run(record)

    % Load file
    file_name = sprintf('Data/%sm.mat', record);
    f = load(file_name);

    sig3 = f.val(9, :);
    
    % Param: 
    m = 3;
    r = 0.15;
    start = 0.3; %Hz
    stop = 4; %Hz
    Fs = 20;
    n = 4; % order
    filter_type = 'bandpass';
    
    % Filter:
    sig3 = butter_filter(sig3, start, stop, n, Fs, filter_type);
    
    % Sample entropy: 
    e = SampEn(m, r * std(sig3), sig3, 1);
