function table = NewtonRaphson(f, p_0, delta)
    % La siguiente función implementa el método de Newton - Raphson.
    % Parámetros: función f(x), punto inicial p_0 y un valor delta
    % correspondiente a la distancia mínima que se busca respecto a
    % la raiz de la función f(x).
    % Resultado: retorna una tabla con los resultados obtenidos en cada
    % iteración, la última fila corresponderá al valor final de cada una
    % de las variables incluyendo el valor de x cuya imagen se aproxima
    % a 0.

    % Nombres de las columnas de la tabla resultante.
    names = {'k', 'pk', 'pk+1 - pk', 'f(pk)'};

    % Matriz con los valores resultantes de cada iteración.
    values = [];

    % Variable que almacenará el número de la iteración actual.
    i = 1;

    % Derivada de la función f(x).
    df = diff(f);

    % Función inline correspondiente a f(x).
    f = inline(f);

    % Función inline correspondiente a la derivada de f(x).
    df = inline(df);

    % Variable que almacenará el valor p_k.
    p_k = p_0;

    % El siguiente bucle calcula la raiz de la función f(x) que se
    % encuentra más cerca del punto inicial p_0.
    while(abs(f(p_k)) > delta)
        p_km1 = p_k;
        p_k = p_k - f(p_k)/df(p_k);
        values(i, 1) = i - 1;
        values(i, 2) = p_km1;
        values(i, 3) = p_k - p_km1;
        values(i, 4) = f(p_km1);
        i = i + 1;
    end

    % Una vez termina el algoritmo y los valores de cada iteración fueron
    % guardados en el arreglo "values" se utiliza la función "array2table"
    % con el fin de obtener una tabla con los nombres de las columnas
    % establecidos al inicio y cada uno de los valores obtenidos. 
    table = array2table(values, 'VariableNames', names);
end