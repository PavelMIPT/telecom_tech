function FliipedDecodedWord = DecisionMaking(decodedWord, scores)
    % choose which bits to flip based on the scores
    inds = find(scores == max(scores));
    decodedWord(inds) = ~decodedWord(inds);
    FliipedDecodedWord = decodedWord;
end