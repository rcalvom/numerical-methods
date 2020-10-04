function tabla = myFun(matriz)
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
    h = matriz(2, 1) - matriz(1, 1);
    p = h;
    f = 1;
    s = 1;
    polinomio = "";
    polinomio = strcat(polinomio, num2str(matriz(1, 2)));
    for i = 2 : n
        s = s * (matriz(i, 1) - matriz(1, 1)) / h;
        f = f * i;
        
    end
end