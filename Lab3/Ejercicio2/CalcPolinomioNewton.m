% Se declara la variable simbólica s -> utilizada en la ecuación del polinomio
% interpolador de Newton obtenido de la función "PolinomioNewton".
syms s;

% Se solicita al usuario al matriz con cada una de las parejas (x, y) que
% representan los valores de las abscisas y ordenadas de la función original.
matriz = input("Ingrese la matriz con los valores x_i, y_i: ");

% Utilizado para poder obtener la forma irreducible de una expresión matemática.
sympref('FloatingPointOutput', true);

% Por medio del uso de la función "PolinomioNewton" pasando como parámetro la
% matriz de abscisas y ordenadas se obtiene el polinomio interpolador de grado
% n - 1 siendo n el número de parejas (x, y) de la matriz.
polinomio = PolinomioNewton(matriz);

% Se procede a simplificar el polinomio obtenido por medio de la función "expand".
polinomio = inline(polinomio, "s");
disp(expand(polinomio(s)));

% Se define la función s(x) como el cociente (x - x_1) / (x_2 - x).
s = inline( strcat("(x-", num2str(matriz(1, 1)), ")/", num2str(matriz(2,1) - matriz(1, 1))), "x");

% Intervalo de abscisas para la gráfica del polinomio interpolador.
x = matriz(1,1) : 0.01 : matriz(size(matriz, 1), 1);

% Se gráfica el polinomio interpolador de Newton.
plot(x, polinomio(s(x)), "-b"); xlabel("x"); ylabel("Pn(x)"); title("Polinomio interpolador de Newton"); hold on;

% Una vez obtenido el polinomio se le pregunta al usuario si desea conocer la
% aproximación de un x específico. En caso afirmativo se solicitará el punto x,
% se imprimirá en pantalla y se graficará.
while(1)
    option = input("¿Desea interpolar algun valor? (y/n): ", 's');
    if option == "y"
        plot(x, polinomio(s(x)), "-b"); xlabel("x"); ylabel("Pn(x)"); title("Polinomio interpolador de Newton"); hold on;
        xu = input("Ingrese el valor que desea interpolar: ");
        disp(strcat("Pn(", num2str(xu), ") = ", num2str(polinomio(s(xu)))));
        scatter(xu, polinomio(s(xu)), 25, 'black' ,'filled'); hold off;
    else
       break; 
    end
end