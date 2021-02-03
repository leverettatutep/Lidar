clear; clc; close all;
%Create the function
limits = repmat([-5 5], 2, 1);
[X,Y] = meshgrid(linspace(limits(1,1),limits(1,2),100),...
                   linspace(limits(2,1),limits(2,2),100));
Z = reshape(rastrigin([X(:)'; Y(:)']), 100, 100);
surf(X,Y,Z);
%axis([-5 5 -5 5 0 90]);
shading interp

surf2stl('STL.dat',X,Y,Z,'ascii');

function [y] = rastrigin(x)
    d = length(x);
    sq = x.^2;   
    y = 10*d + sum(sq - 10*cos(2*pi*x));
%    y = 10*d + sum(sq);
end