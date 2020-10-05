function polinomio = PolinomioNewton(matriz, grado, pivote)
    % La siguiente función implementa el método del polinomio interpolador de Newton.
    % Parámetros: matriz con las abcsisas y ordenadas correspondientes a las parejas
    % (x, y) que se conocen de la función a aproximar.
    % Resultado: retorna una cadena de caracteres correspondiente al polinomio que se
    % obtuvo al aplicar el método.
    
    % Variable que almacenará el número de parejas (x, y) en la matriz de entrada.
    n = size(matriz, 1);

    % Tabla de diferencias divididas correspondientes a y = f(x).
    values = zeros(n, n);

    % En el siguiente bucle se calculan cada una de las diferencias divididas.
    for col = 1 : n
        for row = 1 : n
            if col <= row
                if col == 1
                    values(row, col) = matriz(row, 2);
                else
                    values(row, col) = (values(row, col - 1) - values(row - 1, col - 1));
                end
            end
        end
    end

    % Variable que almacenará el polinomio resultante.
    polinomio = "";

    % Se almacena el primer valor del polinomio, el cual corresponde a la primera
    % x de la matriz recibida por parámetro.
     polinomio = strcat(polinomio, num2str(matriz(pivote, 2)));

    % En el siguiente bucle se suma al polinomio cada uno de los términos correspondientes
    % a (s(s - 1)(s - 2)...(s - (n - 1)) / n!) * delta ^ n f[x_i].
    for i = 1 : 1 : grado

        % Variable que almacenará el término a_k.
        ak = values(i+pivote, i+1) / factorial(i);

        % Variable que almacenará la productoria de s(s - 1) ... s( - (n - 1)).
        productoria = "s";

        % Se calcula la productoria de los s.
        for k = 1 : i - 1
            productoria = strcat(productoria, ".*(s-", num2str(k), ")");
        end

        % Se suma el término obtenido al polinomio.
        polinomio = strcat(polinomio, "+", num2str(ak), "*", productoria);
    end
end