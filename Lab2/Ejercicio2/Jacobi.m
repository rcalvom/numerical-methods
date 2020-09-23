function X = Jacobi(A, B, P0, delta)
    % Almacena el tamaño de la matriz A
    s = size(A, 1);
    % Matriz con los elementos en la diagonal de A
    D = zeros(s, s);
    % Matriz con los inversos aditivos de los elementos en la TS de A
    L = zeros(s, s);
    % Matriz con los inversos aditivos de los elementos en la TI de A
    U = zeros(s, s);
    
    % Itera sobre cada valor de la matriz A y los guarda en las matrices D,
    % L o U según corresponda
    for i = 1:s
        for j = 1:s
            if i == j
                D(i,j) = A(i,j);
            elseif i > j
                U(i,j) = -A(i,j);
            else
                L(i,j) = -A(i,j);
            end
        end
    end
    
    % Registro de la operacion (D^-1)*B
    DB = (D^-1)*B;
    % Registro de la operacion (D^-1)*(L+U)
    DLU = (D^-1)*(L+U);
    
    % Vector que almacena los resultado en la k-ésima iteración
    XK = P0;
    % Matriz que almacena los resultados obtenidos en cada iteracion
    X = zeros(1, s+1);
    
    % Asigna los valores a X para la iteración en k=0
    X(1, 1) = 0;
    for j = 1:s
        X(1, j+1) = XK(j, 1);
    end
    
    % Parte iterativa del metodo
    % Condiciones de parada:
    % Cuando el contador i alcance el valor de 100
    % Cuando la distancia euclidiana entre el vector XK1 y XK sea menor que
    % delta
    for i = 2 : 100
        % Vector que almacena los resultado en la iteración k+1
        XK1 = DB + (DLU*XK);
        
        % Asigna los valores a X para la iteración k
        X(i, 1) = i-1;
        for j = 1:s
            X(i, j+1) = XK1(j, 1);
        end
        
        % Calcula la distancia euclidiana y compara para detener el metodo
        if EuclideanDistance(XK1, XK) < delta
            break;
        end
        % Actualiza el vector XK
        XK = XK1;
    end
    
    % Vector con los nombres de la tabla
    names = ["K" "X_K" "Y_K" "Z_K"];
    % Forma la tabla y devuelve el resultado
    X = array2table(X, 'VariableNames', names);
end