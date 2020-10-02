syms x;
sympref('FloatingPointOutput', true);

f = inline(input(newline + "Ingrese la función f(x) a evaluar: "));
a = input("Ingrese el valor de a del intervalo [a, b] donde se realizará la interpolación: ");
b = input("Ingrese el valor de b del intervalo [a, b] donde se realizará la interpolación: ");
g = input("Indique el grado del polinomio resultante de la interpolación: ");
P = inline(LagrangeInterpolation(f, a, b, g));
P = vpa(expand(P(x)));

disp(newline + "El polinomio de grado " + g + " que aproxima a la función en el intervalo [" + a +", " + b + "] es: "+ newline);
disp("P(x) = ");
disp(P);

while 1
    option = input('¿Desea ver la gráfica de la función f(x)? (y/n): ', 's');
    if strcmp(option, 'y') || strcmp(option, 'n')
        break;
    else
        disp("Por favor ingrese la letra ""y"" en caso de que desee ver la gráfica, en caso contrario digite ""n""." + newline);
    end
end

if option == 'y';
    P = inline(P);
    x_0 = linspace(a - (b - a), b + (b - a));

    y_0 = f(x_0);
    p_0 = plot(x_0, y_0);

    hold on;

    y_1 = P(x_0);
    p_1 = plot(x_0, y_1);
    
    x_1 = a : (b - a) / g :b;
    y_2 = f(x_1);
    scatter(x_1, y_2, 25, 'black' ,'filled');

    xline(0);
    yline(0);

    hold off;

    xlabel('x');
    ylabel('y');
    title('Gráficas de la función y su interpolación polinómica.');
    
    legend([p_0 p_1], {'f(x)', 'Interpolación polinómica.'});
    grid;
end