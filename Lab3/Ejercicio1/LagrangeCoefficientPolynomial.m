function  L = LagrangeCoefficientPolynomial(X, n, k)
    % La siguiente función se utiliza para calcular los coeficientes
    % de cada uno de los términos del polinomio de Lagrange.
    % Parámetros: conjunto de puntos X, grado n, número de iteración k.
    syms x;
    L = 1;
    for m = 1 : n;
        if m ~= k;
            L = L .* (x - X(m, 1));
            L = L ./ (X(k, 1) - X(m, 1));
        end
    end
end