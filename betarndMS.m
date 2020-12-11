function sampl = betarndMS (Mean, SD, sizeVec)
% provide random samples from beta distribution with mean M
% and sd SD. These have to be legitimate - no checking done!
% sizeVec is e.g. [1,1000] if output is to be 1 x 1000 matrix
% Fancier e.g.: betarndMS([0.9,0.5,0.2],[0.01, 0.1,0.001],[1,3])
% If sizeVec is not given, default is scalar i.e. sizeVec=[1,1]
    try, sizeVec; catch, sizeVec = [1,1]; end;
    a = (1-Mean).*(Mean.*Mean)./(SD.*SD) - Mean;
    b = a.*(1./Mean - 1) ;
    sampl = betarnd(a, b, sizeVec);
return;