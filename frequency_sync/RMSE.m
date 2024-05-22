function error = RMSE(DM_estimate, Freq_offset)
    sum_er = 0;
    for i = 1 : length(DM_estimate)
        sum_er = sum_er + (DM_estimate(i) - Freq_offset)^2;
    end
    error = sqrt(sum_er) / sqrt(length(DM_estimate));
end