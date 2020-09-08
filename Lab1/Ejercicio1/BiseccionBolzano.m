function table = BiseccionBolzano(f, a, b, delta)
    names = {'k', 'Extremo izquierdo (a)', 'Punto medio (c)', 'Extremo derecho (b)', 'Valor de la función f(c)'};
    values = [];
    i = 1;
    while abs(b - a) >= delta
        c = a + (b - a)/2;
        values(i, 1) = i-1;
        values(i, 2) = a;
        values(i, 3) = c;
        values(i, 4) = b;
        values(i, 5) = f(c);
        if f(c) == 0
            break;
        elseif sign(f(a)) ~= sign(f(c))
            b = c;
        elseif sign(f(c)) ~= sign(f(b))
            a = c;
        end
        i = i + 1;
    end
    table = array2table(values, 'VariableNames', names);
end