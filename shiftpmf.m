function [binm, sftbnd] = shiftpmf(pm,grbnd,shft)
%SHIFTPMF  Shifting a historgram mass function pm with 1-D grid boundaries grbnd by shft
% shft can be between -1, squishing it to the first bin, up to +1, squishing it to the last
% bin, nearest +1. binm contains the new probability MASSES (NOT DENSITIES) instead of pm along the old grid grbnd,
%    which correspond to the equivalent of pm having been shifted in the new grid sftbnd.
% test with the following, which actually samples from the pmf's from the beginning to make sure:
% pm = [0.0982    0.2313    0.2825    0.2310    0.1077    0.0274    0.0145    0.0074]
% grbnd = [0 0.1 0.2 0.25 0.3 0.4 0.5 0.7  1]; grm = (grbnd(2:end) + grbnd(1:end-1))/2; binw = diff(grbnd);
% shft = 0.25; 
% N=100000; y = pBinSample(pm,N); for k=1:N; y(k)=grm(y(k)); end; 
% histogram(y,grbnd,'normalization','pdf'); [ind bi] = histc(y,grbnd); dens = (ind(1:end-1) ./ binw)/N
% [pmsh, grsh] = shiftpmf(pm,grbnd,shft); ysh=pBinSample(pmsh,N); for k=1:N; ysh(k)=grm(ysh(k)); end;
% histogram(ysh,grbnd,'normalization','pdf'); [indsh bish] = histc(ysh,grbnd); denssh = (indsh(1:end-1) ./ binw)/N

% If empty grid provided, assume evenly spaced one with pm spanning 0 to 1:
if isempty(grbnd);  l=length(pm); grbnd = [0 (1:l)/l];  end

epsi = 1e-6; 
if abs(grbnd(1)) > epsi || abs(1-grbnd(end)) > epsi
    error('grbnd has to be between 0 and 1');
end
grmid = (grbnd(2:end) + grbnd(1:end-1))/2;     % grid mids
midlen = length(grmid);
maxb = 1;  minb = 0; 
grbnd(1)=minb; grbnd(end) = maxb;  % rounding 
sftbnd = grbnd;

%% Shift the historgram boundaries to affect key transform.
if shft > 0
  for k=2:midlen
     sftbnd(k) = grbnd(k) + (1-grbnd(k))*shft;
  end
else
  for k=2:midlen
     sftbnd(k) = grbnd(k)*(1+shft);
  end
end

%% Redistribute the mass acc. in the original grid
binm = zeros(1,midlen);
for binn = 1:midlen
    lob = sftbnd(binn);     
    hib = sftbnd(binn+1);
    if binn==1
        minbin = 1;
    else
        minbin = find(lob >= grbnd, 1, 'last' ); 
    end
    maxbin = find(hib <= grbnd, 1 )-1;
    bnd = lob;
    thisbnd = bnd(1); 
    thisind = minbin+1;
    while grbnd(thisind) > thisbnd && grbnd(thisind) < hib
        bnd(end+1) = grbnd(thisind); 
        thisbnd = grbnd(thisind); 
        thisind = thisind+1;
    end
    bnd(end+1) = hib;
    % proportions in which the stretched bin will contribute
    % to old bins:
    thisprop = diff(bnd); thisprop = thisprop/sum(thisprop);
    for thisind = minbin:maxbin
        binm(thisind) = binm(thisind) + ...
            thisprop(thisind-minbin+1)*pm(binn);
    end
end

%% purge zero densities that may have arisen
binm = (binm+epsi)/sum(binm+epsi); 
        
return;

