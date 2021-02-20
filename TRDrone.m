function Drone = TRDrone(pose)
    x = pose(1);
    y = pose(2);
    z = pose(3);
    yaw = pose(4);
    pitch = pose(5);
    roll = pose(6);
    R = RZ(yaw) * RY(pitch) * RX(roll);
    Drone = eye(4);
    Drone(1,4) = x;
    Drone(2,4) = y;
    Drone(3,4) = z;
    Drone = Drone * R;
end

