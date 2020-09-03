func = input('Ingresa una función en terminos de x: ', 's');
f = inline(func,'x');
delta = input('Ingresa un valor de tolerancia delta: ');
while 1   
    a = input('Ingrese un límite inferior del intervalo: ');
    b = input('Ingrese un límite superior del intervalo: ');
    if sign(f(a)) == sign(f(b));
        disp('Los intervalos no son validos, por favor ingreselos nuevamente.');
    else
        break
    end
end
format short
root = BiseccionBolzano(f, a, b, delta);
result = ['La aproximación de la raíz de la función' ' ' func ' en el intervalo [' num2str(a) ', '  num2str(b)  '] es:' ' ' num2str(root)];
disp(result);