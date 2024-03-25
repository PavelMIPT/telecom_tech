function cor = Autocorrelation(M_sequence)
    res = zeros(1, 2 * length(M_sequence) - 1);

    seq = zeros(1, 3 * length(M_sequence));

    seq(1 : length(M_sequence)) = M_sequence;
    seq(length(M_sequence) + 1 : 2 * length(M_sequence)) = M_sequence;
    seq(2 * length(M_sequence) + 1 : 3 * length(M_sequence) - 1) = M_sequence(1 : length(M_sequence) - 1);

    new_seq = seq(2 : length(seq));

    for i = 1 : 2 * length(M_sequence) - 1
        res(i) = dot(new_seq(i : i + length(M_sequence) - 1), M_sequence) / sqrt(sum(M_sequence.^2) * sum(new_seq(i : i + length(M_sequence) - 1).^2));
    end

    cor = res;
end