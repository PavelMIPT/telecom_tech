% Генерация коэффицентов (импульсной характеристики)для фильтра корень 
% приподнятого косинуса
%> @file RRC_coeff.m
% =========================================================================
%> @brief Генерация коэффицентов (импульсной характеристики)для фильтра корень 
%> приподнятого косинуса
%> @param span Длина фильтра в символах (число боковых лепестков sinc, сумма
%> с двух сторон)
%> @param nsamp Число выборок на символ
%> @param rolloff Коэффицент сглаживания (beta)
%> @return IR коэффиценты для фильтра корень приподнятого косинуса
% =========================================================================
function IR = RRC_coeff (span, nsamp, rolloff)
    %> @todo Место для вашего кода

    res = zeros(1, span * nsamp / 2 + 1);
    t = 0 : span * nsamp / 2;
    res(1) = (rolloff * (4 - pi) + pi) / (pi * sqrt(nsamp));

    for i = 2 : length(t)
        if t(i) == nsamp / (4 * rolloff)
            res(i) = rolloff / (sqrt(nsamp) * sqrt(2)) * ((1 + 2 / pi) * sin(pi / (4 * rolloff)) + (1 - 2 / pi) * cos(pi / (4 * rolloff)));
        else
            res(i) = 4 * rolloff / (pi * sqrt(nsamp)) * (cos((1 + rolloff) * pi * t(i) / nsamp) + nsamp / (4 * rolloff * t(i)) * sin((1 - rolloff) * pi * t(i) / nsamp)) / (1 - 16 * (rolloff * t(i) / nsamp)^2);
        end
    end

    % res(nsamp / (4 * rolloff) + 1) = rolloff / (sqrt(nsamp) * sqrt(2)) * ((1 + 2 / pi) * sin(pi / (4 * rolloff)) + (1 - 2 / pi) * cos(pi / (4 * rolloff)));
  
    inres = fliplr(res);

    result = zeros(1, span * nsamp + 1);

    for i = 1 : span * nsamp / 2 + 1
        result(i) = inres(i);
    end
    
    for i = 2 : span * nsamp / 2 + 1
        result(span * nsamp / 2 + i) = res(i);
    end

    IR = result;

end 