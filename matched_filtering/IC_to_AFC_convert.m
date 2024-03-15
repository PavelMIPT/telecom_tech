function afr_rc = IC_to_AFC_convert(RC_IR)
    y = abs(fft(RC_IR));
    y1 = y(1 : (length(y) - 1) / 2 + 1);
    y2 = y((length(y) - 1) / 2 + 2 : length(y));
    afr_rc = zeros(1, length(y));
    afr_rc(1 : (length(y) - 1) / 2) = y2;
    afr_rc((length(y) - 1) / 2 + 1 : length(y)) = y1;
end