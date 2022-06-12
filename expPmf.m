function pmf = expPmf(dec,peak, N, floorConst)
%EXPPMF exponentially reducing probability vector with N elements off its 'peak'
%   pmf = expPmf(dec,peak, N, floorConst)
%       floorConst: floorConst/N is the noise floor - exp. decay applies above this.

if peak < 1 || peak > N; error('''peak'' out of range'); end
try 
    if floorConst < 0; error('floorConst has to be +ve'); end
    if floorConst > 1; error('floorConst has to be <1'); end
catch
    floorConst = 0;
end

exmass = 1 - floorConst; % the mass of the pm excluding the floor

exv = [flip(0:(peak-1)) ,1:(N-peak)] ; % vector of exponents
pmf = (dec .^ exv); 
pmf = exmass * pmf / sum(pmf);
pmf = floorConst / N + pmf;

return;

