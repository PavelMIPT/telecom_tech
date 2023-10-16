function NoisedSignal = NoiseGenerator(signal, SNR)
    % Определим амплитуду шума 
    % A_signal = 1
    A_noise = 10^(-SNR / 20);

    Noise = A_noise * normrnd(0, 1, [1, 1000]);
    NoisedSignal = signal + Noise;
end