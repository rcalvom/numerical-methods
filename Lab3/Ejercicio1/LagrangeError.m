function E = LagrangeError(f, X, g)
    % La siguiente función implementa el calculo de error de Lagrange.
    % Parámetros: conjunto de puntos X, grado n, número de iteración k.
    % Resultado: valor del error obtenido.
    syms x;
    E = 1;
    n = g + 1;
    for m = 1 : n;
        E = E .* (x - X(m, 1));
    end
    df = inline(diff(f(x), n));
    c = -inf;
    for m = 1 : size(X, 1);
        if df(X(m, 1)) > c;
            c = df(X(m, 1));
        end
    end
    E = E * df(c);
    E = E / factorial(n);
end