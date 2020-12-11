function D = discrDkl(q,p,check)
% function D = discrDkl(q,p,check)
%   D(q||p) = sum(q .* ( log(q) - log(p) )) ...
%   where q an p are discrete distro probability vectors or same-shape matrices.

try, check; catch, check=0; end;

if check  % check each sums to 1, within 1e-4
  sq = sum( reshape(q,1,numel(q)) );
  sp = sum( reshape(p,1,numel(p)) );
  if abs(sq-1) > 1e-4 || abs(sp-1) > 1e-4
    error('In Dkl(p||q), p and q must sum to 1 to within 1e-4 each');
  end
end

D = sum(q .* ( log(q) - log(p) ));
while numel( D) > 1;  D = sum(D);  end

return; % of whole function  
