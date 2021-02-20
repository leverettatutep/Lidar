function R = RY(a)
    R = eye(4);
    c = cosd(a);
    s = sind(a);
    R(1,1) = c;
    R(3,3) = c;
    R(3,1) = -s;
    R(1,3) = s;
end
