%Se define la variable simbólica x
syms x;

%Se solicita el conjunto de puntos (x, f(x))
XY = input(newline + "Ingrese el conjunto de puntos (x, f(x)): ");
%Se obtiene el valor de la coordenada x de cada punto
X = XY(:, 1);
%Se obtiene el valor de la coordenada y de cada punto
Y = XY(:, 2);

%Se solicita el grado del polinomio que se quiere calcular
M = input(newline + "Ingrese el grado del polinomio: ");

%Se llama a la funcion que calcula los coeficientes del polinomio dadas las
%coordenadas x y y de los puntos y un grado del polinomio
C = PolynomialRegression(X, Y, M);

%Se contruye el polinomio según los coeficientes dados
polynomial = ConstructPolynomial(C);

%Se imprime el polinio obtenido
disp(newline + "El polinomio obtenido es: " + newline);
disp(polynomial);

%Se contruye la funcion del polinomio
f = inline(polynomial, "x");

%Se pregunta al ususario si desea ver la gráfica de la reacta obtenida,
%Sigue preguntando mientras la opcion ingresada no sea válida
while true
    option = input(newline + "¿Desea ver la gráfica de la función f(x)? (y/n): ", 's');
    if strcmp(option, 'y') || strcmp(option, 'n')
        break;
    else
        disp("Por favor ingrese la letra ""y"" en caso de que desee ver la gráfica, en caso contrario digite ""n"".");
    end
end

%Verifica la respuesta del usuario
if option == 'y';
    %Se calculan la cantidad de puntos que fueron ingresados
    n = length(X);
    %Se grafican los puntos que fueron ingresados
    for index = 1 : n
        x = X(index);
        y = Y(index);
        scatter(x, y, 25, 'black', 'filled');
        hold on;
    end

    %Grafica los ejes
    xline(0);
    yline(0);

    %Discretiza los valores de x para graficar el polinomio
    interval = abs(max(X) * 2) * -1 : 0.01 : abs(max(X) * 2);
    p = plot(interval, f(interval), '-b');

    hold off;

    %Se le agrega la información del plot
    title('Gráfica de los puntos y el polinomio');
    legend([p], {"Polinomio f(x)"})
    xlabel('x');
    ylabel('y');
    grid;
end