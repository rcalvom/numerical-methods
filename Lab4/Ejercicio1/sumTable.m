function table = sumTable(X)
    names = {'xk', 'yk', 'x^2', 'xy'};
    values = [];
    for a = 1 : size(X, 1);
        values(a, 1) = X(a, 1);
        values(a, 2) = X(a, 2);
        values(a, 3) = X(a, 1)^2;
        values(a, 4) = X(a, 1) * X(a, 2);
    end
    for a = 1 : size(values, 2);
        s = 0;
        for b = 1 : size(X, 1);
            s = s + values(b, a);
        end
        values(size(X, 1) + 1, a) = s;
    end
    table = array2table(values, 'VariableNames', names);
end