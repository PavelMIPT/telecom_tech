clear all; close all; clc;
%% Task 1
% % Raised Cosine Filter RC
% % Длина фильтра в символах (число боковых лепестков sinc, сумма с двух сторон)
span = 20;
% Число выборок на символ
nsamp  = 8;
% Коэффицент сглаживания (beta)
rolloff = 0.2;

RC_IR = RC_coeff(span, nsamp, rolloff);  % IR = Impulse Response

% Проверка
filter_RC = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
                                       'FilterSpanInSymbols',span,...
                                       'OutputSamplesPerSymbol', nsamp,...
                                       'Shape', 'Normal');
RC_ethalon = coeffs(filter_RC);

subplot(2,1,1);
plot(RC_IR);
title('ИХ приподнятого косинуса(RC)');
grid on;

subplot(2,1,2);
afr_rc = IC_to_AFC_convert(RC_IR);
plot(afr_rc);
title('АЧХ приподнятого косинуса(RC)');
grid on;

Check_1 = sum(abs(RC_ethalon.Numerator-RC_IR));

if Check_1 < 0.001 % различно прописанные функции
                   % могут различаться по точности
    disp('Импульсная характеристика RC - OK');
else 
    disp('Импульсная характеристика RC - ошибка');
end

%% меняем span
span1 = 10;
span2 = 5;

RC_IR_span1 = RC_coeff(span1, nsamp, rolloff);
RC_IR_span2 = RC_coeff(span2, nsamp, rolloff);

subplot(2,1,1);
plot(RC_IR, 'b');
hold on;
plot(RC_IR_span1, 'r');
hold on;
plot(RC_IR_span2, 'g');
xlabel('время');
legend('span = 20', 'span = 10', 'span = 5');
title('ИХ приподнятого косинуса');
grid on;
hold off;

f = 0 : 1 / nsamp : span;
afc_1 = IC_to_AFC_convert(RC_IR_span1);
afc_2 = IC_to_AFC_convert(RC_IR_span2);
f_1 = 0 : 1 / nsamp : (length(afc_1) - 1) / nsamp;
f_2 = 0 : 1 / nsamp : (length(afc_2) - 1) / nsamp;

subplot(2,1,2);
plot(f, IC_to_AFC_convert(RC_IR), 'b');
hold on;
plot(f_1, IC_to_AFC_convert(RC_IR_span1), 'r');
hold on;
plot(f_2, IC_to_AFC_convert(RC_IR_span2), 'g');
xlabel('частота');
legend('span = 20', 'span = 10', 'span = 5');
title('АЧХ приподнятого косинуса');
grid on;
hold off;

%% меняем nsamp
nsamp1 = 4;
nsamp2 = 2;

RC_IR_nsamp1 = RC_coeff(span, nsamp1, rolloff);
RC_IR_nsamp2 = RC_coeff(span, nsamp2, rolloff);

subplot(2,1,1);
plot(RC_IR, 'b');
hold on;
plot(RC_IR_nsamp1, 'r');
hold on;
plot(RC_IR_nsamp2, 'g');
legend('nsamp = 8', 'nsamp = 4', 'nsamp = 2');
title('ИХ приподнятого косинуса');
grid on;
hold off;

afc_3 = IC_to_AFC_convert(RC_IR_nsamp1);
afc_4 = IC_to_AFC_convert(RC_IR_nsamp2);
f_3 = 0 : 1 / nsamp : (length(afc_3) - 1) / nsamp;
f_4 = 0 : 1 / nsamp : (length(afc_4) - 1) / nsamp;

subplot(2,1,2);
plot(f, IC_to_AFC_convert(RC_IR), 'b');
hold on;
plot(f_3, IC_to_AFC_convert(RC_IR_nsamp1), 'r');
hold on;
plot(f_4, IC_to_AFC_convert(RC_IR_nsamp2), 'g');
legend('nsamp = 8', 'nsamp = 4', 'nsamp = 2');
title('АЧХ приподнятого косинуса');
grid on;
hold off;

%% меняем rolloff
rolloff1 = 0.05;
rolloff2 = 0.5;

RC_IR_rolloff1 = RC_coeff(span, nsamp, rolloff1);
RC_IR_rolloff2 = RC_coeff(span, nsamp, rolloff2);

subplot(2,1,1);
plot(RC_IR_rolloff1, 'b');
hold on;
plot(RC_IR, 'r');
hold on;
plot(RC_IR_rolloff2, 'g');
legend('rolloff = 0.05', 'rolloff = 0.2', 'rolloff = 0.5');
title('ИХ приподнятого косинуса');
grid on;
hold off;

afc_5 = IC_to_AFC_convert(RC_IR_rolloff1);
afc_6 = IC_to_AFC_convert(RC_IR_rolloff2);
f_5 = 0 : 1 / nsamp : (length(afc_5) - 1) / nsamp;
f_6 = 0 : 1 / nsamp : (length(afc_6) - 1) / nsamp;


subplot(2,1,2);
plot(f, IC_to_AFC_convert(RC_IR), 'b');
hold on;
plot(f_5, IC_to_AFC_convert(RC_IR_rolloff1), 'r');
hold on;
plot(f_6, IC_to_AFC_convert(RC_IR_rolloff2), 'g');
legend('rolloff = 0.2', 'rolloff = 0.05', 'rolloff = 0.5');
title('АЧХ приподнятого косинуса');
grid on;
hold off;

%% Task 2
% Root Raised Cosine Filter RRC
% Длина фильтра в символах (число боковых лепестков sinc, сумма с двух сторон)
span = 20;
% Число выборок на символ
nsamp  = 8;
% Коэффицент сглаживания (beta)
rolloff = 0.2;

RRC_IR = RRC_coeff(span, nsamp, rolloff);

% Проверка
filter_RRC = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
                                             'FilterSpanInSymbols',span,...
                                             'OutputSamplesPerSymbol', nsamp, ...
                                             'Shape', 'Square root');
RRC_ethalon = coeffs(filter_RRC);

subplot(2,1,1);
plot(RRC_IR);
title('ИХ корня из приподнятого косинуса(RRC)');
grid on;

afr_rrc = IC_to_AFC_convert(RRC_IR);

subplot(2,1,2); 
plot(afr_rrc);
title('АЧХ корня из приподнятого косинуса(RRC)');
grid on;

Check_2 = sum(abs(RRC_ethalon.Numerator-RRC_IR));

 if Check_2 < 0.001 % различно прописанные функции
                   % могут различаться по точности
    disp('Импульсная характеристика RRC - OK');
else 
    disp('Импульсная характеристика RRC - ошибка')
 end

%% меняем span
RRC_IR_span1 = RRC_coeff(span1, nsamp, rolloff);
RRC_IR_span2 = RRC_coeff(span2, nsamp, rolloff);

subplot(2, 1, 1);
plot(RRC_IR, 'b');
hold on;
plot(RRC_IR_span1, 'r');
hold on;
plot(RRC_IR_span2, 'g');
xlabel('время');
legend('span = 20', 'span = 10', 'span = 5');
title('ИХ корня из приподнятого косинуса');
grid on;
hold off;

f = 0 : 1 / nsamp : span;
afc1 = IC_to_AFC_convert(RRC_IR_span1);
afc2 = IC_to_AFC_convert(RRC_IR_span2);
f1 = 0 : 1 / nsamp : (length(afc1) - 1) / nsamp;
f2 = 0 : 1 / nsamp : (length(afc2) - 1) / nsamp;

subplot(2, 1, 2);
plot(f, IC_to_AFC_convert(RRC_IR), 'b');
hold on;
plot(f1, afc1, 'r');
hold on;
plot(f2, afc2, 'g');
xlabel('частота');
legend('span = 20', 'span = 10', 'span = 5');
title('АЧХ корня из приподнятого косинуса');
grid on;
hold off;

%% меняем nsamp
RRC_IR_nsamp1 = RRC_coeff(span, nsamp1, rolloff);
RRC_IR_nsamp2 = RRC_coeff(span, nsamp2, rolloff);

subplot(2, 1, 1);
plot(RRC_IR, 'b');
hold on;
plot(RRC_IR_nsamp1, 'r');
hold on;
plot(RRC_IR_nsamp2, 'g');
title('время');
legend('nsamp = 8', 'nsamp = 4', 'nsamp = 2');
title('ИХ корня из приподнятого косинуса');
grid on;
hold off;

afc3 = IC_to_AFC_convert(RRC_IR_nsamp1);
afc4 = IC_to_AFC_convert(RRC_IR_nsamp2);
f3 = 0 : 1 / nsamp : (length(afc3) - 1) / nsamp;
f4 = 0 : 1 / nsamp : (length(afc4) - 1) / nsamp;

subplot(2, 1, 2);
plot(f, IC_to_AFC_convert(RRC_IR), 'b');
hold on;
plot(f3, afc3, 'r');
hold on;
plot(f4, afc4, 'g');
xlabel('частота');
legend('nsamp = 8', 'nsamp = 4', 'nsamp = 2');
title('АЧХ корня из приподнятого косинуса');
grid on;
hold off;

%% меняем rolloff
RRC_IR_rolloff1 = RRC_coeff(span, nsamp, rolloff1);
RRC_IR_rolloff2 = RRC_coeff(span, nsamp, rolloff2);

subplot(2, 1, 1);
plot(RRC_IR, 'b');
hold on;
plot(RRC_IR_rolloff1, 'r');
hold on;
plot(RRC_IR_rolloff2, 'g');
xlabel('время');
legend('rolloff = 0.05', 'rolloff = 0.2', 'rolloff = 0.5');
title('ИХ приподнятого косинуса');
grid on;
hold off;

afc5 = IC_to_AFC_convert(RRC_IR_rolloff1);
afc6 = IC_to_AFC_convert(RRC_IR_rolloff2);
f5 = 0 : 1 / nsamp : (length(afc5) - 1) / nsamp;
f6 = 0 : 1 / nsamp : (length(afc6) - 1) / nsamp;

subplot(2, 1, 2);
plot(f, IC_to_AFC_convert(RRC_IR), 'b');
hold on;
plot(f5, afc5, 'r');
hold on;
plot(f6, afc6, 'g');
xlabel('частота');
legend('rolloff = 0.05', 'rolloff = 0.2', 'rolloff = 0.5');
title('АЧХ корня из приподнятого косинуса');
grid on;
hold off;

%% Task 3
% Filtration
UpSempFlag = true;
rng("default");
TX_bit = randi([0 1], 1, 8000); % генерация бит
TX_IQ = mapping(TX_bit, "QPSK"); % QPSK (сигнал до фильтрации)
RC_Filtred = filtration(TX_IQ, RC_IR, nsamp, UpSempFlag);

% plot(abs(fft(RC_Filtred)), 'b');
% xlabel('частота');
% title('АЧХ сигнала после 1 фильтрации');
% grid on;

% Проверка
RC_Filtration_ethalon = filter_RC(TX_IQ.').';
Check_3_1 = sum(abs(RC_Filtration_ethalon-RC_Filtred));

if Check_3_1 < 0.1 % различно прописанные функции
                   % могут различаться по точности
    disp('Фильтрация с RC фильтром с передискретизацией - OK')
else 
    disp('Фильтрация с RC фильтром с передискретизацией - ошибка')
end


UpSempFlag = true;
RRC_Filtred = filtration(TX_IQ, RRC_IR, nsamp, UpSempFlag);
RRC_Filtration_ethalon = filter_RRC(TX_IQ.').';
Check_3_2 = sum(abs(RRC_Filtration_ethalon-RRC_Filtred));

if Check_3_2 < 0.1 % различно прописанные функции
                   % могут различаться по точности
    disp('Фильтрация с RRC фильтром с передискретизацией - OK')
else 
    disp('Фильтрация с RRC фильтром с передискретизацией - ошибка')
end
% 
UpSempFlag = false;
RX_RC_Filtred_Signal = filtration(RC_Filtred, RC_IR, nsamp, UpSempFlag);
RX_RC_filter = comm.RaisedCosineReceiveFilter('RolloffFactor', rolloff, ...
                                          'FilterSpanInSymbols',span,...
                                          'InputSamplesPerSymbol', nsamp,...
                                          'DecimationFactor', 1,...
                                          'Shape','Normal');
RX_RC_Filtred_Signal_ethalon = RX_RC_filter(RC_Filtration_ethalon.').';
Check_3_3 = sum(abs(RX_RC_Filtred_Signal_ethalon-RX_RC_Filtred_Signal));

if Check_3_3 < 0.1 % различно прописанные функции
                   % могут различаться по точности
    disp('Фильтрация с RC фильтром без передискретизацией - OK')
else 
    disp('Фильтрация с RC фильтром без передискретизацией - ошибка')
end

UpSempFlag = false;
RX_RRC_Filtred_Signal = filtration(RRC_Filtred, RRC_IR, nsamp, UpSempFlag);
RX_RRC_filter = comm.RaisedCosineReceiveFilter('RolloffFactor', rolloff, ...
                                          'FilterSpanInSymbols',span,...
                                          'InputSamplesPerSymbol', nsamp,...
                                          'DecimationFactor', 1,...
                                          'Shape','Square root');
RX_RRC_Filtred_Signal_ethalon = RX_RRC_filter(RRC_Filtration_ethalon.').';
Check_3_4 = sum(abs(RX_RRC_Filtred_Signal_ethalon-RX_RRC_Filtred_Signal));

if Check_3_4 < 0.1 % различно прописанные функции
                   % могут различаться по точности
    disp('Фильтрация с RRC фильтром без передискретизацией - OK')
else 
    disp('Фильтрация с RRC фильтром без передискретизацией - ошибка')
end

%% Task 4
% Telecom system with filtration
SNR = 20; 
Noise = NoiseGenerator(RC_Filtred, SNR);  % Channel
UpSempFlag = false;

% RC filtration
RX_RC_Filtred_Signal = filtration(RC_Filtred, RC_IR, nsamp, UpSempFlag);

% Bit_RX_RC = demapping(RX_RC_Filtred_Signal, 'QPSK');
Noise_RC = filtration(Noise, RC_IR, nsamp, false);
SNR_RC = 10 * log10(PowerSignal(RX_RC_Filtred_Signal) / PowerSignal(Noise_RC));

% RRC filtration
RX_RRC_Filtred_Signal = filtration(RRC_Filtred, RRC_IR, nsamp, UpSempFlag);
% Bit_RX_RRC = demapping(RX_RC_Filtred_Signal, 'QPSK');
Noise_RRC = filtration(Noise, RRC_IR, nsamp, false);
SNR_RRC = 10 * log10(PowerSignal(RX_RRC_Filtred_Signal) / PowerSignal(Noise_RRC));

% Es/N0
Es_no_ch = SNR + 10 * log10(1 / nsamp);  % Es/N0 в канале
Es_no_rc = SNR_RC + 10 * log10(1 / nsamp);  % Es/N0 в канале
Es_no_rrc = SNR_RRC + 10 * log10(1 / nsamp);  % Es/N0 в канале
%% АЧХ RC
afr1 = fft(TX_IQ);
afr2 = fft(RX_RC_Filtred_Signal);

subplot(2, 1, 1);
plot(abs(afr1), 'b');
xlabel('частота');
title('АЧХ сигнала до RC фильтрации');
grid on;

subplot(2, 1, 2);
plot(abs(afr2), 'b');
xlabel('частота');
title('АЧХ сигнала после 2-ой Rc фильтрации');
grid on;

%% АЧХ RRC
afr3 = fft(RX_RRC_Filtred_Signal);

subplot(2, 1, 1);
plot(abs(afr3), 'b');
xlabel('частота');
title('АЧХ сигнала после 2-ой RRC фильтрации');
grid on;

subplot(2, 1, 2);
plot(abs(afr2), 'b');
xlabel('частота');
title('АЧХ сигнала после 2-ой Rc фильтрации');
grid on;
%% Signal constellation after second RC_filtration
QPSK_IQ = [sqrt(2)/2 + sqrt(2)/2i, sqrt(2)/2 - sqrt(2)/2i, - sqrt(2)/2 + sqrt(2)/2i, - sqrt(2)/2 - sqrt(2)/2i];

Noised_signal = RC_Filtred + Noise;
RX_RC_Filtred_Noised_sig = filtration(Noised_signal, RC_IR, nsamp, UpSempFlag);  % сигнал на выходе 2 фильтра
scatter(real(RX_RC_Filtred_Noised_sig), imag(RX_RC_Filtred_Noised_sig));
hold on;
scatter(real(QPSK_IQ), imag(QPSK_IQ), 'r', 'filled');
grid on;
hold off;
title('Signal constellation after second RC filtration');

demapRC = demapping(RX_RC_Filtred_Noised_sig, 'QPSK');

%% Signal constellation after second RRC_filtration
Noised_signal = RRC_Filtred + Noise;
RX_RRC_Filtred_Noised_sig = filtration(Noised_signal, RRC_IR, nsamp, UpSempFlag);  % сигнал на выходе 2 фильтра
scatter(real(RX_RRC_Filtred_Noised_sig), imag(RX_RRC_Filtred_Noised_sig));
hold on;
scatter(real(QPSK_IQ), imag(QPSK_IQ), 'r', 'filled');
grid on;
hold off;
title('Signal constellation after second RRC filtration');

demapRRC = demapping(RX_RRC_Filtred_Noised_sig, 'QPSK');
 

%% Task 5
% Symbolic desynchronisation
% RC
RC_Filtred = RC_Filtred(2 : length(RC_Filtred));
rng("default");
new_sig = filtration(RC_Filtred + NoiseGenerator(RC_Filtred, SNR), RC_IR, nsamp, false);

scatter(real(new_sig), imag(new_sig), 'b');
hold on;
scatter(real(QPSK_IQ), imag(QPSK_IQ), 'r', 'filled');
grid on;
hold off;
title('Signal constellation after second RC filtration');

