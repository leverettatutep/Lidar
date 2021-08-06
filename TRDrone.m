function Drone = TRDrone(poseD)
    x = poseD(1);
    y = poseD(2);
    z = poseD(3);
    yaw = poseD(4);
    pitch = poseD(5);
    roll = poseD(6)+180; %The 180 flips it so drone z points down.
    R = RZ(yaw) * RY(pitch) * RX(roll);
    Drone = eye(4);
    Drone(1,4) = x;
    Drone(2,4) = y;
    Drone(3,4) = z;
    Drone = Drone * R;
end

