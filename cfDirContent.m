function [inAnotB, inBnotA, inBoth] = cfDirContent( dirA, dirB, nameFrag, ext, NdigOnly)
% function [inAnotB, inBnotA] = cfDirContent( dirA, dirB, nameFrag, ext, NdigOnly)
% Use function filesCellArr to find the files *'nameFrag'*.'ext' that are in 
% dirA which aren't in dirB and vice versa; return two cell arrays with
% same and one with the overlapping file names acc. to the criterion used.
% If NdigOnly is not zero, instead of the whole filename only the first NdigOnly
% digits of the filename will be looked at. This is useful for overlapping but
% not identical file names.

try, NdigOnly; catch NdigOnly=0; end

lsA = filesCellArr(dirA,nameFrag,ext);
lsB = filesCellArr(dirB,nameFrag,ext);
if NdigOnly
  for i=1:length(lsA); lsA{i} = lsA{i}(1:NdigOnly); end;
  for i=1:length(lsB); lsB{i} = lsB{i}(1:NdigOnly); end;
end

lenA = length(lsA);  lenB = length(lsB);
inAnotB = {};        inBnotA = {};        inBoth = {};

% ~~~~~~~~~~~~~~~ Files in dirA but not in dirB :
notFoundN = 0;
for fNumA = 1:lenA
  thisF = lsA{fNumA};
  found = 0;
  
  for fNumB = 1:lenB % Look for it & record where in lsB
    if strcmp(thisF, lsB{fNumB})
      found = fNumB; 
    end % If found, record where in lsB
  end
  
  % If this file of lsA not found in B, record:
  if ~found
    notFoundN = notFoundN + 1;
    inAnotB{notFoundN} = thisF;
  end
  
end % filling in inAnotB

% ~~~~~~~ Now do the same the other way round  ... 
% ~~~             ... and also those found in both  :
notFoundN = 0;    inBothN   = 0;

for fNumB = 1:lenB
  thisF = lsB{fNumB};
  found = 0;
  
  for fNumA = 1:lenA % Look for it & record where in lsA
    if strcmp(thisF, lsA{fNumA})
      found = fNumA;       
      
      % Keep detailed record of files with overlapping names:
      inBothN = inBothN + 1;
      cwd = pwd;
      cd(dirA);
      inBoth{inBothN}{1} = ls([lsA{fNumA} '*']);
      cd(dirB);
      inBoth{inBothN}{2} = ls([lsB{fNumB} '*']); 
      inBoth{inBothN}{3} = strcmp(inBoth{inBothN}{1}, inBoth{inBothN}{2});            
      cd(cwd);
      
    end 
  end
  
  % If this file of lsB not found in A, record:
  if ~found
    notFoundN = notFoundN + 1;
    inBnotA{notFoundN} = thisF;
  end
  
end % filling in inBnotA



end % of whole function