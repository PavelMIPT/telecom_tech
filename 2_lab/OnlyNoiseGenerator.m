function Noise = OnlyNoiseGenerator(SNR)
    A_noise = 10^(-SNR / 20);
    Noise = A_noise * normrnd(0, 1, [1, 1000]);
end