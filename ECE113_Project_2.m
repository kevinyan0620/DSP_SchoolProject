clear ; close all ; clc ;

% Load the provided clean speech signal
[x , Fs ] = audioread ('speech_clean_16k.wav') ;

% Convert to mono if needed
if size (x , 2) > 1
    x = mean (x , 2) ;
end

% Check that the sampling frequency is 16 kHz
if Fs ~= 16000
    error ('The provided audio file should have Fs = 16 kHz.') ;
end

% Remove DC offset and normalize clean speech
x = x - mean ( x ) ;
x = x / max (abs ( x ) ) ;

% Time axis
n = (0: length(x) - 1)';
t = n / Fs ;

% Noise tone frequencies
f_close = 3200; % Hz , close to upper speech band
f_far = 5500; % Hz , farther from speech band

% Relative noise amplitudes
% These values scale the noise relative to the RMS value of the clean speech.
white_scale = 0.15; % broadband white noise level
close_scale = 0.40; % 3.2 kHz tone level
far_scale = 0.40; % 5.5 kHz tone level

% Make the random white noise repeatable
rng (1) ;

% Compute RMS value of clean speech
speech_rms = sqrt ( mean ( x .^2) ) ;

% Set actual noise amplitudes relative to speech RMS
A_white = white_scale * speech_rms ;
A_close = close_scale * speech_rms ;
A_far = far_scale * speech_rms ;

% Generate noise components
white_noise = A_white * randn ( size ( x ) ) ;
tone_close = A_close * sin (2* pi* f_close * t ) ;
tone_far = A_far * sin (2* pi* f_far * t ) ;

% Add noise to clean speech
% This raw noisy signal is useful for spectrum analysis .
x_noisy_raw = x + white_noise + tone_close + tone_far ;

% Normalize only for playback / export to avoid clipping
x_noisy = x_noisy_raw / max (abs ( x_noisy_raw ) ) ;

% Save noisy speech
audiowrite ('speech_noisy_16k.wav', x_noisy , Fs ) ;

% Listen to clean and noisy speech
disp ('Playing clean speech ... ') ;
sound (x , Fs ) ;
pause ( length ( x ) / Fs + 1) ;

disp ('Playing noisy speech ... ') ;
sound ( x_noisy , Fs ) ;

% Task 2.1
figure;
subplot(2, 1, 1);
plot(t, x);
title('Clean Speech Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(t, x_noisy);
title('Noisy Speech Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Task 2.2
f = linspace(0, Fs, length(x));

figure;
subplot(2, 1, 1);
plot(f, abs(fft(x)));
xlim([0, 8000]);
%ylim([0, 100]);
title('Clean Speech Signal in Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(2, 1, 2);
plot(f, abs(fft(x_noisy)));
xlim([0, 8000]);
%ylim([0, 100]);
title('Noisy Speech Signal in Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Task 2.3
b_fir = [0.0177, 0.2287, 0.5072, 0.2287, 0.0177];
a_fir = 1;

b_iir = [0.0532, 0.0304, 0.0845, 0.0304, 0.0532];
a_iir = [1, -2.1045, 2.4080, -1.4106, 0.3896];

figure;
freqz(b_fir, a_fir, [], Fs);
title('FIR Filter Magnitude Plot');

figure;
impz(b_fir, a_fir);
title('FIR Filter Impluse Response')

figure;
freqz(b_iir, a_iir, [], Fs);
title('IIR Filter Magnitude Plot');

figure;
impz(b_iir, a_iir);
title('IIR Filter Impluse Response')
xlim([0,100]);

% Task 2.4
x_fir_filtered = filter(b_fir, a_fir, x_noisy);
x_iir_filtered = filter(b_iir, a_iir, x_noisy);

figure;
subplot(3, 1, 1);
plot(f, abs(fft(x_noisy)));
xlim([0, 8000]);
%ylim([0, 100]);
title('Noisy Speech Signal in Frequency Domain (Unfiltered)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3, 1, 2);
plot(f, abs(fft(x_fir_filtered)));
xlim([0, 8000]);
%ylim([0, 100]);
title('Noisy Speech Signal in Frequency Domain (FIR Filtered)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3, 1, 3);
plot(f, abs(fft(x_iir_filtered)));
xlim([0, 8000]);
%ylim([0, 100]);
title('Noisy Speech Signal in Frequency Domain (IIR Filtered)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Task 2.5
audiowrite ('speech_filtered_FIR.wav', x_fir_filtered , Fs ) ;
audiowrite ('speech_filtered_IIR.wav', x_iir_filtered , Fs ) ;

pause ( length ( x ) / Fs + 1) ;
disp ('Playing FIR filtered speech ... ') ;
sound (x_fir_filtered , Fs ) ;
pause ( length ( x ) / Fs + 1) ;

disp ('Playing IIR filtered speech ... ') ;
sound ( x_iir_filtered , Fs ) ;