function scores = CalculateScores(syndrome, dict)
    max_dict = zeros(1, length(syndrome));
    for i = 1 : length(syndrome)
        max_dict(i) = max(dict(i));
    end

    scores_len = max(max_dict);
    
    scores = zeros(1, scores_len);

    for i = 1 : length(syndrome)
        list = dict(i);
        if syndrome(i) == 1
            for j = 1 : length(list)
                scores(list(j)) = scores(list(j)) + 1;
            end
        else
            for j = 1 : length(list)
                scores(list(j)) = scores(list(j)) - 1;
            end
        end

    end

end