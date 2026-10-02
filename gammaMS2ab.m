function [a, b] = gammaMS2ab (Mean, SD)
% a, b of the gamma distro derived from its mean and sd
  
  if Mean <= 0 || isnan(Mean)
    error(['Mean=' num2str(Mean) ' is invalid']);
  end
  if SD <= 0 || isnan(SD)
    error(['SD=' num2str(Mean) ' is invalid']);
  end
  
  a = (Mean*SD)^(2/3);
  b = Mean/a;
  
return;
