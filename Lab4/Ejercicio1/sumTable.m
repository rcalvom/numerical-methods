function table = sumTable(X)
    %Definición de los nombres de las columnas de la tabla
    names = {'xk', 'yk', 'x^2', 'xy'};
    
    %Definición de una matriz con ceros para almacenar los valores
    %obtenidos
    values = zeros(size(X, 1)+1, 4);
    
    %Ciclo for para llenar la matriz values con los valores
    %correspondientes
    for a = 1 : size(X, 1)
        values(a, 1) = X(a, 1);
        values(a, 2) = X(a, 2);
        values(a, 3) = X(a, 1)^2;
        values(a, 4) = X(a, 1) * X(a, 2);
    end
    
    %Ciclos for para calcular la suma de toda una columna y almacenarla en
    %la última fila de la tabla
    for a = 1 : size(values, 2)
        s = 0;
        for b = 1 : size(X, 1)
            s = s + values(b, a);
        end
        values(size(X, 1) + 1, a) = s;
    end
    
    %Construye la tabla con los valores obtenidos y el arreglo de nombres
    %definidos inicialmente
    table = array2table(values, 'VariableNames', names);
end