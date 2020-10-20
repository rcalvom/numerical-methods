function E = rootMeanSquareError(X, y)
    E = 0;
    for a = 1 : size(X, 1);
        E = E + abs(X(a, 2) - y(a))^2;
    end
    E = E / size(X, 1);
    E = sqrt(E);
end