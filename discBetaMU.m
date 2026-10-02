function MDF = discBetaMU(M, U, binN )
% function MDF = discBetMS(M, U, binN) Beta distro discretized into binN bins, mean M and concentration 1/U.
%  alternative to noisyBino, with analogous arguments, derived from 
%  discretizing a beta distro with mean=M and and concenration kappa = 1/U,
%  so U is the Dispersion-like parameter.

a = M / U;      % a = mu*kappa = M/U
b = (1-M) / U; 
edges = (0:binN) / binN;

p = diff(betacdf(edges, a, b)); 
MDF = p / sum(p);

return  % end of whole functin discBetaMS

