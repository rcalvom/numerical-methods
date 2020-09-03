syms x;
f = input('Ingresa una función en terminos de x: ');
delta = input('Ingresa un valor de tolerancia delta: ');
p = input('Ingrese un punto de partida: ');
root = NewtonRaphson(f, p, delta);
result = ['La aproximación de la raíz de la función' ' es:' ' ' num2str(root)];
disp(result);
