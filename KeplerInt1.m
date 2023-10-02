function approxI = KeplerInt1(Y,h)
%KEPLERINT1 Summary of this function goes here
%   Detailed explanation goes here

N = length(Y);
Nodd = rem( N, 2 );
if ~Nodd
    error('Please provide odd Y of odd length.');
end

Ie = (1:((N-1)/2))*2;     % for 4 x
Io = (1:((N-3)/2))*2+1;   % for 2 x
Ye = Y(:,Ie);
Yo = Y(:,Io);

approxI = (h/3)*(Y(1)+Y(N)+4*sum(Ye)+2*sum(Yo)); 

return;

