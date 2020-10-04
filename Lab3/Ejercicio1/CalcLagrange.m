% Se declara la variable simbólica x.
syms x;

% Utilizado para poder obtener la forma irreducible de una expresión matemática.
sympref('FloatingPointOutput', true);

% Se solicita al usuario la función f(x) o  el conjunto de puntos (x, f(x)).
f = input(newline + "Ingrese la función f(x) o el conjunto de puntos (x, f(x)) a evaluar: ");

% Condicional para determinar si la entrada fue una función o un conjunto de puntos.
if class(f) == "sym";

    % En caso de que la entrada sea una función se solicitará el intervalo [a, b] en el cual
    % se realizará la interpolación.
    isfunction = true;
    a = input("Ingrese el valor de a del intervalo [a, b] donde se realizará la interpolación: ");
    b = input("Ingrese el valor de b del intervalo [a, b] donde se realizará la interpolación: ");
    g = input("Indique el grado del polinomio resultante de la interpolación: ");
    f = inline(f);
    for k = 0 : g;
        X(k + 1, 1) = a + k * (b - a)/g ;
        X(k + 1, 2) = f(X(k + 1, 1));
    end
else

    % En caso de que la entrada sea un conjunto de puntos se calcula el intervalo [a, b] buscando
    % el valor mínimo y máximo de los puntos suministrados.
    isfunction = false;
    X = f;
    a = min(X(1 : size(X, 1), 1)');
    b = max(X(1 : size(X, 1), 1)');
    g = size(X, 1) - 1;
end

% Se obtiene el polinomio interpolador de Lagrange por medio de la función "LagrangeInterpolation".
P = inline(LagrangeInterpolation(X, g));

% Se simplifica el polinomio obtenido por medio de la función "expand".
P = vpa(expand(P(x)));

% Se muestra en pantalla el polinomio obtenido como resultado de la aplicación del método.
disp(newline + "El polinomio de grado " + g + " que aproxima a la función en el intervalo [" + a +", " + b + "] es: "+ newline);
disp("P(x) = ");
disp(P);

% Bucle para determinar si el parámetro de entrada es una función.
if isfunction;
    % Se calcula la cota superior del error de la después de haber aplicado el método y 
    % se muestra en pantalla.
    E = inline(LagrangeError(f, X, g));
    E = vpa(expand(E(x)));
    disp(newline + "La cota superior del error de esta interpolación polinómica es: "+ newline);
    disp("E(x) = ");
    disp(E);
end

% Se pregunta al usuario si desea ver la gráfica del polinomio obtenido.
while true
    option = input(newline + "¿Desea ver la gráfica de la función f(x)? (y/n): ", 's');
    if strcmp(option, 'y') || strcmp(option, 'n')
        break;
    else
        disp("Por favor ingrese la letra ""y"" en caso de que desee ver la gráfica, en caso contrario digite ""n""." + newline);
    end
end

% Condicional para determinar si el usuario desea ver la gráfica.
if option == 'y';

    % Se calcula el valor x_0.
    x_0 = linspace(a - (b - a), b + (b - a));
    P = inline(P);
    if isfunction;    
        % En caso de que la entrada sea una función se muestra la gráfica de f(X) y
        % su interpolación polinómica.
        y_0 = f(x_0);
        p_0 = plot(x_0, y_0);

        hold on;

        y_1 = P(x_0);
        p_1 = plot(x_0, y_1);
        
        x_1 = a : (b - a) / g : b;
        y_2 = f(x_1);
        scatter(x_1, y_2, 25, 'black' ,'filled');

        xline(0);
        yline(0);

        hold off;
        
        title('Gráficas de la función y su interpolación polinómica.');
        legend([p_0 p_1], {'f(x)', 'Interpolación polinómica.'});
    else
        % En caso de que la entrada sea un conjunto de puntos se gráfica la
        % interpolación polinómica.
        hold on;

        y_1 = P(x_0);
        p_1 = plot(x_0, y_1);
        
        x_1 = a : (b - a) / g : b;
        y_2 = P(x_1);
        scatter(x_1, y_2, 25, 'black' ,'filled');

        xline(0);
        yline(0);

        hold off;

        title('Gráfica de la interpolación polinómica.');
        legend([p_1], {'Interpolación polinómica.'});
    end
    xlabel('x');
    ylabel('y');
    grid;
end