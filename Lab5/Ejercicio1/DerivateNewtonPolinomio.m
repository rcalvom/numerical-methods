function polinomio = DerivateNewtonPolinomio(X)
    % Esta función se encarga de recibir un conjunto de puntos (x, y) y con
    % Estos calcular la derivada de la interpolación polinomial de Newton.

    % Se define x como variable simbolica.
    syms x;

    % Se crea una matriz de ceros donde se va a almacenar los resultados de las diferencias divididas.
    values = zeros(size(X, 1), size(X, 1) + 1);

    % Se llenan las dos primeras columnas de las diferencias divididas.
    for a = 1 : size(X, 1);
        values(a, 1) = X(a, 1);
        values(a, 2) = X(a, 2);
    end

    % Se termina de llenar la tabla de diferencias divididas.
    for a = 2 : size(X, 1);
        for b = 3 : size(X, 1) + 1;
            if b <= a + 1;
                values(a, b) = (values(a, b - 1) - values(a - 1, b -1))/(values(a, 1) - values(a - b + 2, 1));
            end
        end
    end

    % Se define la variable que retornará el polinomio derivada.
    polinomio = 0;

    % Se construye adecuadamente el polinomio derivada usando la información de las diferencias divididas.
    for a = 1 : size(X, 1) - 2;
        a_k = values(a + 1, a + 2);
        s = 0;
        for b = 1 : a;
            product = 1;
            for c = 1 : a;
                if b ~= c;
                    product = product * (x - values(c, 1));
                end
            end
            s = s + product;
        end
        polinomio = polinomio + (a_k * s);
    end
    
end