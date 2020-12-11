function out = repcolmat( m, k )
%REPCOLMAT repeat adjacently the columns of 2D matrix m
%  

[r, c] = size(m);
out = reshape(repmat(m,[k, 1]),[r, c*k]);

return;  % end of repcolmat

