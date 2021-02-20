function Distances = LidarSweep(Vertices, Faces, Drone, deltaAngDeg)
    n = 360/deltaAngDeg;
    Distances = zeros(n,1);
    for i=1:n
        ang = deltaAngDeg * (i-1);
        Laser = Drone * RY(ang);
        Distances(i) = FindTheHit(Vertices, Faces, Laser); %, xyz, false)
    end
end
