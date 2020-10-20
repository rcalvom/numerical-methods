syms x;

sympref('FloatingPointOutput', true);

X_k = input(newline + "Ingrese el conjunto de puntos (x, f(x)) a evaluar: ");

disp(newline + "La tabla del procedimiento es la siguiente (Los valores de la última fila corresponden a la suma de los elementos de la columna): " + newline);

Table = sumTable(X_k);

disp(Table);

disp(newline + "Con la información anterior, la matriz aumentada del sistema de ecuaciones normales de Gauss es el siguiente: ");

A = [Table(height(Table), 3).Variables Table(height(Table), 1).Variables Table(height(Table), 4).Variables; Table(height(Table), 1).Variables size(X_k, 1) Table(height(Table), 2).Variables];

A

B = A(1 : size(A, 1), size(A, 2));
A = A(1 : size(A, 1), 1 : size(A, 2) - 1);

disp(newline + "Usando el método de solución de ecuaciones lineales por factorización triangular, el vector X que soluciona el sistema de ecuaciones es: ");

LU = TriangularFactoring(A, B);
B = LU(1 : size(LU, 1), size(LU, 2));
LU = LU(1 : size(LU, 1), 1 : size(LU, 2) - 1);
L = eye(size(LU, 1));
for a = 2 : size(L, 1);
    for b = 1 : a - 1
        L(a, b) = LU(a, b);
    end
end
U = zeros(size(LU, 1));
for a = 1 : size(U, 1);
    for b = a : size(U, 1);
        U(a, b) = LU(a, b);
    end
end
Y = LowerSolver(L, B);
X = UpperSolver(U, Y);

X

disp(newline + "Es así como se concluye que la recta y = ax+b que minimiza el error cuadrático medio del conjunto de puntos dado es: " + newline);

y = X(1, 1) * x + X(2, 1);
y = inline(y);
E = rootMeanSquareError(X_k, y);
y = vpa(expand(y(x)));

disp(y);

disp(newline + "El error cuadrático medio correspondiente es: " + newline);
disp(E);

while true
    option = input(newline + "¿Desea ver la gráfica de la función f(x)? (y/n): ", 's');
    if strcmp(option, 'y') || strcmp(option, 'n')
        break;
    else
        disp("Por favor ingrese la letra ""y"" en caso de que desee ver la gráfica, en caso contrario digite ""n""." + newline);
    end
end

if option == 'y';
    a = min(X_k(1 : size(X_k, 1), 1)');
    b = max(X_k(1 : size(X_k, 1), 1)');
    n = size(X_k, 1);
    x_0 = linspace(a - (b - a)/n, b + (b - a)/n);
    y = X(1, 1) * x + X(2, 1);
    y = inline(y);
    y_0 = y(x_0);

    p_0 = plot(x_0, y_0);

    hold on;

    x_1 = X_k(1 : size(X_k, 1), 1)';
    y_1 = X_k(1 : size(X_k, 1), 2)';
    p_1 = scatter(x_1, y_1, 25, 'black' ,'filled');

    xline(0);
    yline(0);

    hold off;

    title('Gráfica de los puntos y su regresión lineal.');
    legend([p_0 p_1], {'Regresión lineal', 'Datos'});

    xlabel('x');
    ylabel('y');
    grid;
end