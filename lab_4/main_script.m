clear all; clc; close all;

%% Illustration mapping works
bin_size = 500;
rng default;
bit_array = randi([0 1], bin_size, 1)';

constellation1 = "BPSK";
IQ1 = mapping(bit_array, constellation1);
scatterplot(IQ1);
title('BPSK');

constellation2 = "QPSK";
IQ2 = mapping(bit_array, constellation2);
scatterplot(IQ2);
title('QPSK');

constellation3 = "8PSK";
IQ3 = mapping(bit_array, constellation3);
scatterplot(IQ3);
title('8PSK');

constellation4 = "16-QAM";
IQ4 = mapping(bit_array, constellation4);
scatterplot(IQ4);
title('16-QAM');

%% Illustration demapping works
bit_array_demap1 = demapping(IQ1, constellation1);
disp(all(bit_array_demap1 == bit_array));

bit_array_demap2 = demapping(IQ2, constellation2);
disp(all(bit_array_demap2 == bit_array));

bit_array_demap3 = demapping(IQ3, constellation3);
% disp(all(bit_array_demap3 == bit_array));  % the size is 498(500)

bit_array_demap4 = demapping(IQ4, constellation4);
disp(all(bit_array_demap4 == bit_array));


