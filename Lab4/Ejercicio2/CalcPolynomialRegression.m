syms x;

XY = input(newline + "Ingrese el conjunto de puntos (x, f(x)): ");
X = XY(:, 1);
Y = XY(:, 2);

M = input(newline + "Ingrese el grado del polinomio: ");

C = PolynomialRegression(X, Y, M);

polynomial = ConstructPolynomial(C);

disp(newline + "El polinomio obtenido es: " + newline);
disp(polynomial);

f = inline(polynomial, "x");

while true
    option = input(newline + "¿Desea ver la gráfica de la función f(x)? (y/n): ", 's');
    if strcmp(option, 'y') || strcmp(option, 'n')
        break;
    else
        disp("Por favor ingrese la letra ""y"" en caso de que desee ver la gráfica, en caso contrario digite ""n"".");
    end
end

if option == 'y';
    n = length(X);
    for index = 1 : n
        x = X(index);
        y = Y(index);
        scatter(x, y, 25, 'black', 'filled');
        hold on;
    end

    xline(0);
    yline(0);

    interval = abs(max(X) * 2) * -1 : 0.01 : abs(max(X) * 2);
    p = plot(interval, f(interval), '-b');

    hold off;

    title('Gráfica de los puntos y el polinomio');
    legend([p], {"Polinomio f(x)"})
    xlabel('x');
    ylabel('y');
    grid;
end