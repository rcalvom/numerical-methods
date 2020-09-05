function c = BiseccionBolzano(f, a, b, delta)
    while abs(b - a) >= delta
        c = a + (b - a)/2;
        if f(c) == 0
            break;
        elseif sign(f(a)) ~= sign(f(c))
            b = c;
        elseif sign(f(c)) ~= sign(f(b))
            a = c;
        end
    end
end