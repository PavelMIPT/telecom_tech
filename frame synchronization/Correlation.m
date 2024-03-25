function cor = Correlation(header, sig, freq_shift)
    cor = zeros(1, length(sig)); 

    if freq_shift == 0

        for i = 1 : length(sig) - length(header) + 1
            win = sig(i : length(header) + i - 1);
            cor(i) = abs(dot(win, conj(header))) / abs(sqrt(sum(abs(header).^2) * sum(abs(win).^2)));
        end

    else
        n = 1;
        for i = 1 : length(sig) - length(header) + 1
            win = sig(i : length(header) + i - 1);
            for k = 1 : length(win)
                win(k) = win(k) * exp(2*pi*1j*freq_shift*k);  % добавляем частотный сдвиг
            end
            cor(i) = abs(dot(win, conj(header))) / abs(sqrt(sum(abs(header).^2) * sum(abs(win).^2)));
            n = n + 1;
        end

    end
    
end