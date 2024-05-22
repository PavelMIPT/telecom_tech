function [RX_IQ, LR_estimate] = LR(Channel_IQ, IQ_SOF, N)
    RX_IQ=Channel_IQ;
    LR_estimate = []; 
    LR_NCO = 0;
    counter = 1;
    delayed_NCO = 0;
    
    for itter_time = 1: length(Channel_IQ)
    
        % Compensation
        RX_IQ(itter_time) = RX_IQ(itter_time).*exp(-1j.*2.*pi*LR_NCO*counter);
        counter = counter + 1;
        if mod(itter_time,1460)==20
                % LR detector
                z = RX_IQ(itter_time-length(IQ_SOF)+1:itter_time).*IQ_SOF;
                tmp = 0;
                for n=1:N
                    R = 0;
                    for i = n+1:length(IQ_SOF)
                        R = R + z(i)*conj(z(i-n));
                    end
                    tmp = tmp + 1/(length(IQ_SOF)-n)*R;
                end
                error = 1/pi/(N+1)*angle(tmp);
    
                % NCO | Phase Accumulation
                LR_NCO = delayed_NCO + error;
                delayed_NCO = LR_NCO;
                LR_estimate = [LR_estimate, LR_NCO];
                counter = 1;
        end
    end
    
    % =========================================================================
    % How does the estimate behave? Show on the plot
    % How did the constellation change?
    % -------------------------------------------------------------------------
end

