function C = PolynomialRegression(X, Y, M)
    %Se almacena en n la cantidad de puntos
    n = length(X);
    %Se crea la matriz 4 inicialmente con ceros
    F = zeros(n, M + 1);

    %Se llena la matriz F
    for k = 1 : M + 1
        F(:, k) = X'.^(k - 1);
    end

    %Se contruye una matriz B para almacenar el resultado F' * F
    A = F' * F;
    %Se contruye una matriz B para almacenar el resultado F' * Y
    B = F' * Y;
    %Se encuentra el vector C tal que AC = B
    C = A \ B;
    %Se le da la vuelta al vector
    C = flipud(C);
end