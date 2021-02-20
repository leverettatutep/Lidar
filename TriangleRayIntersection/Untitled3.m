n = 2;
[x,y] = meshgrid(1:n,1:n);    % create 2D mesh of points
faces = delaunay(x,y);   
triplot(faces,x,y);
xx=x(:);
yy=y(:);