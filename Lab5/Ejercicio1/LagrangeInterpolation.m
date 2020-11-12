function P = LagrangeInterpolation(X, g)
    % La siguiente función calcula el polinomio interpolador de
    % Lagrange por medio de un proceso iterativo y el uso de la
    % función "LagrangeCoefficientPolynomial".
    % Parámetros: conjunto de puntos X, grado g.
    % Resultado: se retorna el polinomio obtenido.
    P = 0;
    n = g + 1;
    for k = 1 : n;
        P = P + X(k, 2) .* LagrangeCoefficientPolynomial(X, n, k);
    end
end