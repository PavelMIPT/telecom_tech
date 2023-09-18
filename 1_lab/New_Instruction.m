function M = New_Instruction(Matrix)
    M = Matrix;
    for rows = 8 : 420
        if mod(rows, 8) == 0
            M(rows,:) = 8;
        end
    end
    for column = 1 : 480
        if mod(column, 7) ~= 0
            M(:, column) = M(:, column) - 25.8;
        end
    end
    M = abs(M);
    
end