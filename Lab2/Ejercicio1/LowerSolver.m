function Y = LowerSolver(L, B) 
    for a = 1 : size(B, 1);
        acc = 0;
        for b = 1 : a - 1;
            acc = acc + L(a, b) * Y(b, 1);
        end
        Y(a, 1) = (B(a, 1) - acc) / L(a, a);
    end    
end