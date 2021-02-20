clear;
clc;
addpath TriangleRayIntersection;
MeshSize = 20;
AngleOfSweep = 1;

Angles = linspace(0,360-AngleOfSweep,360/AngleOfSweep);
[Vertices, Faces, xyz] = GetTheEnvironment(MeshSize);

%Where is the Drone and Laser
CorrectDroneVals = [10.1 10.1 10 0 0 0];
CorrectDrone = TRDrone(CorrectDroneVals);
% FindTheHit(Vertices, Faces, Laser) %, xyz, false)
CorrectDistances = LidarSweep(Vertices, Faces, CorrectDrone, AngleOfSweep);
plot(Angles,CorrectDistances);

InitialGuess = [11 8 8 1 1 1]; %x y z yaw pitch roll
Drone = TRDrone(InitialGuess);
InitialDistances = LidarSweep(Vertices, Faces, Drone, AngleOfSweep);
figure;
plot(Angles,InitialDistances);

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

BestLastTime = [10.1049   10.1508    9.9974    0.9757    0.0184    0.0092];
BestErrorLastTime = GetError(BestLastTime,StuffForError)

figure;
plot(Angles,CorrectDistances,Angles,InitialDistances,Angles,BestGuessDistances);


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
            
    
    