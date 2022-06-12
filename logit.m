function res = logit(x, a)
%  logit of x bet. 0 and a. x can be multidim.

try a; catch, a=1; end
    
if sum( a < x) 
    error(['All elements of x need to be < ' num2str(a)]);
end
if sum( 0 > x) 
    error('All elements of x need to be >= 0' );
end

res = log( x ./ (a-x));

return;

