function polynomial = ConstructPolynomial(C)
    %Se calcula la cantidad de coeficientes obtenidos
    n = length(C);
    %Variable para almacenar el polinomio que se obtiene
    polynomial = "";
    %Construye el polinomio según los coeficientes dados
    for index = n - 1 : -1 : 1
        el = strcat(strcat(num2str(C(n - index)), ".*x.^"), num2str(index));
        if C(n - index) >= 0 && index ~= n - 1
            el = strcat("+", el);
        end
        polynomial = strcat(polynomial, el);
    end
    %Obtiene el término independiente
    last = num2str(C(n));
    
    %Si el termino independiente es no negativo concatena un + al polinomio
    %para poder concatenarlo 
    if C(n) >= 0
        last = strcat("+", last);
    end
    %Concatena el término independiente
    polynomial = strcat(polynomial, last);
end