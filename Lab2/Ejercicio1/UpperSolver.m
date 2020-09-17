function X = UpperSolver(U, Y)
    for a = size(Y, 1) : -1 : 1;
        acc = 0;
        for b = size(U, 2) : -1 : a + 1;
            acc = acc + U(a, b) * X(b, 1);
        end
        X(a, 1) = (Y(a, 1) - acc) / U(a, a);
    end  
end