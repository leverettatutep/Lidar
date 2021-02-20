clear;
clc;
addpath TriangleRayIntersection;
MeshSize = 20;
AngleOfSweep = 1;

%Where is the Drone and Laser
Drone = TRDrone(10.1,10.1,10,0,0,0);
Laser = Drone * RY(180);

[Vertices, Faces, xyz] = GetTheEnvironment(MeshSize);

% FindTheHit(Vertices, Faces, Laser) %, xyz, false)
Distances = LidarSweep(Vertices, Faces, Drone, AngleOfSweep);

Angles = linspace(0,360-AngleOfSweep,360/AngleOfSweep);
plot(Angles,Distances);

function Drone = TRDrone(x,y,z,yaw,pitch,roll)
    R = RZ(yaw) * RY(pitch) * RX(roll);
    Drone = eye(4);
    Drone(1,4) = x;
    Drone(2,4) = y;
    Drone(3,4) = z;
    Drone = Drone * R;
end

