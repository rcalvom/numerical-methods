function distance = EuclideanDistance(Vector1, Vector2)
    distance = 0;
    for a = 1 : size(Vector1, 1);
        distance = distance + (Vector1(a, 1) - Vector2(a, 1))^2;
    end
    distance = distance^(1/2);
end