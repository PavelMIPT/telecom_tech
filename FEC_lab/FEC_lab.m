clear, clc, close all;

%% =============================  Warmup =====================================
% configuring LDPC encoder and decoder

% parity check matrix as defnied in Wi-Fi (IEEE® 802.11)
data = load('Parity_Check_Matrix.mat', 'H');
H = logical(data.H);

cfgLDPCEnc = ldpcEncoderConfig(H); % configuring encoder
cfgLDPCDec = ldpcDecoderConfig(H); % configuring decoder

% using cfgLDPCEnc variable, print our the number of information, parity
% check bits and the coderate
fprintf('Number of information bits in a block: %d\n', cfgLDPCEnc.NumInformationBits);
fprintf('Number of parity check bits in a block: %d\n', cfgLDPCEnc.NumParityCheckBits);
coderate = cfgLDPCEnc.NumInformationBits / cfgLDPCEnc.BlockLength;
fprintf('Coderate: %f\n', coderate);

%% simple test to check that encoder and decoder configured correctly

test_message = boolean(randi([0 1],cfgLDPCEnc.NumInformationBits,1,'int8'));
encodedData = ldpcEncode(test_message,cfgLDPCEnc);

% calculate the syndrome
s = transpose(encodedData)*transpose(H);
s=mod(s, 2); % we need xor instead of multiplication
if(~any(s))
    fprintf('No errors!\n');
else
    fprintf('Errors detected during syndrome check!\n');
end

% deliberately distorting one bit of the message
encodedData(randi(numel(encodedData))) = ~(encodedData(randi(numel(encodedData))));

% checking the syndrome once again
s = transpose(encodedData)*transpose(H);
s=mod(s, 2); % we need xor instead of multiplication
if(~any(s))
    fprintf('No errors!\n');
else
    fprintf('Errors detected during syndrome check!\n');
end

%% Part 1 Simple Bit Flipping decoding algorithm

maxIterationsBF = 50;

% Create BER-SNR plots for uncoded data and
% for LDPC coded data with your BF decoder

snr = -5 : 15;
numframes = 1000;

ber_uncode = comm.ErrorRate; 
ber_encode = comm.ErrorRate; 

% arrays to store error statistic
errStats = zeros(length(snr), numframes, 3); 
errStatsNoCoding = zeros(length(snr), numframes, 3);

constel = 'BPSK';

tStart = tic;
for ii = 1:length(snr)
    for counter = 1:numframes
        % Bit_Flipping coding
        data = randi([0 1],cfgLDPCEnc.NumInformationBits,1,'int8');
        encodedData = ldpcEncode(data,cfgLDPCEnc);
        modSignal = mapping(encodedData, constel);  % IQ points
        noise = NoiseGenerator(modSignal,snr(ii));  % noise generating
        noised_sig = modSignal + noise;
        demap = demapping(noised_sig, constel);  % signal after demapping
        decodedData = transpose(BFDecoder(demap, maxIterationsBF, H));
        errStats(ii, counter, :) = ber_encode(encodedData, int8(decodedData));

        %========================================

        % no coding system
        noCoding = mapping(data, constel);
        rxNoCoding = NoiseGenerator(noCoding,snr(ii)) + noCoding;
        rxBitsNoCoding = transpose(demapping(rxNoCoding, constel));
        errStatsNoCoding(ii, counter, :) = ber_uncode(data, int8(rxBitsNoCoding));
    end
    fprintf(['SNR = %2d\n   Coded: Error rate = %1.2f, ' ...
        'Number of errors = %d\n'], ...
        snr(ii),mean(errStats(ii, :, 1), 2), mean(errStats(ii, :, 2), 2))
    fprintf(['Noncoded: Error rate = %1.2f, ' ...
        'Number of errors = %d\n'], ...
        mean(errStatsNoCoding(ii, :, 1), 2), mean(errStatsNoCoding(ii, :, 2), 2))
    reset(ber_encode);
    reset(ber_uncode);
end
ber_encode.release();
ber_uncode.release();
tend = toc(tStart);
fprintf('Simulation finished after %.2f s\n', tend);

%%
snr = -5 : 15;
semilogy(snr, mean(errStatsNoCoding(:, :, 1), 2), 'LineWidth', 2)
hold on
fig1 = semilogy(snr, mean(errStats(:, :, 1), 2), 'LineWidth', 2);
hold off

xlabel('SNR, dB');
ylabel('BER');
grid on;
set(gca, 'Fontsize', 15);
legend('uncoded', 'encoded(BitFlipping)');
title('BER(SNR), constel = BPSK');

saveas(fig1, 'Bit_Flipping.png')

%% ============= Part 2 comparing Beleif Propagation, Bit Flipping decoders and uncoded system =================

maxnumiter = 10;
snr = 0:15; % adjust the snr range to the constellation you choose!
numframes = 1000;

% check manually on the build-in ber counter
% it outputs three variables
ber = comm.ErrorRate; %build-in BER counter
ber2 = comm.ErrorRate; %build-in BER counter

% arrays to store error statistic
errStats2 = zeros(length(snr), numframes, 3); 
errStatsNoCoding2 = zeros(length(snr), numframes, 3);

constel = 'BPSK';

tStart = tic;
for ii = 1:length(snr)
    for counter = 1:numframes
        data = randi([0 1],cfgLDPCEnc.NumInformationBits,1,'int8');
        % Transmit and receive with LDPC coding
        encodedData = ldpcEncode(data,cfgLDPCEnc);

        % YOUR MAPPER HERE choose any constellation type you like

        modSignal = mapping(encodedData, constel);

        noise = NoiseGenerator(modSignal,snr(ii)); % use your AWGN function

        noised_sig = modSignal + noise;  % addit AWGN noise

        % YOUR DEMAPPER HERE N.B. Perform Soft Demapping, output llr!
        llr = transpose(soft_demapper(noised_sig, constel));

        rxbits = ldpcDecode(llr,cfgLDPCDec,maxnumiter);
        errStats2(ii, counter, :) = ber(data,rxbits);
        %========================================

        % no coding system
        noCoding = mapping(data, constel);
        rxNoCoding = NoiseGenerator(noCoding,snr(ii)) + noCoding;
        % YOUR DEMAPPER HERE N.B. Perform Hard Demapping, output bits!
        rxBitsNoCoding = transpose(demapping(rxNoCoding, constel));
        errStatsNoCoding2(ii, counter, :) = ber2(data, int8(rxBitsNoCoding));
    end
    fprintf(['SNR = %2d\n   Coded: Error rate = %1.2f, ' ...
        'Number of errors = %d\n'], ...
        snr(ii),mean(errStats2(ii, :, 1), 2), mean(errStats2(ii, :, 2), 2))
    fprintf(['Noncoded: Error rate = %1.2f, ' ...
        'Number of errors = %d\n'], ...
        mean(errStatsNoCoding2(ii, :, 1), 2), mean(errStatsNoCoding2(ii, :, 2), 2))
    reset(ber);
    reset(ber2);
end
ber.release();
ber2.release();
tend = toc(tStart);
fprintf('Simulation finished after %.2f s\n', tend);

%%
snr = 0 : 15;
semilogy(snr, mean(errStatsNoCoding2(:, :, 1), 2), 'LineWidth', 2)
hold on
fig2 = semilogy(snr, mean(errStats2(:, :, 1), 2), 'LineWidth', 2);
hold off

xlabel('SNR, dB');
ylabel('BER');
grid on
set(gca, 'Fontsize', 20)
legend('uncoded', 'encoded');
title('BER(SNR), constel = BPSK');
saveas(fig2, 'soft_demapper.png')

% % save('BER_SNR_results.mat', 'errStatsNoCoding', 'errStats', '-v7.3')
% 
% % Replot the results in BER vs Eb/N0 scale
% % how the shape of curves has changed?
% % what is the gain in dB?
% % +20 points: compare results with llr and approximate llr formulas