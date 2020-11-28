function F = RungeKutta4(f, h, t_0, y_0)
    syms t;
    syms y;
    sympref('FloatingPointOutput', true);
    y_k = y_0;
    t_k = t_0;
    for a = 1 : 20;
        f1 = f(t_k, y_k);
        f2 = f(t_k + h/2, y_k + h/2 * f1);
        f3 = f(t_k + h/2, y_k + h/2 * f2);
        f4 = f(t_k + h, y_k + h * f3);

        y_k = y_k + h*(f1 + 2*f2 + 2*f3 + f4)/6;
        t_k = t_k + h;
        disp(t_k);
        disp(y_k);
        disp("----------------");

    end
    % Falta tabla

end