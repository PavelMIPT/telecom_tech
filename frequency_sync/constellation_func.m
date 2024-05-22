function [Dictionary, Bit_depth_Dict] = constellation_func(Constellation)
    keys = 0;
    values = 0;
    switch Constellation
        case "BPSK"
            keys = ["0", "1"];
            values = [complex(-1, 0), complex(1, 0)];
            Bit_depth_Dict = 1;
        case "QPSK"
            keys = ["00", "01", "10", "11"];
            values = [complex(-1, -1), complex(-1, 1), complex(1, 1), complex(1, -1)];
            Bit_depth_Dict = 2;
        case "8PSK"
            keys = ["000", "001", "011", "010", "110", "111", "101", "100"];
            values = [complex(-sqrt(2)/2, -sqrt(2)/2), complex(-1, 0), complex(-sqrt(2)/2, sqrt(2)/2), complex(0, 1), complex(sqrt(2)/2, sqrt(2)/2), complex(1, 0), complex(sqrt(2)/2, -sqrt(2)/2), complex(0, -1)];
            Bit_depth_Dict = 3;
        case "16-QAM"
            keys = ["0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111"];
            values = [complex(-3, 3), complex(-3, 1), complex(-3, -3), complex(-3, -1), complex(-1, 3), complex(-1, 1), complex(-1, -3), complex(-1, -1), complex(3, 3), complex(3, 1), complex(3, -3), complex(3, -1), complex(1, 3), complex(1, 1), complex(1, -3), complex(1, -1)];
            Bit_depth_Dict = 4;
    end
    
    % Normalise the constellation.
    % Mean power of every constellation must be equel 1.
    % Make the function to calculate the norm, 
    % which can be applied for every constellation
    norm = Norm(values);
    values = values./norm;
    Dictionary = dictionary(keys, values);
end

