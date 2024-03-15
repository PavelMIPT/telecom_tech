% Генерация коэффицентов (импульсной характеристики)для фильтра 
% приподнятого косинуса
%> @file RC_coeff.m
% =========================================================================
%> @brief Генерация коэффицентов (импульсной характеристики)для фильтра 
%> приподнятого косинуса
%> @param span Длина фильтра в символах (число боковых лепестков sinc, сумма
%> с двух сторон)
%> @param nsamp Число выборок на символ
%> @param rolloff Коэффицент сглаживания (beta)
%> @return IR коэффиценты фильтра приподнятого косинуса
% =========================================================================
function IR = RC_coeff (span, nsamp, rolloff)
    %> @todo Место для вашего кода

    res = zeros(1, span * nsamp / 2 + 1);
    t = 0 : span * nsamp / 2;
    res(1) = 1 / sqrt(nsamp);

    for i = 2 : length(t)
        if t(i) == nsamp / (2 * rolloff)
            res(i) = 1 / sqrt(nsamp) * rolloff / 2 * sin(pi / (2 * rolloff));
        else
            res(i) = 1 / sqrt(nsamp) * sin(pi * t(i) / nsamp) / (pi * t(i) / nsamp) * cos(pi * rolloff * t(i) / nsamp) / (1 - 4 * (rolloff * t(i) / nsamp)^2);
        end
    end
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


