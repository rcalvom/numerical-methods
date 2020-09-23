% Se solicita al usuario la matriz A que representa el sistema de ecuaciones lineales a resolver
A = input(newline + "Ingresa la matriz A que representa el sistema de ecuaciones lineales a resolver: ");

% Se solicita al usuario el vector columna B con los términos independientes de cada ecuación
B = input("Ingresa el vector B que representa los términos independientes de cada ecuación: ");

% Se calcula la factorización LU haciendo uso de la función "TriangularFactoring" que recibe como
% parámetros la matriz A y el vector columna B
LU = TriangularFactoring(A, B);

% Se obtiene B y LU de la matriz aumentada
B = LU(1 : size(LU, 1), size(LU, 2));
LU = LU(1 : size(LU, 1), 1 : size(LU, 2) - 1);

% Se obtiene la matriz triangular inferior L a partir de la matriz LU
L = eye(size(LU, 1));

for a = 2 : size(L, 1);
    for b = 1 : a - 1
        L(a, b) = LU(a, b);
    end
end

% Se obtiene la matriz triangular superior U a partir de la matriz LU
U = zeros(size(LU, 1));

for a = 1 : size(U, 1);
    for b = a : size(U, 1);
        U(a, b) = LU(a, b);
    end
end

% Se muestra en pantalla la factorización LU de la matriz A
disp(newline + "La factorización de la matriz A en LU es la siguiente: " + newline);

L
U

% Se calculan los valores de los vectores Y y X usando el método de la factorización triangular.
Y = LowerSolver(L, B);
X = UpperSolver(U, Y);

% Se muestra en pantalla la solución al sistema de ecuaciones LY = B
disp(newline + "La solución al sistema de ecuaciones LY = B es:" + newline);

Y

% Se muestra en pantalla la solución al sistema de ecuaciones UX = Y
disp(newline + "Finalmente, la solución al sistema de ecuaciones UX = Y es:" + newline);

X