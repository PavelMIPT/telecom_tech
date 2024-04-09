function llr = soft_demapper(IQ, Constellation)
    [Dictionary, Bit_depth_Dict] = constellation_func(Constellation);
    str_bits = keys(Dictionary);
    llr = zeros(1, Bit_depth_Dict * length(IQ));
    ind = 1;
    for i = 1 : length(IQ)
        numerator = 0;
        denominator = 0;
        for k = 1 : Bit_depth_Dict
            for j = 1 : length(str_bits)
                symbol = str_bits(j);
                if symbol(k) == '0' 
                    numerator = numerator + exp(-abs(IQ(i) - Dictionary(symbol))^2);
                elseif symbol(k) == '1'
                    denominator = denominator + exp(-abs(IQ(i) - Dictionary(symbol))^2);
                end

            end
            llr(ind) = log(numerator / denominator);
            ind = ind + 1;
        end
    end
end
