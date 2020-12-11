function mat2blar2Dfl(mIn, outpFName, Ver)
% Take a 2-D double-prec. array a la matlab and write it to disk 
% in a blitz++ friendly format
% Ver argument added as older (pre-2012) version of blar had simpler first
% line e.g. 30 x 66 (older) rather than (1,30) x (1,66) (newer)
try
    Ver
catch
    Ver=2; 
end

sepStr = '\t';

maxIDdig = ceil(log(max(mIn(:,1))/log(10)));  
formID = ['%' num2str(maxIDdig) '.0f'];

if size(size(mIn),2) ~= 2
  disp(' '); disp(' ERROR: mat2blar2D needs a 2-D input array'); disp(' ');
else
  rN = size(mIn, 1); cN=size(mIn, 2);
  header = [sprintf('%d',rN),' x ',sprintf('%d',cN)];
  if Ver > 1
      header = ['(1,',sprintf('%d',rN),') x (1,',sprintf('%d',cN),')'];
  end
  blarFID = fopen(outpFName,'w');
  fprintf(blarFID,'%s\n[',header);
  
  for i=1:rN
    fprintf(blarFID,sepStr);
    fprintf(blarFID,formID,mIn(i,1));
    for j=2:cN
      fprintf(blarFID,sepStr);
      fprintf(blarFID,'%f',mIn(i,j));
    end
    if i ~= rN; fprintf(blarFID,'\n'); end;
  end % end rows

  fprintf(blarFID,' ]');
  fclose(blarFID);
end % if no input errors

end % of mat2blar2Dfl