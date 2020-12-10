function y = vector2sym(vector)
    syms x;
    sympref('FloatingPointOutput', true)
    y = - vector(2) / vector(3) * x - vector(1) / vector(3);
end