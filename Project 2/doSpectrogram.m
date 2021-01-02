function doSpectrogram(x, Fs, nF) %nF should be a number of a power of two 

Nr = length(x);	% Length of signal in samples

t = (0 : Nr - 1) / Fs;		% Vector of times
f = ((0 : Nr - 1) / Nr) * Fs;	% Vector of frequencies

% --- USING INTEGRATED FUNCTIONS ---
% nF/s - overlap - experiment with s=0, nF/4, nF/2, and nF-1

overlap = nF / 2;
window = hanning(nF); % could be window = ones(nF,1); or window = triang(nF); or window = hamming(nF); etc.
[B, fr, tm] = spectrogram(x, window, overlap, nF, Fs);

figure;
imagesc(tm, fr, 20 * log10(abs(B) / nF));
% colormap(parula);
set(gca, 'YDir', 'normal');
xlabel('Time');
ylabel('Frequency');
title('Spectrogram');

end