clear all;
close all;
clc;
addpath TriangleRayIntersection;
% addpath ../../MATH/MATLAB/MatlabKinematics;
%% Adjustable parameters
MeshSize = 20; %The "map" is an "image" with MeshSize by MeshSize pixels
AngleOfSweep = 1; %The lidar returns readings every AngleOfSweep degrees
%Where is the Drone and Laser
%Map x is East, y is North, z is up
%Drone is initially aligned with Map origin, then moved as given below 
%CorrectDroneVals = [MeshSize/2 MeshSize/2 40 0 0 0]; %X Y Z Yaw Pitch Roll
CorrectDroneVals = [(MeshSize/2 + .1) (MeshSize/2 + .1) 10 0 0 0]; %X Y Z Yaw Pitch Roll

%% Actual code
Angles = linspace(0,360-AngleOfSweep,360/AngleOfSweep); %Lidar angles start at 0 and go one short of 360
[Vertices, Faces, xyz] = GetTheEnvironment(MeshSize); %The map
CorrectDrone = TRDrone(CorrectDroneVals); 
% FindTheHit(Vertices, Faces, Laser) %, xyz, false)
%Lidar laser shoots out drone +z axis when angle = 0, rotates about +DroneY
CorrectDistances = LidarSweep(Vertices, Faces, CorrectDrone, AngleOfSweep);
figure;
plot(Angles,CorrectDistances);
title('Correct Distances');
maxy = (floor(max(CorrectDistances)/10) + 1)*10;
miny = (floor(min(CorrectDistances)/10)) * 10;
axis([0 360 miny maxy]);

InitialGuess = [11 8 8 1 1 1]; %x y z yaw pitch roll
Drone = TRDrone(InitialGuess);
InitialDistances = LidarSweep(Vertices, Faces, Drone, AngleOfSweep);
figure;
plot(Angles,InitialDistances);
title('Initial Distances');
axis([0 360 0 30]);

StuffForError = struct;
StuffForError.Angles = Angles;
StuffForError.Vertices = Vertices;
StuffForError.Faces = Faces;
StuffForError.AngleOfSweep = AngleOfSweep;
StuffForError.CorrectDistances = CorrectDistances;

InitialError = GetError(InitialGuess,StuffForError)

%I found this link https://www.mathworks.com/help/matlab/math/parameterizing-functions.html
%to be useful to determine the following syntax
tic;
BestGuess = fminsearch(@(DroneVals) GetError(DroneVals,StuffForError),InitialGuess)
BestError = GetError(BestGuess,StuffForError)
%Other minimizing functions are here.
%https://www.mathworks.com/help/matlab/referencelist.html?type=function&category=optimization&s_tid=CRUX_topnav
toc
BestGuessDrone = TRDrone(BestGuess);
% FindTheHit(Vertices, Faces, Laser) %, xyz, false)
BestGuessDistances = LidarSweep(Vertices, Faces, CorrectDrone, AngleOfSweep);
figure;
plot(Angles,BestGuessDistances);
title('Best Guess Distances');
axis([0 360 0 30]);

BestLastTime = [10.1049   10.1508    9.9974    0.9757    0.0184    0.0092];
BestErrorLastTime = GetError(BestLastTime,StuffForError)

figure;
plot(Angles,CorrectDistances,Angles,InitialDistances,Angles,BestGuessDistances);
legend('Correct','Initial','Best');
axis([0 360 0 30]);


function theError = GetError(DroneVals, StuffForError)
    Drone = TRDrone(DroneVals);
    Vertices = StuffForError.Vertices;
    Faces = StuffForError.Faces;
    AngleOfSweep = StuffForError.AngleOfSweep;
    Angles = StuffForError.Angles;
    CorrectDistances = StuffForError.CorrectDistances;
    
    
    Distances = LidarSweep(Vertices, Faces, Drone, AngleOfSweep);
    n = size(Angles,2);
    Distances = abs(Distances - CorrectDistances);
    sum = 0;
    numInSum = 0;
    for i=1:n
        if (Distances(i) < Inf) && (~isnan(Distances(i)))
            sum = sum + Distances(i);
            numInSum = numInSum + 1;
        end
    end
    if numInSum ~= 0
        theError = sum/numInSum;
    else
        theError = 200000;
    end
end
            
    
    