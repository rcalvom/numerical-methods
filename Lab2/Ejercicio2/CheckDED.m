function bool = CheckDED(M)
    % Variable que indica si la matriz cumple con la condición
    bool = 1;
    
    % Itera sobre las filas de matriz dada
    for a = 1 : size(M, 1)
        % Declara un acumulador en el que se almacena la suma de los
        % elementos en la fila de la matriz
        acc = 0;
        % Itera sobre las columnas de la matriz dada
        for b = 1 : size(M, 2)
            % Suma todos los elementos en una fila
            acc = acc + abs(M(a, b));
        end
        
        % Quita el valor la posicion aa a lo obtenido en acumulador y
        % comprueba si es mayor al mismo valor aa
        if acc - abs(M(a, a)) > abs(M(a, a))
            % En caso de cumplirse la condicion la matriz no es diagonal
            % estrictamente dominante, devuelve un 0 y rompe el ciclo
            bool = 0;
            break;
        end
    end
end