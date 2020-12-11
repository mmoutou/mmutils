function mo = pmfMoment(x,P,n)
% function mo = pmfMoment(x,P,n)
% take a row vector of values x, and the corresponding probabilities P
% forming a probability mass function, and return its nth moment
% about the mean, \sum (P(j)*( (x(j)-xm)^n )). If n=1 return the mean itself.

if (size(x,1)~=1 || size(P,1)~=1 || size(x,2)~=size(P,2)) 
  error(['pmfMoment needs row matrices x and P and P must have equal no. of' ...
         ' elements']);
elseif nargin ~= 3
    error('pmfMoment needs 3 arguments')
end
N = size(x,2);

% first calculated the mean, which will always be used:
xm = 0.0;
for j=1:N
  xm = xm + P(j)*x(j);
end

if n==1
  mo = xm;  % for n=1 return the mean.
else
  mo = 0.0;
  for j=1:N
    mo = mo + P(j)*( (x(j)-xm)^n );
  end
end



