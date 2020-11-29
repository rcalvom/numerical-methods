function F = FiniteDifferenceMethod(p, q, r, a, b, x_a, x_b, N)
    h = (b - a) / N;

    M = zeros(N - 1, N - 1);
    B = zeros(N - 1, 1);

    t_k = a + h;

    M(1, 1) = 2 + (h ^ 2) * q(t_k);
    M(1, 2) = (h / 2) * p(t_k) - 1;
    M(N - 1, N - 2) = -1 * (h / 2) * p(b - h) - 1;
    M(N - 1, N - 1) = 2 + (h ^ 2) * q(b - h);

    B(1, 1) = -1 * (h ^ 2) * r(t_k) + ((h / 2) * p(t_k) + 1) * x_a;
    B(N - 1, 1) = -1 * (h ^ 2) * r(b - h) + (-1 * (h / 2) * p(b - h) + 1) * x_b;

    for index = 2 : N - 2
        t_k = t_k + h;
        M(index, index - 1) = -1 * (h / 2) * p(t_k) - 1;
        M(index, index) = 2 + (h ^ 2) * q(t_k);
        M(index, index + 1) = (h / 2) * p(t_k) - 1;
        B(index, 1) = -1 * (h ^ 2) * r(t_k);
    end

    X = M \ B;

    names = {'t_j', 'x_j'};
    values = zeros(N + 1, 2);
    values(1, 1) = a;
    values(1, 2) = x_a;
    values(N + 1, 1) = b;
    values(N + 1, 2) = x_b;

    for index = 2 : N
        values(index, 1) = values(index - 1, 1) + h;
        values(index, 2) = X(index - 1);
    end

    F = array2table(values, 'VariableNames', names);
end