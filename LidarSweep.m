function Distances = LidarSweep(Vertices, Faces, Drone, deltaAngDeg)
%In an effort to keep things as easy to visualize as possible, let's let
%the initial laser beam shoot out the TOP of the drone (toward the sky if
%ypr are zero) and sweep toward the rear, then through the belly (toward
%the ground) back toward the nose and up into the sky.
%This way we would not expect to hit much at the lowest and highest angles
%of sweep and all the 'good' data would be in the middle angles centered
%approximately around 180 degrees.
    n = 360/deltaAngDeg;
    startAngle = -180; %if ypr = 0 z is down so spin it to make z up
    Distances = zeros(n,1);
    for i=1:n
        ang = startAngle + deltaAngDeg * (i-1);
        Laser = Drone * RY(ang); %Laser rotates from sky to rear to ground to nose to sky
%FindTheHit has a laser origin at the 4th column of Laser.
%The beam shoots out in the direction of 3rd column of Laser, this would be
%the +z axis of Laser.
        AllDistances = FindTheHit(Vertices, Faces, Laser); %, xyz, false)
        if size(AllDistances) > 1
            Distances(i) = mean(AllDistances);
        else
            Distances(i) = AllDistances(1);
        end
    end
end
