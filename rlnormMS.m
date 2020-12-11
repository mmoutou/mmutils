function samples = rlnormMS( n, Mean, SD)
%RLNORMMS  1-d vector of samples from lognormal distribution with 
% mean > 0 and sd > 0 in terms of these, mean
% and sd, rather than the mean and sd of log(x)

if Mean <= 0 || SD <= 0
    error('Ensure Mean > 0 and SD > 0 for lognormal distros');
end

c =  log(1+ (SD/Mean)^2);
meanLog = log(Mean) - c/2;
sdLog   = sqrt(c);

samples =  lognrnd(meanLog, sdLog, 1, n);

return;

