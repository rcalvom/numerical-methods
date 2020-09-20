A = input(newline + "Ingresa la matriz A que representa el sistema de ecuaciones lineales a resolver: ");
B = input("Ingresa el vector B que representa los términos independientes de cada ecuación: ");

P0 = input("Ingresa las aproximación inicial: ");

X = Jacobi(A, B, P0);
disp(X);