equation = input("Ingrese la ecuación que representa el problema de contorno: ", "s");

a = input("Ingrese el límite inferior del intervalo ""a"": ");
x_a = input("Ingrese el valor de x(a): ");

b = input("Ingrese el límite superior del intervalo ""b"": ");
x_b = input("Ingrese el valor de x(b): ");

I = input("Ingrese el número de iteraciones que desea realizar: ");

N = input("Ingrese el vector de subintervalos ""N"" correspondiente: ");

if I ~= size(N, 2)
    error("El tamaño del vector de subintervalos no corresponde con el número de iteraciones ingresado");
end

known = false;

while true
    option = input('¿Conoce la función x(t)? (y/n): ', 's');
    if strcmp(option, 'y') || strcmp(option, 'n')
        break;
    else
        disp("Por favor ingrese la letra ""y"" en caso de que conozca la función, en caso contrario digite ""n""." + newline);
    end
end

if option == "y"
    known = true;
    func = input("Ingrese x(t): ", "s");
    f = inline(func, "t");
end

occ = strfind(equation, "x");
p = inline(char(extractBetween(equation, 1, occ(1) - 2)), "t");
q = inline(char(extractBetween(equation, occ(1) + 5, occ(2) - 2)), "t");
r = inline(char(extractBetween(equation, occ(2) + 5, strlength(equation))), "t");

names = {'t_j', strcat('x_j1, h = ', num2str((b - a) / N(1)))};
F = FiniteDifferenceMethod(p, q, r, a, b, x_a, x_b, N(1));
aprox_table = array2table(F, 'VariableNames', names);

X = F(:, 1);
Y = F(:, 2);

if known
    exact_column = zeros(N(1) + 1, 1);
    for index = 1 : N(1) + 1
        exact_column(index) = f(X(index));
    end
    names = {'t_j', 'e_j1'};
    E = zeros(N(1) + 1, 2);
    for index = 1 : N(1)
        E(index, 1) = X(index);
        E(index, 2) = f(X(index)) - Y(index);
    end
    E(N(1) + 1, 1) = b;
    E(N(1) + 1, 2) = 0;
    error_table = array2table(E, 'VariableNames', names);
end

for index1 = 2 : I
    name = strcat('x_j', num2str(index1), ', h = ', num2str((b - a) / N(index1)));
    F = FiniteDifferenceMethod(p, q, r, a, b, x_a, x_b, N(index1));
    new_column = zeros(N(1) + 1, 1);
    it = 1;
    for index2 = 1 : 2 ^ (index1 - 1) : size(F, 1)
        new_column(it) = F(index2, 2);
        it = it + 1;
    end
    aprox_table.(name) = new_column;
    if known
        name = strcat('e_j', num2str(index1));
        E = zeros(N(1) + 1, 1);
        it = 1;
        for index3 = 1 : 2 ^ (index1 - 1) : size(F, 1)
            if it == (N(1) + 1)
                break;
            end
            E(it) = f(X(it)) - F(index3, 2);
            it = it + 1;
        end
        E(N(1) + 1, 1) = 0;
        error_table.(name) = E;
    end
end

if known
    name = 'x_j exacto';
    aprox_table.(name) = exact_column;
end

disp(newline + "La siguiente tabla muestra la aproximación para diferentes valores de N:" + newline);
disp(aprox_table);

if known
    disp(newline + "La siguiente tabla muestra el error asociado para cada valor de N:" + newline);
    disp(error_table);
end

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
        legend([p1 p2], {'Aproximación', 'Función x(t)'});
        hold off;
    else
        legend([p1], {'Aproximación'});
    end
    grid;
end