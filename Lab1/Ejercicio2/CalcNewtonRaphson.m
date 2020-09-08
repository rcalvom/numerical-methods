syms x;
f = input(newline + "Ingresa una función en terminos de x: ");
delta = input("Ingresa un valor de tolerancia delta: ");
p_0 = input("Ingrese un punto de partida: ");
root = NewtonRaphson(f, p_0, delta);
disp(newline + "La tabla generada en el método numérico es la siguiente: " + newline);
disp(root);
disp(newline + "La aproximación de la raíz de la función es: x = " + num2str(root(height(root), 2).Variables) + newline);
