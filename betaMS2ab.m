function [a, b] = betaMS2ab (Mean, SD)
    a = (1-Mean).*(Mean.*Mean)./(SD.*SD) - Mean;
    b = a.*(1./Mean - 1) ;
return;