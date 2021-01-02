function filtered = butterFilter(x, start, stop, n, Fs, filter_type)

    Wn = [start stop] / (Fs / 2); % normalize range
    [b, a] = butter(n, Wn, filter_type);
    % [b, a] = butter(n, Wn) 
    % returns the transfer function coefficients of an nth-order 
    % lowpass digital Butterworth filter with normalized cutoff frequency Wn.

    %freqz(b, a);
    
    sig3 = x;
    x = x';
    % Filter the data using a ratinal transfer function
    
    % Forward filter
    fsig1 = filter(b, a, x);
    % Flip the result for backward filtering
    ffsig1 = flipud(fsig1);
    % And now filter again (backward)
    ffsig1 = filter(b, a, ffsig1);
    % Re-flip the signal (return to forward)
    filtered = flipud(ffsig1);
    
    % PLOT
    
    % Comparison:
    %figure;
    %hold on; 
    %plot(x(1: length(x) / 5), 'b'); 
    %plot(fsig1(1: length(fsig1) / 5), 'r');
    %plot(filtered(1: length(filtered) / 5), 'g');
    %legend('Unfiltered', 'Forward', 'Forward+Backward');
    %hold off;
    
    %figure(1);
    %plot(sig3(1: length(sig3) / 5));
    %figure(2);
    %plot(filtered(1: length(filtered) / 5), 'b');
    
end