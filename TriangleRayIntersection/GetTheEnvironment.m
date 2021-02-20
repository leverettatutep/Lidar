function [vertices, faces, xyz] = GetTheEnvironment(MeshN)
    [x,y] = meshgrid(1:MeshN,1:MeshN);    % create 2D mesh of points
    faces = delaunay(x,y);        % triangulate it using Delaunay algorithm
    z     = peaks2(MeshN);             % sample function defined on a grid of the same dimenision
    vertices = [x(:) y(:) z(:)];  % vertices stored as Nx3 matrix
%     vert1 = vertices(faces(:,1),:);
%     vert2 = vertices(faces(:,2),:);
%     vert3 = vertices(faces(:,3),:);
    xyz = [x y z];
end

