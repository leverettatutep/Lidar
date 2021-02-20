clear;
clc;
addpath TriangleRayIntersection;
MeshSize = 20;
AngleOfSweep = 1;

Angles = linspace(0,360-AngleOfSweep,360/AngleOfSweep);
[Vertices, Faces, xyz] = GetTheEnvironment(MeshSize);

%Where is the Drone and Laser
Drone = TRDrone(10.1,10.1,10,0,0,0);
% FindTheHit(Vertices, Faces, Laser) %, xyz, false)
Distances = LidarSweep(Vertices, Faces, Drone, AngleOfSweep);
plot(Angles,Distances);

Drone = TRDrone(11,10.1,10,0,0,0);
Distances1 = LidarSweep(Vertices, Faces, Drone, AngleOfSweep);
figure;
plot(Angles,Distances1);

figure;
plot(Angles,Distances,Angles,Distances1);

function Drone = TRDrone(x,y,z,yaw,pitch,roll)
    R = RZ(yaw) * RY(pitch) * RX(roll);
    Drone = eye(4);
    Drone(1,4) = x;
    Drone(2,4) = y;
    Drone(3,4) = z;
    Drone = Drone * R;
end

