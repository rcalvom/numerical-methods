function Y = LowerSolver(L, B) 
    % La siguiente función calcula los valores del vector Y en base a
    % la matriz triangular inferior L y el vector columna de valores
    % independientes B.
    % Parámetros: matriz triangular inferior L y el vector columna de
    % términos independientes B.
    % Resultado: vector Y con el resultado del sistema LY = B.

    % Bucle para iterar por cada una de las filas de la matriz.
    for a = 1 : size(B, 1)

        % Varible que contendrá el valor acumulado de cada uno de los
        % valores obtenidos en las filas.
        acc = 0;

        % Bucle que itera por cada una de los elementos de la fila actual.
        for b = 1 : a - 1

            % Se actualiza el valor de la variable acumuladora añadiendo
            % el producto del elemento en L junto con el valor conocido
            % de Y_i.
            acc = acc + L(a, b) * Y(b, 1);
        end

        % Se añade el valor obtenido en el vector Y.
        Y(a, 1) = (B(a, 1) - acc);
    end    
end