% Полином x^5 + x^3
function res = M_sequence_1(init_seed_m, sequence_length)
    m_sequence = zeros(1, sequence_length);  % Инициализация массива для хранения последовательности
    register_state = init_seed_m;

    for i = 1:sequence_length
        new_bit = mod(register_state(end) + register_state(end - 2), 2);  % Вычисление нового бита
        m_sequence(i) = register_state(end);  % Добавление текущего бита в результат
        register_state = [new_bit, register_state(1:end-1)];  % Сдвиг регистра и добавление нового бита
    end

    res = m_sequence;
end
