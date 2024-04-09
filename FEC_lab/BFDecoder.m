function decodedWord = BFDecoder(codeWord, maxIterations, H)
    % Bit-Flipping LDPC decoder proposed by Gallager

    % preparation: convert parity-check matrix into some structure of your
    % choice
    % for example, you can use dictionary and map every bit of the syndrome
    % to the bits of received word that participate in parity check for
    % this bit
    % https://www.mathworks.com/help/matlab/ref/dictionary.html
    
    new_struct = pc_matrix_convert(H);
   
    decodedCodeWord = codeWord;
    iter_num = 0;

    % check the syndrome, maybe there are no errors?
    syndrome = mod(decodedCodeWord * transpose(H), 2);

    converged = 0;

    if (sum(syndrome) == 0)
        converged = 1;
        decodedCodeWord = codeWord;
    end

    if converged == 0

        while (iter_num < maxIterations && ~converged)
            scores = CalculateScores(syndrome, new_struct); % Implement This
            decodedCodeWord = DecisionMaking(decodedCodeWord, scores); % Implement This

            syndrome = mod(decodedCodeWord*transpose(H), 2);
            iter_num = iter_num + 1;

            if (sum(syndrome) == 0)
                converged = 1;
            else
                converged = 0;
            end
        end
    end
    decodedWord = decodedCodeWord;

end