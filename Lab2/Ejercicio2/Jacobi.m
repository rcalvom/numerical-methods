function X = Jacobi(A, B, P0)
    s = size(A, 1);
    D = zeros(s, s);
    L = zeros(s, s);
    U = zeros(s, s);
    
    for i = 1:s
        for j = 1:s
            if i == j
                D(i,j) = A(i,j);
            elseif i > j
                U(i,j) = -A(i,j);
            else
                L(i,j) = -A(i,j);
            end
        end
    end
    
    DB = (D^-1)*B;
    DLU = (D^-1)*(L+U);
    
    XK = P0;
    X = zeros(10, s+1);
    for i = 1 : 15
        XK = DB + (DLU*XK);
        X(i, 1) = i;
        for j = 1:s
            X(i,j+1) = XK(j, 1);
        end
    end
    
    names = ["K" "X_K" "Y_K" "Z_K"]
    X = array2table(X, 'VariableNames', names);

end