function cor = Correlation(header, sig, freq_shift)
    cor = zeros(1, length(sig)); 

    if freq_shift == 0
        for i = 1 : length(sig) - length(header) + 1
            win = sig(i : length(header) + i - 1);
            cor(i) = abs(dot(win, conj(header))) / abs(sqrt(sum(abs(header).^2) * sum(abs(win).^2)));
        end

    else
        diff_coef_header = zeros(1,length(header));
        for n=1:length(header)-1
            diff_coef_header(n) = header(n)*conj(header(n+1));
        end
        x = sum(abs(diff_coef_header).^2);
        tmp = zeros(1,length(sig)-length(header));
    
        for n=1:length(sig)-length(header)
            diff_coef_data = zeros(1,length(header));
            for k = 1:length(header)-1
                diff_coef_data(k) = sig(n+k-1)*conj(sig(n+k));
            end
            tmp1 = sum(diff_coef_data.*conj(diff_coef_header));
            tmp2 = sum(abs(diff_coef_data).^2);
            tmp(n) = tmp1/sqrt(tmp2*x);
        end
        cor = abs(tmp);
    end
    
end