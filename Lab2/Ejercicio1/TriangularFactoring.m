function matrix = TriangularFactoring(M, B)
    % La siguiente función implementa el algoritmo para calcular la factorización LU
    % de una matriz cuadrada M con un vector columna de valores independientes de cada
    % una de las ecuaciones de M.
    % Parámetros: Matriz cuadrada M y vector columna B
    % Resultado: retorna la matriz aumentada con la factorización LU y el vector columna
    % B, el cual habrá sido modificado en caso de que se hayan realizado cambios de columna.
    
    % Se guarda en la variable matrix la matriz aumentada de M y B
    matrix = [M B];

    % Bucle para recorrer cada una de las filas de la matriz aumentada
    for a = 1 : size(matrix, 1);

        % Condicional para comprobar si el pivote de la fila actual es igual a cero
        if matrix(a, a) == 0;

            % En caso de que el pivote sea cero se busca un elemento en la misma columna que
            % no sea igual a cero con el fin de intercambiar ambas filas.

            % Variable que almacenara el número de la fila que cumple la condición para
            % posteriormente intercambiar filas.
            row = 0;

            % Bucle para iterar por los elementos de la columna
            for b = a + 1 : size(matrix, 1);

                % Si se encuentra un elemento en la misma columna diferente de cero se asigna
                % el número de la fila a la variable row y se detiene el bucle.
                if matrix(b, a) ~= 0;
                    row = b;
                    break;
                end
            end

            % Si al finalizar el bucle anterior no se encontró un elemento diferente de cero
            % se retorna un error dado que la matriz ingresada no es singular y por lo tanto
            % no se puede factorizar. En caso contrario se intercambian las filas.
            if row == 0;
                error("\nLa matriz ingresada es singular, no se puede factorizar.\n");
            else
                for b = 1 : size(matrix, 2);
                    temp = matrix(a, b);
                    matrix(a, b) = matrix(row, b);
                    matrix(row, b) = temp;    
                end
            end
        end

        % Bucle para dividir cada uno de los elementos de la columna por el pivote.
        for b = a + 1 : size(matrix, 1);
            matrix(b, a) = matrix(b, a) / matrix(a, a);
        end

        % Bucle para realizar la reducción gauss-jordan sumandole a la file b un multiplo
        % de la fila a.
        for b = a + 1 : size(matrix, 1);
            for c = a + 1 : size(matrix, 2) - 1;
                matrix(b, c) = matrix(b, c) - matrix(b, a) * matrix(a, c);
            end
        end
    end
end