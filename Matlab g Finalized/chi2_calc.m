function [chi2] = chi2_calc(y,f,std)

chi2 = sum( (y-f).^2./(std.^2));