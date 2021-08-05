function [vertices, faces, xyz] = GetTheEnvironment(MeshN)
    [x,y] = meshgrid(1:MeshN,1:MeshN);    % create 2D mesh of points
    %meshgrid creates X and Y where x is essentially equal to the column
    %position and y is the row position. LJE
    faces = delaunay(x,y);        % triangulate it using Delaunay algorithm
    %If you take the x and y and string them out in a single vector then
    %form triangles the faces will be the index in the strung out vector of
    %a corner of a triangle, the 3 columns of faces are the 3 points
    %forming a triangle. LJE
    z     = peaks2(MeshN);             % sample function defined on a grid of the same dimenision
    %this function creates a linspace x and y from -3 to 3 then imposes a z
    %value on each x and y, then only returns the z coordinate so the -3
    %and +3 get remapped to the x y defined in line 2
    vertices = [x(:) y(:) z(:)];  % vertices stored as Nx3 matrix
%     vert1 = vertices(faces(:,1),:);
%     vert2 = vertices(faces(:,2),:);
%     vert3 = vertices(faces(:,3),:);
    xyz = [x y z];
%    trisurf(Faces,x,y,z, intersect*1.0,'FaceAlpha', 0.9)
    figure;
    trisurf(faces,x,y,z); %This plots the surface by drawing each triangle corner
end

