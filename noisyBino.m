function MDF = noisyBino(pSucc, U, binN )
% function MDF = noisyBino(pSucc, U, binN )
%  Apply extra uncertainty U to a binomial distro of binN draws w. success
%  param pSucc as per
%  MDF = binopdf(0:n,n,pSuccs); MDF = MDF .^ 1/U ... etc.

n = binN-1;
MDF = binopdf(0:n,n,pSucc);
MDF = MDF .^ (1/U);
MDF = MDF / sum(MDF);

end % of whole functin noisyBino

