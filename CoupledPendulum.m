close all;
clc;

%parameters
k1=4;
l1=1;
l2=1.2;
m1=1.5;
m2=1.1;
a=1;
g=9.8;
w=1;
theta10=pi/8;
theta20=pi/4;
theta10d=0;
theta20d=0;

%time step setting
tStep=0.001;
tSim=100;
iterations=tSim/tStep;
t=0:iterations;

%Allocating variables for initial conditions
theta1=zeros(iterations, 1);
theta1(1, :)=theta10;
theta2=zeros(iterations, 1);
theta2(1, :)=theta20;
theta1d=zeros(iterations, 1);
theta1d(1, :)=theta10d;
theta2d=zeros(iterations, 1);
theta2d(1, :)=theta20d;
theta1dd=zeros(iterations, 1);
theta1dd(1, :)=-(k1*a^2*(theta10-theta20) + m1*g*l1*theta10)/(m1*l1^2);
theta2dd=zeros(iterations, 1);
theta2dd(1, :)=-(k1*a*theta20-k1*a^2*theta10+m2*g*l2*theta20)/(m2*l2^2);

for n=2:(iterations+1)
    theta1(n,:)=theta1(n-1, :)+theta1d(n-1, :)*tStep;
    theta2(n,:)=theta2(n-1, :)+theta2d(n-1, :)*tStep;
    theta1d(n,:)=theta1d(n-1, :)+theta1dd(n-1, :)*tStep;
    theta2d(n,:)=theta2d(n-1, :)+theta2dd(n-1, :)*tStep;
    theta1dd(n,:)=-(k1*a^2*(theta1(n, :)-theta2(n, :)) + m1*g*l1*theta1(n, :))/(m1*l1^2);
    theta2dd(n, :)=-(k1*a*theta2(n, :)-k1*a^2*theta1(n, :)+m2*g*l2*theta2(n, :))/(m2*l2^2);
end

%Plot
%subplot(4,1,1)
%hold on;
%plot(t',theta1, 'b')
%plot(t', theta2, 'r')
%ylabel('Angular Position')
%title('Angular Position, Angular Velocity and Angular Acceleration as a Function of Time')
%legend('M1', 'M2')
%subplot(4,1,2)
%hold on;
%plot(t',theta1d, 'b')
%plot(t', theta2d, 'r')
%ylabel('Angular Velocity')
%legend('M1', 'M2')
%subplot(4,1,3)
%hold on;
%plot(t',theta1dd, 'b')
%plot(t', theta2dd, 'r')
%ylabel('Angular Acceleration')
%legend('M1', 'M2')

%subplot(4, 1, 4)
%title('Simulation')
%pos = get(gcf, 'Position');
%set(gcf, 'Position',pos+[0 -1000 0 1000])
%hold on;

for n=1:50:10000
   plot([-0.5, 1.5],[0,0],'linewidth',3,'color','r');
   hold on;
   plot([0 l1*sin(theta1(n, :))],[0 -l1*cos(theta1(n, :))],'linewidth',2,'color','g');
   hold on;
   plot(l1*sin(theta1(n, :)),-l1*cos(theta1(n, :)),'o','markers',10,'markerfacecolor','b');
   hold on;
   plot([a*sin(theta1(n, :)) a*sin(theta2(n, :))+w], [-a*cos(theta1(n, :)) -a*cos(theta2(n, :))],'--', 'color', 'r')
   %line([], 'linewidth', 2, 'color', 'r');
   plot([w l2*sin(theta2(n, :))+w],[0 -l2*cos(theta2(n, :))],'linewidth',2,'color','g');
   hold on;
   plot(l2*sin(theta2(n, :))+w, -l2*cos(theta2(n, :)),'o','markers',10,'markerfacecolor','b');
   axis([-1.5 2.5 -2.5 0.5]);
   pause(0.05);
   hold off;

end