function M = New_Instruction(Matrix)
    M = Matrix;
    M(8:8:420, :) = 8;
    t = 1 : 480;
    A = mod(t, 7) ~= 0; 
    M(:, A) = M(:, A) - 25.8;
    M = abs(M);
end