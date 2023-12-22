function [MER] = MER_my_func(IQ_RX, Constellation)
    [Dictionary, Bit_depth_Dict] = constellation_func(Constellation);
    Psig = 0;
    Pnoise = 0;
    for i = 1 : 2^Bit_depth_Dict
        v = values(Dictionary);
        Psig = Psig + abs(v(i))^2;
    end

    for i = 1 : length(IQ_RX)
        Pnoise = Pnoise + abs(IQ_RX(i))^2;
    end

    MER = 10 * log10(Psig / Pnoise);
    
end

