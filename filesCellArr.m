function fileNameCellArr = filesCellArr( Dir, nameFrag, ext, toSaveToDisk, warnWindoze )
% function fileNameCellArr = filesCellArr( Dir, nameFrag, ext, toSaveToDisk )
% Create a cell array of strings with all the files with extention 'ext'
% (not including the dot) and whose name contains string nameFrag
% to be found in directory Dir. Similar to listFiles, but strips end empty
% chars etc.

try, Dir; catch Dir = pwd; end;
try, nameFrag; catch nameFrag=''; end;
try, ext; catch ext = 'mat'; end;
try, toSaveToDisk; catch toSaveToDisk=0; end;
try, warnWindoze; catch warnWindoze = 0; end;

% preliminaries
fCArr = {};
extLen = length(ext);
wildName = ['*' nameFrag '*'];
if ~isempty(ext);   wildName = [wildName '.' ext]; end;
cwd = pwd;

% Move to the dir. in question and list the relevant files:
cd(Dir);
thisComputer = computer;

if ~isempty(strfind(thisComputer,'WIN'))  || ~isempty(strfind(thisComputer,'redhat-linux'))  
  % We are in Windoze or redhat - for some bizarre reason it seems
  % to work OK in CentOS redhat ... ?!
  try 
    fStrMat = ls(wildName);
  catch
    fileNameCellArr = {};
    warning(['No ' wildName ' files found ...']);
 
    return;
  end
  if warnWindoze; warning('filesCellArr may be operating in Windows'); end;
elseif ~isempty(strfind(thisComputer,'GLNX')) || ~isempty(strfind(thisComputer,'linux-gnu')) 
        % we are in matlab Linux or in octave running e.g. in a VM ubuntu 16 ... :-( 
  try
    fStrMat = ls_ms( ls(wildName,'--format','single-column') );
  catch
    fStrMat = ls(wildName,'--format','single-column');  % for matlab running in CentOS and such like ...
  end
  if length(fStrMat) < 1   % ie other failure of ls / ls_ms commands ... :-(
    fileNameCellArr = {};
    warning(['No ' wildName ' files found ...']);
    return;
  end
else
  error('not ready for this ''computer'' ');
end


% Now strip any trailing white spaces from the file names
for i=1:size(fStrMat, 1)
    fCArr{i} = fStrMat(i,:);
    if ~isempty(ext) % actively look for the ext string
      while ~strcmp(fCArr{i}(end-extLen+1:end),ext)
        fCArr{i} = fCArr{i}(1:end-1);
      end
    else % just strip ' ' characters, if any:
      while length(fCArr{i}) > 0 && strcmp(fCArr{i}(end),' ')
        if length(fCArr{i}) > 1
           fCArr{i} = fCArr{i}(1:end-1);
        else  % there is only one element, and that is a blank :-( 
           fCArr{i} = []; 
        end
      end
    end
end

fileNameCellArr = fCArr;

cd(cwd);

if toSaveToDisk
    save('lsCellArr.mat','fileNameCellArr');
end

end % of whole function


