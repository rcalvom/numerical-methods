function table = NewtonRaphson(f, p_0, delta)
    names = {'k', 'pk', 'pk+1 - pk', 'f(pk)'};
    values = [];
    i = 1;
    df = diff(f);
    f = inline(f);
    df = inline(df);
    p_k = p_0;
    while(abs(f(p_k)) > delta)
        p_km1 = p_k;
        p_k = p_k - f(p_k)/df(p_k);
        values(i, 1) = i - 1;
        values(i, 2) = p_km1;
        values(i, 3) = p_k - p_km1;
        values(i, 4) = f(p_km1);
        i = i + 1;
    end
    table = array2table(values, 'VariableNames', names);
end