function E = rootMeanSquareError(X, y)
    %Almacena el error cuadrático medio
    E = 0;
    
    %Ciclo for para calcular la suma del cuadrado de la diferencia entre
    %los elementos X(a) y y(a)
    for a = 1 : size(X, 1)
        E = E + abs(X(a, 2) - y(a))^2;
    end
    %Se calcula el promedio dividiendo la suma que se almaceno en E al
    %terminar el ciclo for entre la cantidad de puntos recibidos
    E = E / size(X, 1);
    %Se calcula la raiz cuadrada del promedio obtenido
    E = sqrt(E);
end