%Valor que indica si la matriz es diagonal estrictamente dominante ya que
%es necesario que lo sea para aplicar el metodo
matrizNoAceptada = 1;

%Itera hasta que se le ingrese una matriz valida
while matrizNoAceptada 
    %Solicita la matriz
    A = input(newline + "Ingresa la matriz A que representa el sistema de ecuaciones lineales a resolver: ");
    
    %Revisa si la matriz es diagonal estrictamente dominante
    if CheckDED(A)
        %Finaliza el loop si se cumple la condicion
        matrizNoAceptada = 0;
    else
        %Si no cumple la condición, muestra un mensaje de error
        disp("La matriz diagonal estrictamente dominante, ingresa otra matriz");
    end
end

%Pide el vector de términos independientes
B = input("Ingresa el vector B que representa los términos independientes de cada ecuación: ");

%Solicita una aproximación inicial
P0 = input("Ingresa las aproximación inicial: ");

%Solicita un valor delta como parámetro de finalización del método
delta = input("Ingrese un valor delta para la condicion de parada: ");

%Llama a la función que aplica el método pasandole los parametros
%solicitados
X = Jacobi(A, B, P0, delta);

%Muestra la solución obtenida
disp(X);