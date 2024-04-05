function N = Norm(values)
    sum = 0;
    for i = 1 : size(values, 2)
        sum = sum + values(i) * conj(values(i));
    end
    N = sqrt(sum / size(values, 2));
end