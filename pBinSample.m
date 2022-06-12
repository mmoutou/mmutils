function sampled = pBinSample( pBin, sN, norm )
% function sampled = pBinSample( pBin, sN, norm )
%  Draw sN samples from the mdf defined by pBin i.e.
%  return values from 1 to length(pBin);
%  consider pBin to be a mass density function 
%  and sample a bin. Assume pBins is normalized,
%  unless norm ~= 0 .

try, norm;  catch    norm=0; end;
if   norm;  pBin = pBin / sum(pBin); end;
try, sN;    catch sN=1; end;

% N = length(pBin);

pCum = cumsum(pBin);
sampled=zeros(1,sN);
rp   = rand(1,sN);

for i=1:sN
  sampled(i) = find(pCum >= rp(i),1);
end

%i = 1;
%while i <= N
%    if rand() <= pBin(i)
%        sampled  = i;
%        i = N+1;  % i.e. finished
%    else
%        i = i+1;
%        pBin(i:N) = pBin(i:N)/sum(pBin(i:N));
%    end
%end


end

