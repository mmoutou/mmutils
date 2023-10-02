function P = psoft(q, bet)
% P = psoft(q, bet)
% Provide a vector of probabilities P for action choices 1...length(q)
% if the action values for said actions are q and the inv. temp is bet=1/T

dq = bet*(q - max(q));
P = exp( dq - log(sum(exp(dq))) );

return;
