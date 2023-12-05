function [NoisedSignal, Noise] = NoiseGenerator(signal, SNR)
    % Определим амплитуду шума 
    % A_signal = 1
    A_noise = 10^(-SNR / 20);

    Noise = A_noise * normrnd(0, 1, [1, size(signal, 2)]);
    NoisedSignal = signal + Noise;
end