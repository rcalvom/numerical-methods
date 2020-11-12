% Se define x como variable simbólica.
syms x;

% Se solicita al usuario un conjunto de puntos o una función como punto de partida.
f = input(newline + "Ingrese la función f(x) o el conjunto ordenado de puntos (x, f(x)) a evaluar: ");
x_0 = input("Ingrese el valor x_0 donde desea evaluar f'(x_0): ");

if class(f) == "sym";
    isfunction = true;
    a = input("Ingrese el valor de a del intervalo [a, b] donde se realizará la aproximación: ");
    b = input("Ingrese el valor de b del intervalo [a, b] donde se realizará la interpolación aproximación: ");
    g = input("Indique la cantidad de puntos equidistantes que se tomarán en cuenta en la aproximación: ");
    f = inline(f);
    for k = 0 : g;
        X(k + 1, 1) = a + k * (b - a)/g ;
        X(k + 1, 2) = f(X(k + 1, 1));
    end
else
    isfunction = false;
    X = f;
    a = X(1, 1);
    b = X(size(X, 1), 1);
    g = size(X, 1) - 1;
end

disp(newline + "La función derivada simplificada del polinomio interpolador de Newton del conjunto de puntos dado es: ");

% Se calcula la derivada de la interpolación polinómica de Newton.
dP = inline(DerivateNewtonPolinomio(X));
y_0 = dP(x_0);
dP = vpa(expand(dP(x)));
disp(newline + "P'(x) = ");
disp(dP);

% Se evalua la función derivada en el punto x_0.
disp(newline + "Por lo tanto, el valor de P'(x_0) es: ");
disp(newline + "P'(x_0) = " + num2str(y_0));

% Se pregunta si se desea visualizar ls gráficas.
while true
    option = input(newline + "¿Desea ver las gráficas del método? (y/n): ", 's');
    if strcmp(option, 'y') || strcmp(option, 'n');
        break;
    else;
        disp("Por favor ingrese la letra ""y"" en caso de que desee ver la gráfica, en caso contrario digite ""n""." + newline);
    end
end

% En caso que si se desee ver las gráficas, se calculan todos los putnos necesarios.
if option == 'y';
    vx_0 = linspace(a - (b - a)/2, b + (b - a)/2);

    vx_1 = (X(1 : size(X, 1), 1))';
    vy_1 = (X(1 : size(X, 1), 2))';
    p_1 = scatter(vx_1, vy_1, 25, 'black', 'filled');

    hold on;

    if isfunction;
        vy_0 = f(vx_0);
        p_0 = plot(vx_0, vy_0);   
        y(x) = y_0 * x - x_0 * y_0 + f(x_0);

        scatter(x_0, f(x_0), 25, 'black', 'filled');
    else
        P = inline(LagrangeInterpolation(X, g));
        vy_0 = P(vx_0);
        p_0 = plot(vx_0, vy_0);
        y(x) = y_0 * x - x_0 * y_0 + P(x_0);

        scatter(x_0, P(x_0), 25, 'black', 'filled');
    end

    vy_2 = y(vx_0);
    p_2 = plot(vx_0, vy_2);

    if isfunction;
        title('Gráfica de la función con su recta tangente en x_0');
    else
        title('Gráfica de la interpolación con su recta tangente en x_0');
    end

    xline(0);
    yline(0);

    hold off;
    
    xlabel('x');
    ylabel('y');
    grid;

end

 