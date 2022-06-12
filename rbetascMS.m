function samp = rbetascMS(n,fractionalMean,fractionalSD,lo,hi)
%RBETASCMS n samples are generated from the standard beta distro with 
%   M and SD as per fractionalMean etc., but then the distro is
%   mapped to lo - to - high. Good e.g. for avoiding extreme values
%   in recovery studies. 
% demo x = rbetascMS(30,0.4,0.2,0.05,0.95); hist(x(:,1); mean(x)
       
  M = length(fractionalMean); 
  if M ~= length(fractionalSD)
      error('length(fractionalMean) ~= length(fractionalSD)')
  end
  a = (1-fractionalMean).*(fractionalMean.*fractionalMean)./ ...
               (fractionalSD.*fractionalSD) - fractionalMean;
  b = a.*(1./fractionalMean - 1) ;
  
  samp = zeros(n,M);
  for k=1:M
      samp(:,k)= betarnd(a(k),b(k),n,1)*(hi(k) - lo(k)) + lo(k);
  end

return;

