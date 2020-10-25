function polynomial = myFun(C)
    n = length(C);
    polynomial = "";
    for index = n - 1 : -1 : 1
        el = strcat(strcat(num2str(C(n - index)), ".*x.^"), num2str(index));
        if C(n - index) >= 0 && index ~= n - 1
            el = strcat("+", el);
        end
        polynomial = strcat(polynomial, el);
    end
    last = num2str(C(n));
    if C(n) >= 0
        last = strcat("+", last);
    end
    polynomial = strcat(polynomial, last);
end