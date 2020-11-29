function F = DifferentialEcuation2(f, t_0, x_0, y_0, M, t_f)
    % Esta función calcula una aproximación numérica a la solución de la
    % ecuación diferencial f'' (como el parámetro f), usando t_0 como 
    % t inicial, x_0 como x inicial y y_0 como y inicial; también se 
    % utilizarán M subintervalos en el intervalo [t_0, t_f].

    % Se declaran las variables simbolicas t, x, y.
    syms t x y;

    % Se crea la función g como g(t, x , y) = y.
    g(t, x , y) = y;

    % Se convierte el problema de segundo orden como un sistema de dos ecuaciones
    % diferenciales de primer orden.
    T = DifferentialEcuationSystem(g, f, t_0, x_0, y_0, M, t_f);

    % Se da como resultado la segunda columna (x_k).
    F = T(:, 2)';
end