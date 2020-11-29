function FG = DifferentialEcuationSystem(f, g, t_0, x_0, y_0, M, t_f)
    % La función calcula una aproximación numérica al sistema de ecuaciones
    % diferenciales df/dt (como el parámetro f) y dg/dt, (como el parámetro g)
    % teniendo en cuenta su t inicial (t_0) su x inicial (x_0) y su y inical
    % (y_0), Se utilizará el método de Runge-Kutta con M subintervalos dentro
    % del subintervalo [t_0, t_f].

    % Se declaran las variables simbólicas t, x, y;
    syms t x y;

    % Se calcula en incremento h de acuerdo al tamaño del intervalo y a la cantidad
    % de subintervalos.
    h = (t_f - t_0)/ M;

    % Se crea la correspondiente matriz FG donde se almacenarán los resultados, en
    % la primera colunma se almacenarán todos los t_k, en la segunda los x_k y en
    % la tercera, todos los y_k.
    FG = zeros(M + 1, 3);


    % Se inicializan las variables t_k, x_k y y_k, además se llena la fila 0 de la
    % matriz.
    t_k = t_0;
    x_k = x_0;
    y_k = y_0;
    FG(1, 1) = t_k;
    FG(1, 2) = x_k;
    FG(1, 3) = y_k;

    % Se itera por cada uno de los subintervalos, calculando los valores correspondientes
    % a f1, f2, f3, f4, g1, g2, g3, g4 y se colocan en la tabla.
    for a = 1 : M;
        f1 = f(t_k, x_k, y_k);
        g1 = g(t_k, x_k, y_k);

        f2 = f(t_k + h/2, x_k + h/2 * f1, y_k + h/2 * g1);
        g2 = g(t_k + h/2, x_k + h/2 * f1, y_k + h/2 * g1);

        f3 = f(t_k + h/2, x_k + h/2 * f2, y_k + h/2 * g2);
        g3 = g(t_k + h/2, x_k + h/2 * f2, y_k + h/2 * g2);

        f4 = f(t_k + h, x_k + h * f3, y_k + h * g3);
        g4 = g(t_k + h, x_k + h * f3, y_k + h * g3);

        t_k = t_k + h;
        x_k = x_k + h * (f1 + 2 * f2 + 2 * f3 + f4)/6;
        y_k = y_k + h * (g1 + 2 * g2 + 2 * g3 + g4)/6;

        FG(a + 1, 1) = t_k;
        FG(a + 1, 2) = x_k;
        FG(a + 1, 3) = y_k;

    end
    
end
