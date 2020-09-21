A = input(newline + "Ingresa la matriz A que representa el sistema de ecuaciones lineales a resolver: ");
B = input("Ingresa el vector B que representa los términos independientes de cada ecuación: ");

LU = TriangularFactoring(A, B);
B = LU(1 : size(LU, 1), size(LU, 2));
LU = LU(1 : size(LU, 1), 1 : size(LU, 2) - 1);

disp(newline + "La factorización de la matriz A en LU representado en la misma matriz es la siguiente: " + newline);
disp(LU);

disp(newline + "Por lo tanto la solución al sistema de ecuaciones AX = B usando el método de factorización LU es:" + newline);

X = UpperSolver(LU, LowerSolver(LU, B));
disp(X);