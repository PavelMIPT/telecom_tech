function Points = mapping(Bit_Tx, Constellation)
    % Make the different dictionary for BPSK, QPSK, 8PSK, 16QAM constellations
    % calculate the Bit_depth for each contellation
    
    % Dictionary - points of Constellation
    [Dictionary, Bit_depth_Dict] = constellation_func(Constellation);
    
    % write  the function of mapping from bit vector to IQ vector
    
    % Future complex points
    % Points = zeros(length(Bit_Tx) / Bit_depth_Dict, 1)';
    Points = [];
    if mod(length(Bit_Tx), Bit_depth_Dict) == 0
        if Constellation == 'BPSK'
            for i = 1 : length(Bit_Tx)
                key = Bit_Tx(i);
                point = Dictionary(key);  % complex point
                Points = [Points, point];
            end
        
        elseif Constellation == 'QPSK'
            for i = 1 : Bit_depth_Dict : length(Bit_Tx) - 1
                key = strcat(num2str(Bit_Tx(i)), num2str(Bit_Tx(i + 1)));
                point = Dictionary(key);  % complex point
                Points = [Points, point];
            end
        
        elseif Constellation == '8PSK'
             for i = 1 : Bit_depth_Dict : length(Bit_Tx) - 2
                key = strcat(num2str(Bit_Tx(i)), num2str(Bit_Tx(i + 1)), num2str(Bit_Tx(i + 2)));
                point = Dictionary(key);  % complex point
                Points = [Points, point];
             end
        
        elseif Constellation == '16-QAM'
            for i = 1 : Bit_depth_Dict : length(Bit_Tx) - 3
                key = strcat(num2str(Bit_Tx(i)), num2str(Bit_Tx(i + 1)), num2str(Bit_Tx(i + 2)), num2str(Bit_Tx(i + 3)));
                point = Dictionary(key);  % complex point
                Points = [Points, point];
            end
        end
    else
        error('You should change a Bit_Tx size!');
    end

end
