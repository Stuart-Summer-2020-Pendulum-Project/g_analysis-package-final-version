function [td_gen] = time_array_filler(td)
% goes by (n-1)*10 + 1 for td_gen array size
td_gen = [];
for i = 1:length(td)-1
    ts = td(i+1) - td(i);
    attach = [td(i):(ts/10):td(i+1)];
    td_gen = [td_gen attach];
    td_gen(end) = [];
end
td_gen = [td_gen td(end)];