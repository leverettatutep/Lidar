function R = RZ(a)
    R = eye(4);
    c = cosd(a);
    s = sind(a);
    R(1,1) = c;
    R(2,2) = c;
    R(2,1) = s;
    R(1,2) = -s;
end
