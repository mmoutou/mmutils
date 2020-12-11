function ind1D = arVecInd( stride, iVec )
% 
% arVecInd just gives the vectorial index of an array with a certain 
%  Stride, where the first element of the stride vector which is 1 is ommitted
%   for speed. This is a matlab version, so indices start from 1 not 0. 
%   in ind1D = arVecInd( stride, iVec ) , iVec is the vector of indices along all dim of 
%   the array

  dimN = length(iVec);
  if (dimN ~= length(stride)+1) 
     error('Stride size has to be 1 less than dim. no. in arVecInd'); 
  end

  ind1D = iVec(1);
  for i=2:dimN
    ind1D = ind1D + stride(i-1)*(iVec(i)-1);
  end

return;