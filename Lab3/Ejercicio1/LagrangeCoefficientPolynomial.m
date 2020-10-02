function  L = LagrangeCoefficientPolynomial(X, n, k)
    syms x;
    L = 1;
    for m = 1 : n;
        if m ~= k;
            L = L .* (x - X(m, 1));
            L = L ./ (X(k, 1) - X(m, 1));
        end
    end
end