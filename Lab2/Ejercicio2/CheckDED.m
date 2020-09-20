function bool = CheckDED(M)
    bool = 1;
    for a = 1 : size(M, 1)
        acc = 0;
        for b = 1 : size(M, 2)
            acc = acc + abs(M(b, a));
        end
        if acc - M(a, a) > 0
            bool = 0;
            break;
        end
    end
end