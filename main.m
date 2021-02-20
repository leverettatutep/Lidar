clf;
clear;
clc;

data = gauss2d();
surf2stl('stl.dat',data(1),data(2),data(3),'ascii');

