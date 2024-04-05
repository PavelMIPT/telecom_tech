function new_struct = pc_matrix_convert(H)
    new_struct = containers.Map('KeyType', 'double', 'ValueType', 'any');

    for i = 1 : size(H, 1)
        H_str = H(i : size(H, 1) : end);
        new_struct(i) = find(H_str);
    end

end