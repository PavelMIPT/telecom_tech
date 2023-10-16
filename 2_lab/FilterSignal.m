function FilteredNoisedSignal  = FilterSignal(NoisedSignal, freq)
    % Определение полосы пропускания и задержания
    lower_freq = 20;  % Нижняя граница полосы пропускания
    upper_freq = 40;  % Верхняя граница полосы пропускания
    
    FilteredNoisedSignal = NoisedSignal;

    % Применение фильтрации
    for i = 1:length(NoisedSignal)
        if freq(i) < lower_freq || freq(i) > upper_freq
            FilteredNoisedSignal(i) = 0;  % Пропускаем частоты вне полосы пропускания
        end
    end
end