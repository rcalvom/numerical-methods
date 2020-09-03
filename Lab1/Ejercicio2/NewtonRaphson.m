function y = NewtonRaphson(f, p_0, delta)
    df = diff(f);
    f = inline(f);
    df = inline(df);
    y = p_0;
    while(abs(f(y)) > delta)
        y = y - f(y)/df(y);
    end
end