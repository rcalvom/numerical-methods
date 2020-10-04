syms s;

matriz = input("Ingrese la matriz con los valores x_i, y_i: ");
sympref('FloatingPointOutput', true);

polinomio = PolinomioNewton(matriz);

polinomio = inline(polinomio, "s");
disp(expand(polinomio(s)));
s = inline( strcat("(x-", num2str(matriz(1,1)), ")/", num2str(matriz(2,1) - matriz(1,1))), "x");

x = matriz(1,1) : 0.01 : matriz(size(matriz,1),1);

plot(x, polinomio(s(x)), "-b"); xlabel("x"); ylabel("Pn(x)"); title("Polinomio interpolador de Newton"); hold on;

while(1)
    option = input("¿Desea interpolar algun valor? (y/n): ", 's');
    if option == "y"
        plot(x, polinomio(s(x)), "-b"); xlabel("x"); ylabel("Pn(x)"); title("Polinomio interpolador de Newton"); hold on;
        xu = input("Ingrese el valor que desea interpolar: ");
        disp(strcat("Pn(", num2str(xu), ") = ", num2str(polinomio(s(xu)))));
        scatter(xu, polinomio(s(xu)), 25, 'black' ,'filled'); hold off;
    else
       break; 
    end
end