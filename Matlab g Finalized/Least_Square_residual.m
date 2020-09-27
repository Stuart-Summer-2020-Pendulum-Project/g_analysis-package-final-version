function [lsr] = Least_Square_residual(x,m)
lsr = sum((x-m).^2);
end