function N = Norm(values)
    sum = 0;
    for i = 1 : length(values)
        sum = sum + values(i) * conj(values(i));
    end
    N = sqrt(sum / length(values));
end