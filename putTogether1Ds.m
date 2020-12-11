function together = putTogether1Ds(frag,datDir, outpName, header, toDisk  )
% function together = putTogether1Ds(frag,datDir, outpName, header, toDisk  )
% function to read from datDir a group of .mat files *frag*.mat 
% e.g. frag = 'allPar' for the AcIn GNG1 stuff, outpName = 'All' .
% These contain one (long) line of data each, and put them together in a 2D array
% and corresp. files outpName.mat and outpName_[frag].csv
% Default is to write to disk - set toDisk to 0 to just return the array.
% 'header' are the optional column names for the csv output, e.g.
% hd = {'ptID','runID','PrvW','PrvGgW','PrvNGgAL','b_r','frg','precAlpha','F','iLik'}

try, datDir;   catch datDir=[pwd '/'];  end;
try, outpName; catch outpName = 'All'; end;
try, header;   catch header = [];       end;
try, toDisk;   catch toDisk=1; end; % default is to write to disk.

if isempty(outpName); outpName='All'; end;
outpName = [outpName '_' frag(1:end-1)]; % deliberately not the whole 'frag'

cwd = pwd; cd(datDir); 
fList = filesCellArr(pwd,frag,'mat',0);
fNum = length(fList);

together = []; % Array to hold everything
for i=1:fNum
    thisVec = load( fList{i} );
    % Assume each of our *frag*.mat files contains a vector of data:
    vecName = fieldnames(thisVec);
    together(i,:) = eval(  strcat('thisVec.',vecName{1}) );
end

% If results are to be saved to disc, do this in the dir. whence called:
cd(cwd);

if toDisk
    save([outpName '.mat'],'together');
    if isempty(header)
      mat2csv2Dfl(together,[outpName '.csv'],0,1);
    else
      mat2csv2Dfl(together,[outpName '.csv'],0,1,header);
    end
    
end

return; % end of function

