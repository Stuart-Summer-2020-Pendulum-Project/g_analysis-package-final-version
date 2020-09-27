function [arm_new] = Conical_pendulum(g,B,C,x,vx,y,vy,z,vz,td) %input td
%solve for motion of pendulum exactly%

load('arm_data_processed','t')   %input t from loading

ax = zeros(1,length(t));
ay = zeros(1,length(t));
az = zeros(1,length(t));
arm = zeros(1,length(t));

R = sqrt(x(1)^2+y(1)^2+z(1)^2);
K = 10;

for i = 1:length(t)-1
    ts = t(i+1)-t(i);
    
    r = sqrt(x(i)^2+y(i)^2+z(i)^2);
    vr(i) = (1/r)*(x(i)*vx(i)+y(i)*vy(i)+z(i)*vz(i));
    T = g*(z(i)/r) - (1/r)*(vx(i)^2+vy(i)^2+vz(i)^2-vr(i)^2) - K*(r-R);
    
    arm(i) = -g*(z(i)/r) + (1/r)*(vx(i)^2+vy(i)^2+vz(i)^2 - vr(i)^2);
    
    ax(i) = T*(x(i)/r) - B*vx(i) - C*vx(i)^2;
    ay(i) = T*(y(i)/r) - B*vy(i) - C*vy(i)^2;
    az(i) = T*(z(i)/r) - B*vz(i) - C*vz(i)^2 - g;
    
    vx(i+1) = vx(i) + ax(i)*ts; %update steps%
    x(i+1) = x(i) + (1/2)*(vx(i)+vx(i+1))*ts + (1/2)*ax(i)*ts^2; %Taylor to 2nd order%
    
    vy(i+1) = vy(i) + ay(i)*ts; %update steps%
    y(i+1) = y(i) + (1/2)*(vy(i)+vy(i+1))*ts + (1/2)*ay(i)*ts^2; %Taylor to 2nd order%
    
    vz(i+1) = vz(i) + az(i)*ts; %update steps%
    z(i+1) = z(i) + (1/2)*(vz(i)+vz(i+1))*ts + (1/2)*az(i)*ts^2; %Taylor to 2nd order%
end

ax(length(t)) = ax(length(t)-1);
ay(length(t)) = ay(length(t)-1);
az(length(t)) = az(length(t)-1);
arm(length(t)) = arm(length(t)-1);

%make arm_new
arm_new = arm(1:10:end);   %change 10 with time_array_filler ts/10
    
%plot3(x,y,z)

%hold on
%plot(t,a)   %prime needed to fix array orientation%
%plot(t,y)  %plot statements are suppressed% %suppress y for better
%run time%
end