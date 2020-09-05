syms x;
f = input(newline + "Ingresa una función en terminos de x: ");
delta = input("Ingresa un valor de tolerancia delta: ");
p_0 = input("Ingrese un punto de partida: ");
root = NewtonRaphson(f, p_0, delta);
disp(newline + "La aproximación de la raíz de la función es: " + num2str(root) + newline);
