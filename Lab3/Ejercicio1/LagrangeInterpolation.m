function P = LagrangeInterpolation(X, g)
    P = 0;
    n = g + 1;
    for k = 1 : n;
        P = P + X(k, 2) .* LagrangeCoefficientPolynomial(X, n, k);
    end
end