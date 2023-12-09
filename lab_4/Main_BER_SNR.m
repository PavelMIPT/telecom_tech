close all; clear; clc;
%% Init parametrs of model
% Length_Bit_vector = 120000;
IQ_count = 1200;

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

scatterplot(IQ_TX1);
title('BPSK')

scatterplot(IQ_TX2);
title('QPSK');

scatterplot(IQ_TX3);
title('8PSK');

scatterplot(IQ_TX4);
title('16-QAM');

%% Channel
% Write your own function Eb_N0_convert(), which convert SNR to Eb/N0

% Fixed SNR value
SNR = 20;
Eb_N01 = Eb_N0_convert(SNR, Constellation1);
Eb_N02 = Eb_N0_convert(SNR, Constellation2);
Eb_N03 = Eb_N0_convert(SNR, Constellation3);
Eb_N04 = Eb_N0_convert(SNR, Constellation4);

% Use your own function of generating of AWGN from previous tasks
IQ_RX1 = NoiseGenerator(IQ_TX1, SNR); 
IQ_RX2 = NoiseGenerator(IQ_TX2, SNR); 
IQ_RX3 = NoiseGenerator(IQ_TX3, SNR); 
IQ_RX4 = NoiseGenerator(IQ_TX4, SNR); 


scatterplot(IQ_RX1);
title('BPSK')

scatterplot(IQ_RX2);
title('QPSK');

scatterplot(IQ_RX3);
title('8PSK');

scatterplot(IQ_RX4);
title('16-QAM');

%% Demapping
Bit_Rx1 = demapping(IQ_RX1, Constellation1);
Bit_Rx2 = demapping(IQ_RX2, Constellation2);
Bit_Rx3 = demapping(IQ_RX3, Constellation3);
Bit_Rx4 = demapping(IQ_RX4, Constellation4);

%% Error check
% Write your own function Error_check() for calculation of BER
BER1 = Error_check(Bit_Tx, Bit_Rx1);
BER2 = Error_check(Bit_Tx, Bit_Rx2);
BER3 = Error_check(Bit_Tx, Bit_Rx3);
BER4 = Error_check(Bit_Tx, Bit_Rx4);

%% Additional task. Modulation error ration
% MER_estimation = MER_my_func(IQ_RX, Constellation);
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
SNR_massiv = 5:40;

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
graf = plot(SNR_massiv, BER1_massiv);
hold on;
plot(SNR_massiv, BER2_massiv);
hold on;
plot(SNR_massiv, BER3_massiv);
hold on;
plot(SNR_massiv, BER4_massiv);
xlabel("SNR");
ylabel("BER");
legend(Constellation1, Constellation2, Constellation3, Constellation4);

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
graf2 = plot(Eb_N0_massiv1, BER1_massiv);
hold on;
plot(Eb_N0_massiv2, BER2_massiv);
hold on;
plot(Eb_N0_massiv3, BER3_massiv);
hold on;
plot(Eb_N0_massiv4, BER4_massiv);
xlabel("Eb/N0");
ylabel("BER");
legend(Constellation1, Constellation2, Constellation3, Constellation4);

% saveas(graf2, "BER(Eb/N0).png");

%% Theoretical lines of BER(Eb/N0)
% Read about function erfc(x) or similar
% Configure the function and get the theoretical lines of BER(Eb/N0)
% Compare the experimental BER(Eb/N0) and theoretical for BPSK, QPSK, 8PSK
% and 16QAM constellation
% Save figure