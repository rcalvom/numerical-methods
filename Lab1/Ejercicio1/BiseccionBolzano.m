function table = BiseccionBolzano(f, a, b, delta)
    % La siguiente función implementa el método de bisección de Bolzano.
    % Parámetros: función f(x), límite inferior del intervalo (a),
    % límite superior del intervalo (b) y un valor delta correspondiente
    % a la distancia mínima que se busca respecto a la raiz de f(x).
    % Resultado: retorna una tabla con los resultados obtenidos en cada
    % iteración, la última fila correspondera al valor final de cada una
    % de las variables incluyendo el valor de x cuya imagen se aproxima a 0.

    % Nombres de las columnas de la tabla resultante.
    names = {'k', 'Extremo izquierdo (a)', 'Punto medio (c)', 'Extremo derecho (b)', 'Valor de la función f(c)'};

    % Matriz con los valores resultantes de cada iteración.
    values = [];

    % Variable que alamacenará el número de la iteración actual.
    i = 1;

    % El siguiente bucle calcula la raiz de la función en el intervalo [a, b],
    % en cada iteración se calcula el punto medio del intervalo denotado por c
    % realizando las siguientes comparaciones:
    % 1. Si f(c) = 0, entonces se detiene el bucle puesto que se ha encontrado
    % el valor de x que satisface f(x) = 0.
    % 2. Si el signo de f(a) y f(c) son diferentes entonces la raiz se encuentra
    % en el intervalo [a, c], por tanto se asigna a la variable b el valor de c.
    % 3. Si el signo de f(c) y f(b) son diferentes entonces la raiz se encuentra
    % en el intervalo [b, c], por tanto se asigna a la variable a el valor de c.
    % 4. Se incrementa en uno la variable que indica la iteración actual, es decir,
    % i pasa a ser i + 1.
    while abs(b - a) >= delta
        c = a + (b - a)/2;
        values(i, 1) = i-1;
        values(i, 2) = a;
        values(i, 3) = c;
        values(i, 4) = b;
        values(i, 5) = f(c);
        if f(c) == 0
            break;
        elseif sign(f(a)) ~= sign(f(c))
            b = c;
        elseif sign(f(c)) ~= sign(f(b))
            a = c;
        end
        i = i + 1;
    end

    % Una vez termina el algoritmo y los valores de cada iteración fueron guardados
    % en el arreglo "values" se utiliza la función "array2table" con el fin de obtener
    % una tabla con los nombres de las columnas establecidos al inicio y cada uno de
    % los valores obtenidos. 
    table = array2table(values, 'VariableNames', names);
end