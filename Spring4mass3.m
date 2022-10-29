% Calculates the position, velocity, and acceleration as a function of time
% of a system of carts connected by springs and dashpots. 
% Euler's Method is used to solve the equations of motion numerically.
clear all; close all; clc;
tic

% Problem parameters
k1=3; % 1st spring constant (N/m)
k2=1.5; % 2nd spring constant (N/m)
k3 = 2; % 3rd spring constant (N/m)
k4 = 1; % 4th spring constant (N/m)
m1=1; % cart 1 mass (kg)
m2=2; % cart 2 mass (kg)
m3 = 3; %cart 3 mass (kg)
x10=0.1; % cart 1 initial position (m)
x20=-0.1; % cart 2 initial position (m)
x30=0.2; % cart 3 initial position (m)
v10=0; % cart 1 initial velocity (m/s)
v20=0; % cart 2 initial velocity (m/s)
v30=0; % cart 3 initial velocity (m/s)
l1=1.5;
l2=1.2;
l3=1.1;
l4=1.8;

% Set time step stuff
simTime=100; % simulation time (s)
tStep=0.001; % simulation time step
iterations=simTime/tStep;
t=0:iterations;

% Pre-allocate variables for speed and add initial conditions
x1=zeros;
x1(1,:)=x10;
x2=zeros;
x2(1,:)=x20;
x3=zeros;
x3(1,:)=x30;
v1=zeros;
v1(1,:)=v10;
v2=zeros;
v2(1,:)=v20;
v3=zeros;
v3(1,:)=v30;
a1=zeros;
a1(1,:)=(k2*(x20) - (k1+k2)*x10)/m1;
a2=zeros;
a2(1,:)=(k2*x10 + k3*x30 - (k2+k3)*x20)/m2;
a3=zeros;
a3(1,:)=(k3*x20-(k3+k4)*x30)/m3;

% Solve the ODE's with Euler's Method
for n=2:(iterations+1)
  x1(n,:)=x1(n-1,:)+v1(n-1,:)*tStep; % cart 1 position
  x2(n,:)=x2(n-1,:)+v2(n-1,:)*tStep; % cart 2 position
  x3(n,:)=x3(n-1,:)+v3(n-1,:)*tStep;
  v1(n,:)=v1(n-1,:)+a1(n-1,:)*tStep; % cart 1 velocity
  v2(n,:)=v2(n-1,:)+a2(n-1,:)*tStep; % cart 2 velocity
  v3(n,:)=v3(n-1,:)+a3(n-1,:)*tStep;
  % Find cart accelerations
  a1(n,:)=(k2*x2(n,:)-(k1+k2)*x1(n,:))/m1;
  a2(n,:)=(k2*x1(n,:)+k3*x3(n,:)-(k2+k3)*x2(n,:))/m2;
  a3(n,:)=(k3*x2(n,:)-(k3+k4)*x3(n,:))/m3;
end


for i=1:100:10000
   plot([0 0], [-2 1], 'color', 'k');
   hold on;
   plot([0 l1+x1(i,1)], [0 0], '--r'); %first line
   hold on;
   plot(l1+x1(i, 1), 0, 'square', 'MarkerSize', 30,'MarkerFaceColor', 'b'); %coordinate of box 1
   hold on;
   plot([l1+x1(i, 1)+0.25, l1+l2+x2(i,1)], [0 0], '--r'); %second line
   hold on;
   plot(l1+l2+x2(i, 1), 0, 'square', 'MarkerSize', 30, 'MarkerFaceColor', 'b'); %coordinate of box 2
   hold on;
   plot([l1+l2+x2(i, 1)+0.25 l1+l2+l3+x3(i,1)], [0 0], '--r'); %third line
   hold on;
   plot(l1+l2+l3+x3(i, 1), 0, 'square', 'MarkerSize', 30, 'MarkerFaceColor', 'b'); %coordinate of box 3
   hold on;
   plot([l1+l2+l3+x3(i, 1)+0.25 l1+l2+l3+l4], [0 0], '--r'); %fourth line
   hold on;
   plot([l1+l2+l3+l4 l1+l2+l3+l4], [-2 1], 'color', 'k');
   axis([-1 6 -2 2]);
   pause(0.05);
   hold off;
   
end

toc

