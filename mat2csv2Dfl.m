function mat2csv2Dfl(mIn, outpFName, show, write, header)
% function mat2csv2Dfl(mIn, outpFName, show, write, header)
% Take a 2-D double-prec. array a la matlab and write it to disk 
% in a csv format. header is an optional cell arr of the form
% {'Var1name','Var2name' ... }
% Can be used just to show header with columns, if show=1, write=0.

try, header; catch header={'NOHEADER'}; end; % default is no header
try, write; catch, write=1; end; % default is to write to disk
try, show; catch, show=0; end; % default is 
  
sepStr = ',';
if size(size(mIn),2) ~= 2
  disp(' '); disp(' ERROR: mat2csv2Dfl needs a 2-D input array'); disp(' ');
elseif write
  rN = size(mIn, 1); cN=size(mIn, 2);
  
  csvFID = fopen(outpFName,'w');
  
  if ~strcmp(header{1},'NOHEADER') % if there is a valid header, format it and print it.
    for i=1:length(header)
      if i~=1; fprintf(csvFID,sepStr); end;
      fprintf(csvFID,'"%s"',header{i}); 
    end
    fprintf(csvFID,'\n');
  end
  
  for i=1:rN
    for j=1:cN
      if j ~= 1; fprintf(csvFID,sepStr); end; % separator bef. every col except 1st
      fprintf(csvFID,'%f',mIn(i,j));
    end
    fprintf(csvFID,'\n'); % end of row newline
  end % end rows

  fclose(csvFID);
end % if no input errors

% We may want a display of the matrix at the command line.
if show; disp(' '); disp(header);  disp(mIn); end;

end % of mat2csv2Dfl