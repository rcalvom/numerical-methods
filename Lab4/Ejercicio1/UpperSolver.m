function X = UpperSolver(U, Y)
    % La siguiente función calcula los valores del vector X en base a
    % los valores obtenidos de la función "LowerSolver", teniendo en
    % cuenta el planteamiento UX = Y.
    % Parámetros: Matriz triangular inferior U y vector Y con los valores
    % de cada uno de los Y_i.
    % Resultado: vector X con la solución del sistema.

    % Bucle que itera por cada una de las filas de la matriz de derecha
    % a izquierda.
    for a = size(Y, 1) : -1 : 1

        % Varible que contendrá el valor acumulado de cada uno de los
        % valores obtenidos en las filas.
        acc = 0;

        % Bucle que itera por cada uno de los elementos de la fila actual.
        for b = size(U, 2) : -1 : a + 1

            % Se actualiza el valor de la variable acumuladora añadiendo
            % el producto del elemento en U junto con el valor conocido
            % de X_i.
            acc = acc + U(a, b) * X(b, 1);
        end

        % Se calcula el valor de X_i por medio de los valores de Y_i y la
        % variable acumuladora.
        X(a, 1) = (Y(a, 1) - acc) / U(a, a);
    end  
end