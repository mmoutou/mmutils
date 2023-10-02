function dens = dbetasc(x,a,b,lo,hi)
%DBETASC prob density of the standard betapdf with 
%   A and B as per a, b, after x is
%   mapped to lo - to - high. Good e.g. for MAP priors.

  M = length(a); 
  if M ~= length(b)
      error('length(a) ~= length(b)')
  end
  
  z = hi-lo;  % normalizing constants
  X = (x-lo)./ z;
  
  dens = betapdf(X,a,b) ./ z;
  
return;

