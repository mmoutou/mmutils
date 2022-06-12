function dens = dbetasc(x,a,b,lo,hi)
%DBETASC n samples are generated from the standard betapdf with 
%   A and B as per a, b, after x is
%   mapped to lo - to - high. Good e.g. for MAP priors.
% demo x = rbetascMS(30,0.4,0.2,0.05,0.95); hist(x(:,1); mean(x)
       
  M = length(a); 
  if M ~= length(b)
      error('length(a) ~= length(b)')
  end
  
  X = (x-lo)./(hi-lo);
  
  dens = betapdf(X,a,b);

return;

