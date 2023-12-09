function NoisedSignal = NoiseGenerator(signal, SNR)
    % Определим амплитуду шума 
    % A_signal = 1
    A_noise = 10^(-SNR / 20);
    NoiseRe = A_noise * normrnd(0, 1, [1, length(signal)]);
    NoiseIm = A_noise * normrnd(0, 1, [1, length(signal)]);
    Noise = complex(NoiseRe, NoiseIm);
    NoisedSignal = signal + Noise;
end
