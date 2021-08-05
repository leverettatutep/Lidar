function R = RY(deg)
    R = eye(4);
    c = cosd(deg);
    s = sind(deg);
    R(1,1) = c;
    R(3,3) = c;
    R(3,1) = -s;
    R(1,3) = s;
end
