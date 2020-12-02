function F = FiniteDifferenceMethod(p, q, r, a, b, x_a, x_b, N)
    % Se calcula el ancho del intervalo
    h = (b - a) / N;

    % Matriz para guardar los coeficientes del sistema de ecuaciones
    M = zeros(N - 1, N - 1);
    % Vector columna de terminos independientes
    B = zeros(N - 1, 1);

    % k-ésimo nodo
    t_k = a + h;

    % Se calculan los coheficientes de las posiciones (1,1), (1,2),
    % (N-1, N-2) y (N-1, N-1)
    M(1, 1) = 2 + (h ^ 2) * q(t_k);
    M(1, 2) = (h / 2) * p(t_k) - 1;
    M(N - 1, N - 2) = -1 * (h / 2) * p(b - h) - 1;
    M(N - 1, N - 1) = 2 + (h ^ 2) * q(b - h);
    
    % Calcula los terminos independientes 1 y N-1
    B(1, 1) = -1 * (h ^ 2) * r(t_k) + ((h / 2) * p(t_k) + 1) * x_a;
    B(N - 1, 1) = -1 * (h ^ 2) * r(b - h) + (-1 * (h / 2) * p(b - h) + 1) * x_b;

    % Se calculan los demás coheficientes y términos independientes
    for index = 2 : N - 2
        t_k = t_k + h;
        M(index, index - 1) = -1 * (h / 2) * p(t_k) - 1;
        M(index, index) = 2 + (h ^ 2) * q(t_k);
        M(index, index + 1) = (h / 2) * p(t_k) - 1;
        B(index, 1) = -1 * (h ^ 2) * r(t_k);
    end

    % Se resuelve el sistema MX = B
    X = M \ B;
    
    % Se crea una matriz de N + 1 filas por 2 columnas para almancenar los
    % nodos y sus aproximaciones
    F = zeros(N + 1, 2);
    F(1, 1) = a;
    F(1, 2) = x_a;
    F(N + 1, 1) = b;
    F(N + 1, 2) = x_b;

    % Se llena la matriz F
    for index = 2 : N
        F(index, 1) = F(index - 1, 1) + h;
        F(index, 2) = X(index - 1);
    end
end