function R = RX(a)
    R = eye(4);
    c = cosd(a);
    s = sind(a);
    R(2,2) = c;
    R(3,3) = c;
    R(3,2) = s;
    R(2,3) = -s;
end
