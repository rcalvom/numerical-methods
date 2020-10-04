function polinomio = PolinomioNewton(matriz)
    n = size(matriz, 1);
    values = zeros(n, n);
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
    polinomio = "";
    polinomio = strcat(polinomio, num2str(matriz(1, 2)));
    for i = 1 : n - 1
        ak = values(i+1, i+1) / factorial(i);
        productoria = "s";
        for k = 1 : i-1
            productoria = strcat(productoria, ".*(s-", num2str(k), ")");
        end
        polinomio = strcat(polinomio, "+", num2str(ak), "*", productoria);
    end
end