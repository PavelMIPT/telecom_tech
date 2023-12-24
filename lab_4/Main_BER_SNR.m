close all; clear; clc;
%% Init parametrs of model
% Length_Bit_vector = 120000;
IQ_count = 10000;

Constellation1 = "BPSK";
Constellation2 = "QPSK";
Constellation3 = "8PSK";
Constellation4 = "16-QAM";

%% Bit generator
rng default;

Bit_Tx1 = randi([0,1], 1, IQ_count);
Bit_Tx2 = randi([0,1], 1, IQ_count * 2);
Bit_Tx3 = randi([0,1], 1, IQ_count * 3);
Bit_Tx4 = randi([0,1], 1, IQ_count * 4);

%% Mapping
IQ_TX1 = mapping(Bit_Tx1, Constellation1);
IQ_TX2 = mapping(Bit_Tx2, Constellation2);
IQ_TX3 = mapping(Bit_Tx3, Constellation3);
IQ_TX4 = mapping(Bit_Tx4, Constellation4);

%% BPSK IQ_TX1
scatter(real(IQ_TX1), imag(IQ_TX1), 40, [1, 0, 0], "filled");
title('BPSK')

%% QPSK IQ_TX2
scatter(real(IQ_TX2), imag(IQ_TX2), 40, [1, 0, 0], "filled");
title('QPSK');

%% 8PSK IQ_TX3
scatter(real(IQ_TX3), imag(IQ_TX3), 40, [1, 0, 0], "filled");
title('8PSK');

%% 16-QAM IQ_TX4
scatter(real(IQ_TX4), imag(IQ_TX4), 40, [1, 0, 0], "filled");
title('16-QAM');

%% Channel
% Write your own function Eb_N0_convert(), which convert SNR to Eb/N0

% Fixed SNR value
SNR = 10;
Eb_N01 = Eb_N0_convert(SNR, Constellation1);
Eb_N02 = Eb_N0_convert(SNR, Constellation2);
Eb_N03 = Eb_N0_convert(SNR, Constellation3);
Eb_N04 = Eb_N0_convert(SNR, Constellation4);

% Use your own function of generating of AWGN from previous tasks
IQ_RX1 = NoiseGenerator(IQ_TX1, SNR); 
IQ_RX2 = NoiseGenerator(IQ_TX2, SNR); 
IQ_RX3 = NoiseGenerator(IQ_TX3, SNR); 
IQ_RX4 = NoiseGenerator(IQ_TX4, SNR); 

%% BPSK IQ_RX1
scatter(real(IQ_RX1), imag(IQ_RX1));
hold on;
scatter(real(IQ_TX1), imag(IQ_TX1), 40, [1, 0, 0], "filled");
title('BPSK')
hold off;

%% QPSK IQ_RX2
scatter(real(IQ_RX2), imag(IQ_RX2));
hold on;
scatter(real(IQ_TX2), imag(IQ_TX2), 40, [1, 0, 0], "filled");
title('QPSK');
hold off;

%% 8PSK IQ_RX3
scatter(real(IQ_RX3), imag(IQ_RX3));
hold on;
scatter(real(IQ_TX3), imag(IQ_TX3), 40, [1, 0, 0], "filled");
title('8PSK');
hold off;

%% 16-QAM IQ_RX4
scatter(real(IQ_RX4), imag(IQ_RX4));
hold on;
scatter(real(IQ_TX4), imag(IQ_TX4), 40, [1, 0, 0], "filled");
title('16-QAM');
hold off;

%% Demapping
Bit_Rx1 = demapping(IQ_RX1, Constellation1);
Bit_Rx2 = demapping(IQ_RX2, Constellation2);
Bit_Rx3 = demapping(IQ_RX3, Constellation3);
Bit_Rx4 = demapping(IQ_RX4, Constellation4);

%% Error check
% Write your own function Error_check() for calculation of BER
BER1 = Error_check(Bit_Tx1, Bit_Rx1);
BER2 = Error_check(Bit_Tx2, Bit_Rx2);
BER3 = Error_check(Bit_Tx3, Bit_Rx3);
BER4 = Error_check(Bit_Tx4, Bit_Rx4);

%% Additional task. Modulation error ration
MER_estimation1 = MER_my_func(IQ_RX1, Constellation1);
MER_estimation2 = MER_my_func(IQ_RX2, Constellation2);
MER_estimation3 = MER_my_func(IQ_RX3, Constellation3);
MER_estimation4 = MER_my_func(IQ_RX4, Constellation4);

% Compare the SNR and MER_estimation from -50dB to +50dB for BPSK, QPSK,
% 8PSK and 16QAM constellation.
% Plot the function of error between SNR and MER for each constellation 
% Discribe the results. Make an conclusion about MER.
% You can use the cycle for collecting of data
% Save figure

%% Experimental BER(SNR) and BER(Eb/N0)
% Collect enough data to plot BER(SNR) and BER(Eb/N0) for each
% constellation.
% Compare the constalation. Describe the results
% You can use the cycle for collecting of data
% Save figure


% Data collection
SNR_massiv = -10:25;

BER3_massiv = ones(length(SNR_massiv), 1);
BER1_massiv = BER3_massiv;
BER2_massiv = BER3_massiv;
BER4_massiv = BER3_massiv;

for i = 1 : length(SNR_massiv)
    IQ_RX3 = NoiseGenerator(IQ_TX3, SNR_massiv(i)); 
    Bit_Rx3 = demapping(IQ_RX3, Constellation3);
    BER03 = Error_check(Bit_Tx3, Bit_Rx3);
    BER3_massiv(i) = BER03(2);
end

for i = 1 : length(SNR_massiv)
    IQ_RX1 = NoiseGenerator(IQ_TX1, SNR_massiv(i)); 
    Bit_Rx1 = demapping(IQ_RX1, Constellation1);
    BER01 = Error_check(Bit_Tx1, Bit_Rx1);
    BER1_massiv(i) = BER01(2);
end

for i = 1 : length(SNR_massiv)
    IQ_RX2 = NoiseGenerator(IQ_TX2, SNR_massiv(i)); 
    Bit_Rx2 = demapping(IQ_RX2, Constellation2);
    BER02 = Error_check(Bit_Tx2, Bit_Rx2);
    BER2_massiv(i) = BER02(2);
end

for i = 1 : length(SNR_massiv)
    IQ_RX4 = NoiseGenerator(IQ_TX4, SNR_massiv(i)); 
    Bit_Rx4 = demapping(IQ_RX4, Constellation4);
    BER04 = Error_check(Bit_Tx4, Bit_Rx4);
    BER4_massiv(i) = BER04(2);
end

%% BER(SNR) for each constellation
figure;
graf = semilogy(SNR_massiv, BER1_massiv);
hold on;
semilogy(SNR_massiv, (BER2_massiv));
semilogy(SNR_massiv, (BER3_massiv));
semilogy(SNR_massiv, (BER4_massiv));
xlabel("SNR");
ylabel("BER");
legend(Constellation1, Constellation2, Constellation3, Constellation4);
hold off;
saveas(graf, "BER(SNR).png");

%% BER(Eb/N0) data collection
Eb_N0_massiv1 = SNR_massiv;
Eb_N0_massiv2 = Eb_N0_massiv1;
Eb_N0_massiv3 = Eb_N0_massiv1;
Eb_N0_massiv4 = Eb_N0_massiv1;

for i = 1 : length(SNR_massiv)
    Eb_N0_massiv1(i) = Eb_N0_convert(SNR_massiv(i), Constellation1);
    Eb_N0_massiv2(i) = Eb_N0_convert(SNR_massiv(i), Constellation2);
    Eb_N0_massiv3(i) = Eb_N0_convert(SNR_massiv(i), Constellation3);
    Eb_N0_massiv4(i) = Eb_N0_convert(SNR_massiv(i), Constellation4);
end

%% BER(Eb/N0) for each constellation
figure;
graf2 = semilogy(Eb_N0_massiv1, BER1_massiv);
hold on;
semilogy(Eb_N0_massiv2, BER2_massiv);
semilogy(Eb_N0_massiv3, BER3_massiv);
semilogy(Eb_N0_massiv4, BER4_massiv);
xlabel("Eb/N0");
ylabel("BER");
legend(Constellation1, Constellation2, Constellation3, Constellation4);
hold off;

% saveas(graf2, "BER(Eb/N0).png");

%% Theoretical lines of BER(Eb/N0)
% Read about function erfc(x) or similar
% Configure the function and get the theoretical lines of BER(Eb/N0)
% Compare the experimental BER(Eb/N0) and theoretical for BPSK, QPSK, 8PSK
% and 16QAM constellation
% Save figure