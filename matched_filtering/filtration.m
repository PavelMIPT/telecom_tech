% Фильтрация
% > @file filtration.m
% =========================================================================
% > @brief Фильтрация
% > @param sign входной сигнал
% > @param coeff коэффиценты фильтра
% > @param nsamp число выборок на символ
% > @param UpSempFlag [1] -  фильтр с передескретезацией,[0] - фильтр без передескретизации 
% > @return filtsign отфильтрованный сигнал 
% =========================================================================


% sign - IQ точки входного сигнала до фильтрации
% coeff - ИХ фильтра
function filtsign = filtration(sign, coeff, nsamp, UpSampFlag)
    %> @todo место для вашего кода
    if UpSampFlag
        newsign = upsample(sign, nsamp);
        res = conv(newsign, coeff);
        filtsign = res(1 : length(newsign));
    else
        res = conv(sign, coeff);
        filtsign = res(1 : length(res) - length(coeff) + 1);
    end
    
end 