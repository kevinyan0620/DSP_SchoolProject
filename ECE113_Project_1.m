% Task 1.1 Part a)
d1 = 1;
d2 = -1;
f1 = 100;
all_delta_f = [5, 10, 40, 100];
ts = 0.001;

n = 0:1:99;
x1 = d1 * exp (1j * 2 * pi * f1 * n * ts);
for delta_f = all_delta_f
    f2 = f1 + delta_f;
    x2 = d2 * exp (1j * 2 * pi * f2 * n * ts);

    y = x1+x2;
    ybb = y .* exp(-1j * 2 * pi * f1 * n * ts);
    r = ybb;

    mse = mean((real(r) - d1) .^ 2);
    fprintf ('Part a: The MSE for delta_f = %d is %f\n', delta_f, mse);
end

% Task 1.1 Part b)
for delta_f = all_delta_f
    f2 = f1 + delta_f;
    x2 = d2 * exp (1j * 2 * pi * f2 * n * ts);

    y = x1+x2;
    ybb = y .* exp(-1j * 2 * pi * f1 * n * ts);

    lpf = fir1(30, 0.1);
    r = filtfilt(lpf, 1, ybb);

    mse = mean((real(r) - d1) .^ 2);
    fprintf ('Part b: The MSE for delta_f = %d is %f\n', delta_f, mse);

    if delta_f == 10
        figure;
        plot(n, real(r));
        title('Filtered Signal for delta_f = 10');
        xlabel('Sample Index');
        ylabel('Amplitude');
    end
    if delta_f == 100
        figure;
        plot(n, real(r));
        title('Filtered Signal for delta_f = 100');
        xlabel('Sample Index');
        ylabel('Amplitude');
    end
end
fprintf('\n')

% Task 1.2 Part a)
delta_f_sweep = 0:0.5:100;
E = zeros(1, length(delta_f_sweep));

for i = 1:length(delta_f_sweep)
    delta_f = delta_f_sweep(i);

    f2 = f1 + delta_f;
    x2 = d2 * exp (1j * 2 * pi * f2 * n * ts);

    y = x1+x2;
    ybb = y .* exp(-1j * 2 * pi * f1 * n * ts);
    d1_hat = mean(ybb);

    E(i) = abs(d1_hat - d1)^2;
end

figure;
plot(delta_f_sweep, E);
title('Error vs Delta f');
xlabel('Delta f (Hz)');
ylabel('Error');

% Task 1.3 Part c)
N = 1024;
input = 2 * randi([0, 1], 1, N) - 1;

modulation = N * ifft(input);

output = 1 / N * fft(modulation);

MSE = mean((output - input).^ 2);

fprintf('\n')
fprintf('MSE for resconstructed signal: %d\n', MSE);

