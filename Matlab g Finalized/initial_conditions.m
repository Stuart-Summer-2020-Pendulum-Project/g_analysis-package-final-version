function [x0,vx0,z0,vz0,R] = initial_conditions(index_begin)
[td,z_data,R] = z_data_gen;
dt = td(index_begin+1) - td(index_begin-1);
z0 = z_data(index_begin);
vz0 = (z_data(index_begin+1) - z_data(index_begin-1))/dt;
safety = 0.000;
R = (1/1000)*R + safety;
x0 = sqrt(R^2 - z0^2);
vx0 = (-z0*vz0)/x0;

    function [td,z_data,R] = z_data_gen
        
    R = input('Enter length of pendulum (mm) ');                                  
    
    load('distance_data')
    [t_max_d,real_peaks_d,rpks_index_d,td,d_data] = peak_finder(15,td,d_data);
    mins = -real_peaks_d;
    h0 = mean(mins);
    z_data = d_data - (R + h0);
    z_data = (1/1000)*z_data;
    end
end