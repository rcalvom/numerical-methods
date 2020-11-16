%Se solicita la función f
regF = input("Ingrese la función f(x): ", "s");
f = inline(regF, "x");

%Se solicitan los limites superior e inferoir para evaluar la integral
a = input("Ingrese el límite inferior para evaluar la integral: ");
b = input("Ingrese el límite superior para evaluar la integral: ");

%Se solicitan la cantidad de nodos equiespaciados que se desean para
%evaluar la integral
M = input("Ingrese la cantidad de nodos para evaluar la intetgral: ");

%Se calcula el valor de h
h = (b-a)/M;

%Se calcula la aproximación de la integral utilizando el metodo del
%trapecio y se almacena en aprox
aprox = (h/2) * (f(a) + f(b));
for x_k = a + h:h:b - h
    aprox = aprox + (h * f(x_k));
end

%Se imprime el resultado obtenido
disp(newline + "La aproximación de la integral desde " + num2str(a) + " hasta " + num2str(b) + " de la funcion " + regF + " es: " + num2str(aprox));