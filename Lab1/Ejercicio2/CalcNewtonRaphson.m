% Variable simbólica x.
syms x;

% Función ingresada por el usuario.
f = input(newline + "Ingresa una función en terminos de x: ");

% Valor de tolerancia delta.
delta = input("Ingresa un valor de tolerancia delta: ");

% Punto inicial.
p_0 = input("Ingrese un punto de partida: ");

% Se calcula la raiz de la función usando como punto de partida p_0.
root = NewtonRaphson(f, p_0, delta);

% Se muestra en pantalla la tabla resultante y la aproximación de la
% raiz de la función obtenida luego de la ejecución del método de
% Newton - Raphson.
disp(newline + "La tabla generada en el método numérico es la siguiente: " + newline);
disp(root);
disp(newline + "La aproximación de la raíz de la función es: x = " + num2str(root(height(root), 2).Variables) + newline);

% Se le pregunta el usuario si desea ver la gráfica de la función f(x).
while 1
    option = input('¿Desea ver la gráfica de la función f(x)? (y/n): ', 's');
    if strcmp(option, 'y') || strcmp(option, 'n')
        break;
    else
        disp("Por favor ingrese la letra ""y"" en caso de que desee ver la gráfica, en caso contrario digite ""n""." + newline);
    end
end
if option == 'y'
    func = inline(f);
    a = p_0;
    b = root(height(root), 2).Variables;
    if a > b
        tmp = a;
        a = b;
        b = tmp;
    end
    a = a - (b - a) * 10;
    b = b + (b - a) * 10;
    x = a:(b - a)/200:b;
    y = func(x);
    plot(x, y);
    xlabel('x');
    ylabel('f(x)');
    title('Gráfica de la función.');
    xline(0);
    yline(0);
    grid;
end