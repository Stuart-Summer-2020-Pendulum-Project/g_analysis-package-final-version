function data_process(which_peak,space)
load('arm_data_unprocessed')
[t_max,real_peaks,rpks_index,td,arm_data] = peak_finder(15,td,arm_data);
t_begin = t_max(which_peak);                 %change together
index_begin = rpks_index(which_peak);        %change together
t_end = t_max(which_peak+space);             %change together
arm_data(td < t_begin) = [];
td(td<t_begin) = [];
arm_data(td > t_end) = [];
td(td>t_end) = [];

[x0,vx0,z0,vz0,R] = initial_conditions(index_begin);

[t] = time_array_filler(td);

needed_vars = {'arm_data','td','R','z0','t'};
save('arm_data_processed',needed_vars{:})
end