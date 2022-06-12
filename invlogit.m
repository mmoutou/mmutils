function res = invlogit(x, a)
%  logit of x bet. 0 and a. x can be multidim.

try a; catch, a=1; end
    
res = a ./(1+exp(-x));

return;

