function D = rowpDkl(rq,rp,check)
% function D = rowpDkl(q,p,check)
%   D(q||p) = sum(q .* ( log(q) - log(p) )) ... for EACH ROW of p and q.
%   where q an p are discrete distro probability vectors or same-shape matrices.

try, check; catch, check=0; end;

if check  % check each sums to 1, within 1e-4
  sq = sum( rq' );
  sp = sum( rp' );
  if max(abs(sq - 1)) > 1e-4 || max(abs(sp-1)) > 1e-4
    error('rows of p and q must sum to 1 to within 1e-4 each');
  end
end

devs = rq .* ( log(rq) - log(rp) );

D = sum(devs');

return; % of whole function rowpDkl
