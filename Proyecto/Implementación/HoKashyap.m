function [a, b] = HosKashyap(a, b, Y, eta)
    e = Y*a - b;
    b = b + eta * (e + abs(e));
    a = (Y' * Y)^-1 * Y' * b;
end