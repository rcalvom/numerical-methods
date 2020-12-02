equation = input("Ingrese la ecuación que representa el problema de contorno: ", "s");

% Se solicita el limite inferior del intervalo y su imagen
a = input("Ingrese el límite inferior del intervalo ""a"": ");
x_a = input("Ingrese el valor de x(a): ");

% Se solicita el limite superior del intervalo y su imagen
b = input("Ingrese el límite superior del intervalo ""b"": ");
x_b = input("Ingrese el valor de x(b): ");

% Se solicita el número de iteraciones
I = input("Ingrese el número de iteraciones que desea realizar: ");

% Se solicitan los valores de los subintervalos
N = input("Ingrese el vector de subintervalos ""N"" correspondiente: ");

% Se verifica que la cantidad de subintervalos sea igual al número de
% interaciones que se van a realizar
if I ~= size(N, 2)
    error("El tamaño del vector de subintervalos no corresponde con el número de iteraciones ingresado");
end

known = false;

% Se pregunta si se conoce la función x(t) y se repite el ciclo mientras no
% se ingrese una opción válida ('y' o 'n')
while true
    option = input('¿Conoce la función x(t)? (y/n): ', 's');
    if strcmp(option, 'y') || strcmp(option, 'n')
        break;
    else
        disp("Por favor ingrese la letra ""y"" en caso de que conozca la función, en caso contrario digite ""n""." + newline);
    end
end

% Si la opción anterior fue 'y' se solicita la función x(t)
if option == "y"
    known = true;
    func = input("Ingrese x(t): ", "s");
    f = inline(func, "t");
end

% Se obtiene un vector de ocurrencias con las posiciones donde aparece x
occ = strfind(equation, "x");
% Se obtiene p(t)
p = inline(char(extractBetween(equation, 1, occ(1) - 2)), "t");
% Se obtiene q(t)
q = inline(char(extractBetween(equation, occ(1) + 5, occ(2) - 2)), "t");
% Se obtiene r(t)
r = inline(char(extractBetween(equation, occ(2) + 5, strlength(equation))), "t");

% Se crean los nombres que va a tener la tabla
names = {'t_j', strcat('x_j1, h = ', num2str((b - a) / N(1)))};
% Se calcula la aproximación para el primer h
F = FiniteDifferenceMethod(p, q, r, a, b, x_a, x_b, N(1));

% Se crea la tabla con los valores obtenidos en F y los nombres dados en 
% names
aprox_table = array2table(F, 'VariableNames', names);

% Se obtiene la primera columna de la matriz F
X = F(:, 1);
% Se obtiene la segunda columna de la matriz F
Y = F(:, 2);

% Si se conoce la funcion x(t)
if known
    % Se crea un vector columna para guardar los valores exactos de f(x(t))
    exact_column = zeros(N(1) + 1, 1);
    % Se llena el vector exact_column
    for index = 1 : N(1) + 1
        exact_column(index) = f(X(index));
    end
    % Se crean los nombres de las columnas de la tabla de error
    names = {'t_j', 'e_j1'};
    % Se crea una matriz para almacenar los valores del error
    E = zeros(N(1) + 1, 2);
    % Se llena la matriz
    for index = 1 : N(1)
        E(index, 1) = X(index);
        E(index, 2) = f(X(index)) - Y(index);
    end
    E(N(1) + 1, 1) = b;
    E(N(1) + 1, 2) = 0;
    % Se crea la tabla de error
    error_table = array2table(E, 'VariableNames', names);
end

% Se agragan columnas a la tabla de aproximaciones
for index1 = 2 : I
    % Se define el nombre de la columna según el indice y el tamaño del
    % intervalo
    name = strcat('x_j', num2str(index1), ', h = ', num2str((b - a) / N(index1)));
    % Se calcula la aproximación para los hi dados
    F = FiniteDifferenceMethod(p, q, r, a, b, x_a, x_b, N(index1));
    
    % Se crea el vector columna y se llena con los valores obtenidos en F
    new_column = zeros(N(1) + 1, 1);
    it = 1;
    for index2 = 1 : 2 ^ (index1 - 1) : size(F, 1)
        new_column(it) = F(index2, 2);
        it = it + 1;
    end
    % Se agrega la nueva columna a la tabla
    aprox_table.(name) = new_column;
    
    % Si conoce la funcion x(t) calcula el error respecto a la aproximacion
    % actual y lo agrega la nueva columna en la tabla de error
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

% Si se conoce la funcion x(t)
if known
    % Se agrega una nueva columna a la tabla con el nombre de name y los
    % valores de exact_column
    name = 'x_j exacto';
    aprox_table.(name) = exact_column;
end

% Se imprime la tabla con las aproximaciones obtenidas
disp(newline + "La siguiente tabla muestra la aproximación para diferentes valores de N:" + newline);
disp(aprox_table);

% Si se conoce la funcion x(t) se imprime la tabla con los errores
if known
    disp(newline + "La siguiente tabla muestra el error asociado para cada valor de N:" + newline);
    disp(error_table);
end

% Pregunta si quiere mostrar la grafica mientras no se ingrese una opcion
% valida ('y' o 'n')
while true
    option = input('¿Desea ver la gráfica de la aproximación? (y/n): ', 's');
    if strcmp(option, 'y') || strcmp(option, 'n')
        break;
    else
        disp("Por favor ingrese la letra ""y"" en caso de que desee ver la gráfica, en caso contrario digite ""n""." + newline);
    end
end

% Se muestra la grafica si en el ciclo anterior ingreso 'y'
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