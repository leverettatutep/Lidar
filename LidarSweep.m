function Distances = LidarSweep(Vertices, Faces, Drone, deltaAngDeg)
    n = 360/deltaAngDeg;
    Distances = zeros(n,1);
    for i=1:n
        ang = deltaAngDeg * (i-1);
        Laser = Drone * RY(ang);
        if ang == 191
            stop = 1;
        end
        AllDistances = FindTheHit(Vertices, Faces, Laser); %, xyz, false)
        if size(AllDistances) > 1
            Distances(i) = mean(AllDistances);
        else
            Distances(i) = AllDistances(1);
        end
    end
end
