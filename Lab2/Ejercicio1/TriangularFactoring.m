function matrix = TriangularFactoring(M, B)
    matrix = [M B];

    for a = 1 : size(matrix, 1) - 1;

        for b = a + 1 : size(matrix, 1);
            matrix(b, a) = matrix(b, a) / matrix(a, a);
        end
        for b = a + 1 : size(matrix, 1);
            for c = a + 1 : size(matrix, 2);
            matrix(b, c) = matrix(b, c) - matrix(b,a) * matrix(a, c);
            end
        end

    end
    
end