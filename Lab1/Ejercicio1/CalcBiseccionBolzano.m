% Variable simbólica x.
syms x;

% Función ingresada por el usuario.
f = inline(input(newline + "Ingresa una función en terminos de x: "));

% Valor de tolerancia delta.
delta = input("Ingresa un valor de tolerancia delta: ");

% Se solicita al usuario el intervalo inicial [a, b], en caso de que
% f(a) y f(b) tengan el mismo signo o alguno de los dos límites sea
% una raiz de la función se solicitan de nuevo los datos hasta que
% estos cumplan con los requerimientos establecidos.
while 1   
    a = input("Ingrese un límite inferior del intervalo: ");
    b = input("Ingrese un límite superior del intervalo: ");
    if sign(f(a)) == sign(f(b)) | sign(f(a)) == 0 | sign(f(b)) == 0
        disp(newline + "Los intervalos no son validos, por favor ingreselos nuevamente." + newline);
    else
        break;
    end
end

% Se calcula la raiz de la función en [a, b] por medio del método
% "BiseccionBolzano" usando los parámetros ingresados por el usuario.
root = BiseccionBolzano(f, a, b, delta);

% Se muestra en pantalla la tabla resultante y la aproximación de la
% raiz de la función en el intervalo [a, b] obtenido en la ejecución
% del método de bisección de Bolzano.
disp(newline + "La tabla generada en el método numérico es la siguiente: " + newline);
disp(root);
disp(newline + "La aproximación de la raíz de la función en el intervalo [" + num2str(a) + ", " + num2str(b) + "] es: x = " + num2str(root(height(root), 3).Variables) + newline);

% Se le pregunta el usuario si desea ver la gráfica de la función, con
% el fin de comprobar que realmente existe una raiz en el intervalo [a, b].
while 1
    option = input('¿Desea ver la gráfica de la función f(x)? (y/n): ', 's');
    if strcmp(option, 'y') || strcmp(option, 'n')
        break;
    else
        disp('Por favor ingrese la letra y en caso de que desee ver la grafica, en caso contrario digite n.');
    end
end
if option == 'y'
    x = a:0.001:b;
    y = f(x);
    plot(x, y);
    xlabel('x');
    ylabel('f(x)');
    grid;
end