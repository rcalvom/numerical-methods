function matrix = TriangularFactoring(M, B)
    matrix = [M B];
    for a = 1 : size(matrix, 1);
        if matrix(a, a) == 0;
            row = 0;
            for b = a + 1 : size(matrix, 1);
                if matrix(b, a) ~= 0;
                    row = b;
                    break;
                end
            end
            if row == 0;
                error("\nLa matriz ingresada es singular, no se puede factorizar.\n");
            else
                for b = 1 : size(matrix, 2);
                    temp = matrix(a, b);
                    matrix(a, b) = matrix(row, b);
                    matrix(row, b) = temp;    
                end
            end
        end
        for b = a + 1 : size(matrix, 1);
            matrix(b, a) = matrix(b, a) / matrix(a, a);
        end
        for b = a + 1 : size(matrix, 1);
            for c = a + 1 : size(matrix, 2) - 1;
                matrix(b, c) = matrix(b, c) - matrix(b, a) * matrix(a, c);
            end
        end
    end
end