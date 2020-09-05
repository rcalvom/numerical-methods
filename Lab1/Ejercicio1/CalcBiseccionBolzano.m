syms x;
f = inline(input(newline + "Ingresa una función en terminos de x: "));
delta = input("Ingresa un valor de tolerancia delta: ");
while 1   
    a = input("Ingrese un límite inferior del intervalo: ");
    b = input("Ingrese un límite superior del intervalo: ");
    if sign(f(a)) == sign(f(b)) | sign(f(a)) == 0 | sign(f(b)) == 0
        disp(newline + "Los intervalos no son validos, por favor ingreselos nuevamente." + newline);
    else
        break;
    end
end
format short
root = BiseccionBolzano(f, a, b, delta);
disp(newline + "La aproximación de la raíz de la función en el intervalo [" + num2str(a) + ", " + num2str(b) + "] es: " + num2str(root) + newline);