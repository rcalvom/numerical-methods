% Se declaran las variables simbólicas .
syms t x y;

disp(newline);

% Se piden los datos necesarios para solucionar el problema de contorno con el método del
% disparo lineal.

p = inline(str2sym(input("Ingrese la función p(t), la cuál multiplicará a x'(t) : ", 's')));
q = inline(str2sym(input("Ingrese la función q(t), la cuál multiplicará a x(t) : ", 's')));
r = inline(str2sym(input("Ingrese la función r(t), será independiente en x''(t) : ", 's')));

disp(newline);

disp("Su función ingresada es: ");

disp("x''(t) = (" + sym2str(p(t)) + ") * x'(t) + (" + sym2str(q(t)) + ") * x(t) + (" + sym2str(r(t)) + ")");

disp(newline);

a = input("Ingrese el limite inferior del intervalo [a, b]: ");
b = input("Ingrese el limite superior del intervalo [a, b]: ");

disp(newline);

alpha_v = input("Ingrese el valor de x(a): ");
beta_v = input("Ingrese el valor de x(b): ");

M = input("Ingrese la cantidad de subintervalos M en el intervalo [a, b]: ");

h = (b - a) / M;

disp(newline);
disp("Calculando...");
disp(newline);

% Se plantean u y v como ecuaciones diferenciales de segundo orden.
u(t, x , y) = p(t) * y + q(t) * x + r(t);
v(t, x , y) = p(t) * y + q(t) * x;

% Se Aproxima una solucion a estas ecuaciones diferenciales.
U = DifferentialEcuation2(u, a, alpha_v, 0, M, b);
V = DifferentialEcuation2(v, a, 0, 1, M, b);

% Se calcula el valor de W_j.
W = (beta_v - U(size(U, 2)))/(V(size(V, 2))) * V;

% Se concluye la aproximación de la solución al problema de contorno como X = U + W.
X = U + W;

% Se diseña la tabla donde se va a mostrar el conjunto de puntos.
names = {'k', 't_k', 'y_k'};

for cont = 0 : M;
    table(cont + 1 , 1) = cont; 
    table(cont + 1 , 2) = a + cont * h;
    table(cont + 1 , 3) = X(cont + 1);
end

table = array2table(table, 'VariableNames', names);


% Se muestra la tabla con el conjunto de puntos dados en la aproximación al problema de contorno.
disp("El conjunto de puntos obtenido como aproximación a la solución del problema de contorno dado es: " + newline);

disp(table);

% Se pregunta si se quiere ver la gráfica correspondiente.
while true;
    option = input('¿Desea ver la gráfica de la función f(x)? (y/n): ', 's');
    if strcmp(option, 'y') || strcmp(option, 'n')
        break;
    else
        disp("Por favor ingrese la letra ""y"" en caso de que desee ver la gráfica, en caso contrario digite ""n""." + newline);
    end
end

% En caso de si querer ver la gráfica, se diseña y se muestra.
if option == 'y';
    for cont = 0 : M;
        T(cont + 1) = a + cont * h;
    end

    p_1 = plot(T, X);

    hold on;

    p_2 = plot(T, U);
    p_3 = plot(T, W);

    xline(0);
    yline(0);

    hold off;

    title('Aproximaciones numéricas usadas para formar x(t) = u(t) + w(t)');
    legend([p_1 p_2 p_3], {'x(t)', 'u(t)', 'w(t)'});
    xlabel('t');
    ylabel('y');
    grid;

end


