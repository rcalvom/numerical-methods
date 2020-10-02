function P = LagrangeInterpolation(f, a, b, g)
    n = g;
    for k = 0 : n;
        X(k + 1, 1) = a + k * (b - a)/n ;
        X(k + 1, 2) = f(X(k + 1, 1));
    end
    P = LagrangeInterpolationX(X, g);
end

function P = LagrangeInterpolationX(X, g)
    P = 0;
    n = g + 1;
    for k = 1 : n;
        P = P + X(k, 2) .* LagrangeCoefficientPolynomial(X, n, k);
    end
end