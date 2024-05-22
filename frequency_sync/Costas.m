function [RX_IQ, Costas_estimate] = Costas(Channel_IQ,Ki,Kp)

tmp=Channel_IQ;
RX_IQ = zeros(1,length(Channel_IQ));
Costas_estimate = zeros(1,length(Channel_IQ));
delayed_Error = 0;
delayed_DM = 0;
delayed_NCO = 0;

for itter_time = 1:length(Channel_IQ)-1

    dot = tmp(itter_time)*exp(-1j*2*pi*delayed_NCO*(itter_time));
    dot_r = real(dot);
    dot_i = imag(dot);
    
    RX_IQ(itter_time) = dot;

    % Detector
    error = sign(dot_r) * dot_i - sign(dot_i) * dot_r;

    % Loop filter
    DM_Filtred = double(Kp*error + (Ki-Kp)*delayed_Error + delayed_DM);

    % NCO | Phase Accumulation
    DM_NCO = delayed_NCO + DM_Filtred;

    delayed_NCO = DM_NCO;
    delayed_DM = DM_Filtred;
    delayed_Error = error;

    Costas_estimate(itter_time) = DM_NCO;
end

end
