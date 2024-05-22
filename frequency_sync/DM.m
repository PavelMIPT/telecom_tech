function [RX_IQ, DM_estimate] = DM(Channel_IQ, frame_len, Kp, Ki, IQ_SOF, D)
    delayed_Error = 0;
    delayed_DM = 0;
    delayed_NCO = 0;
    DM_estimate = [];
    DM_NCO = 0;
    RX_IQ = Channel_IQ;
    count = 1;
    
    for itter_time = 1: length(Channel_IQ)
    
        % Compensation
        RX_IQ(itter_time) = RX_IQ(itter_time).*exp(-1j.*2.*pi*DM_NCO*count);
        count = count + 1;
    
        if mod(itter_time, frame_len) == 20
            
            % DM detector
            z = RX_IQ(itter_time-length(IQ_SOF)+1:itter_time).*IQ_SOF;
            tmp = 0;
            for i = D+1:length(IQ_SOF)
                tmp = tmp + z(i)*conj(z(i-D));
            end
            error = 1/(2*pi*D)*angle(tmp);
            
            % Loop filter
            DM_Filtred = Kp*error + (Ki-Kp)*delayed_Error + delayed_DM;

            % NCO | Phase Accumulation
            DM_NCO = delayed_NCO + DM_Filtred;

            delayed_NCO = DM_NCO;
            delayed_DM = DM_Filtred;
            delayed_Error = error;

            DM_estimate = [DM_estimate, DM_NCO];
            count = 1;
        end
        
    end
    % =========================================================================
    % TASK
    % For different Damping Factor and BnTs calculate coefficients of loop filter
    % What changes in synchronisation when the loop filter coefficients are recalculated?
    % Illustrate these changes on the graphs
    % How did the constellation change?
    % -------------------------------------------------------------------------

end

