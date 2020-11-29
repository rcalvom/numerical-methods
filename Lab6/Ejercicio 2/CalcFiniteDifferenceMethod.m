equation = input("Ingrese la ecuación que representa el problema de contorno: ", "s");

a = input("Ingrese el límite inferior del intervalo ""a"": ");
x_a = input("Ingrese el valor de x(a): ");

b = input("Ingrese el límite superior del intervalo ""b"": ");
x_b = input("Ingrese el valor de x(b): ");

N = input("Ingrese el número de subintervalos ""N"": ");

known = false;

while true
    option = input('¿Conoce la función x(t)? (y/n): ', 's');
    if strcmp(option, 'y') || strcmp(option, 'n')
        break;
    else
        disp("Por favor ingrese la letra ""y"" en caso de que desee ver la gráfica, en caso contrario digite ""n""." + newline);
    end
end

if option == "y"
    known = true;
    func = input("Ingrese x(t): ", "s");
    f = inline(func, "t");
end

disp(newline + "La aproximación obtenida se representa con el siguiente conjunto de parejas {t, x}:" + newline);

occ = strfind(equation, "x");
p = inline(char(extractBetween(equation, 1, occ(1) - 2)), "t");
q = inline(char(extractBetween(equation, occ(1) + 5, occ(2) - 2)), "t");
r = inline(char(extractBetween(equation, occ(2) + 5, strlength(equation))), "t");

F = FiniteDifferenceMethod(p, q, r, a, b, x_a, x_b, N);
X = F{:, 1};
Y = F{:, 2};

if known
    E = zeros(N + 1, 1);
    for index = 1 : N
        E(index, 1) = f(X(index)) - Y(index);
    end
    E(N + 1, 1) = 0;
    F.e_j = E;
end

disp(F);

while true
    option = input('¿Desea ver la gráfica de la aproximación? (y/n): ', 's');
    if strcmp(option, 'y') || strcmp(option, 'n')
        break;
    else
        disp("Por favor ingrese la letra ""y"" en caso de que desee ver la gráfica, en caso contrario digite ""n""." + newline);
    end
end

if option == "y"
    p1 = plot(X, Y);
    xlabel('t');
    ylabel('x');
    title('Gráfica de la aproximación');
    xline(0);
    yline(0);
    if known
        hold on;
        Y2 = f(X);
        p2 = plot(X, Y2);
        legend([p1 p2], {'Aproximación', 'Función f(x)'});
        hold off;
    else
        legend([p1], {'Aproximación'});
    end
    grid;
end