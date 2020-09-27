function [t_max,real_peaks,rpks_index,td,data] = peak_finder(w,td,data)

[pks,locs] = findpeaks(-data);  %find -data max which is min
real_peaks =[];
rpks_index = [];

for i= (w+1):(length(pks)-w)
    [max_val,rel_pos] = max(pks(i-w:i+w));
    pos = (i-w) + (rel_pos-1);
    if pks(i) == max_val
        real_peaks = [real_peaks, pks(i)];
        rpks_index = [rpks_index, locs(pos)];
    else
        %pass
    end
end
t_max = td(rpks_index);
end