function matrix = TriangularFactoring(M, B)
    matrix = [M B];

    for a = 1 : size(matrix, 1);
        row = a + 1;
        while matrix(a, a) == 0;
            if row <= size(matrix, 1);
                for b = 1 : size(matrix, 2)
                    temp = matrix(a, b);
                    matrix(a, b) = matrix(row, b);
                    matrix(row, b) = temp;    
                end
            else
               error("\nLa matriz ingresada es singular.\n");
            end
        end

        for b = a + 1 : size(matrix, 1);
            matrix(b, a) = matrix(b, a) / matrix(a, a);
        end
        for b = a + 1 : size(matrix, 1);
            for c = a + 1 : size(matrix, 2);
                matrix(b, c) = matrix(b, c) - matrix(b, a) * matrix(a, c);
            end
        end

    end
    
end