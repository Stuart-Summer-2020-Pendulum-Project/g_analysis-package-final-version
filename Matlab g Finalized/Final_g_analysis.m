function [p] = Final_g_analysis(which_peak,space)

data_process(which_peak,space)

%initial_theta = input('enter initial angle from vertical (radians) ');
%R = input('enter length of pendulum (meters) ');

load('arm_data_processed')

go = false;
while go == false
    RA = input('rolling average data? true or false ');
    if RA == true
        arm_data = movmean(arm_data,30);
        go = true;
    elseif RA == false
        %pass
        go = true;
    else
        %pass
        %this will loop until user input is boolean
    end
end
    
disp('fitting in progress')

y0 = 0;        %y0 not varied forced to be zero

vx0 = 0;
vy0 = 0;
vz0 = 0;

fun = @(p,t) Conical_pendulum(p(1),p(2),p(8),sqrt(R^2-p(6)^2),p(4),y0,p(5),p(6),p(7),t) + p(3);   %change together
p_naught = [9.4 0.005 0 vx0 vy0 z0 vz0 0];               %change together

dz0 = 0.1;

lb = [9 0 -Inf -Inf -Inf z0-dz0 -Inf 0];              %change together
ub = [11 Inf Inf Inf Inf z0+dz0 Inf Inf];                  %change together

options = optimset('MaxIter',1000,'MaxFunEvals',2500);
p = lsqcurvefit(fun,p_naught,td,arm_data,lb,ub,options);

disp('fit results:')
disp('g = ')
disp(p(1))     %canceling the measuring apparatus offset?
disp('B = ')
disp(p(2))
disp('S = ')
disp(p(3))
disp('C = ')
disp(p(8))

%[arm] = Conical_pendulum(p(1),p(2),x0,vx0,y0,vy0,z0,vz0,t);
f = fun(p,t);
plot(td,f)     %arm+p(3) is the true fitting function
hold on
plot(td,arm_data)

[lsr] = Least_Square_residual(f,arm_data);
disp('The lease square residual is')
disp(lsr)

[std] = calc_std;
disp('Standard deviation is')
disp(std)

[chi2] = chi2_calc(arm_data,f,std);  %the fit is arm-p(3)
disp('chi2 is')
disp(chi2)

disp('chi2 per degree of freedom is')
chi2dof = chi2/length(arm_data);
disp(chi2dof)
end

function [std] = calc_std
load('arm_data_control')
darm = arm_data_control - mean(arm_data_control);
std_arm = abs(darm);
measured = mean(std_arm);
std = sqrt(pi/2)*measured;
end