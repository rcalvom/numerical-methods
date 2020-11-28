% Se establece el formato de impresión como long
format long

% Se solicita al usuario la función f(x)
func = input("Ingrese la función f(x): ", "s");
f = inline(func, "x");

% Se solicita al usuario el intervalo [a, b]
a = input("Ingrese el límite inferior del intervalo: ");
b = input("Ingrese el límite superior del intervalo: ");

% Se solicita al usuario el número de nodos N
M = (input("Ingrese el número de nodos: ") - 1)/2;

% Se calcula el valor de h correspondiente al espacio entre los x_k
h = (b - a) / (2 * M);

% El valor S almacenará el valor de la aproximación de la integral
% evaluada en el intervalo [a, b]. Se añade el primer término de la
% aproximación.
S = (h / 3) * (f(a) + f(b));

% Variable que almacenará el resultado de la primera sumatoria
one = 0;

% Bucle para calcular los términos de la primera sumatoria
for k = 1 : M - 1
    x_2k = a + 2 * k * h;
    one = one + f(x_2k);
end

% Se multiplica el resultado acumulado de la primera sumatoria
% por (2 * h) / 3
one = ((2 * h) / 3) * one;

% Se suma el resultado de la primera sumatoria a S
S = S + one;

% Variable que almacenará el resultado de la segunda sumatoria
two = 0;

% Bucle para calcular los términos de la segunda sumatoria
for k = 1 : M
    x_2km1 = a + (2 * k - 1) * h;
    two = two + f(x_2km1);
end

% Se multiplica el resultado acumulado de la segunda sumatoria
% por (4 * h) / 3
two = ((4 * h) / 3) * two;

% Se suma el resultado de la segunda sumatoria a S
S = S + two;

% Se muestra en consola el resultado obtenido de la aproximación
disp(newline + "La aproximación de la integral desde " + num2str(a) + " hasta " + num2str(b) + " de la funcion " + func + " es: "); S