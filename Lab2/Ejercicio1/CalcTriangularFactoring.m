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

% Se muestra en pantalla la factorización LU de la matriz A
disp(newline + "La factorización de la matriz A en LU representado en la misma matriz es la siguiente: " + newline);
disp(LU);

% Se muestra en pantalla la solución al sistema de ecuaciones AX = B
disp(newline + "Por lo tanto la solución al sistema de ecuaciones AX = B usando el método de factorización LU es:" + newline);

X = UpperSolver(LU, LowerSolver(LU, B));
disp(X);