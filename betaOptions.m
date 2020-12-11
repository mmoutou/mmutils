function Outp = betaOptions(nBins,nLevs,diskName)

 try
   nBins;
 catch
   nBins=5;
 end
 try
   nLevs;
 catch
   nLevs = 5;
 end
 try
   diskName;
 catch
   diskName=[];
 end
 
 % levels of options
 pMin = 1.025/nLevs; pMax=0.99; dp = (pMax-pMin)/(nLevs-1);
 pLevs = (pMin:dp:pMax);
 % tolerance for approximation good enough :
 pTol  = dp/20;          
 
 % midpoints of bins
 binMid = 0.5/nBins : 1/nBins : 1-0.5/nBins;
 binEnd = 1/nBins: 1/nBins : 1;
 % grid with approximate params and corresponding distances
 % between the resulting peakP of the option histogram and the
 % desired peak value
 distGrid = 2*ones(nLevs,nBins);  % init to invalidly big values
 alpha = nan(nLevs,nBins);        % To contain best beta-distro
 beta  = alpha;                   % params for each level
 
 Nmin = 2.05; 
 amin = 1.005;
 Nstep=2.0;
 gridSize = 99;
 
 for pLev=1:nLevs   % for each level
   
   for bin=1:nBins  % actually could search over only half and flip ..,
     a = amin;
     N = Nmin;
     da = (N-2*amin)/gridSize;
     
     while distGrid(pLev,bin) >= pTol
       b=N-a; 
       % find peak of probability histogram
       pBars = (betacdf(binEnd, a,b) - [0, betacdf(binEnd(1:end-1),a,b)]);
       peakBin = find(pBars==max(pBars));
       
       if peakBin == bin
         peakP   = pBars(peakBin);
     
         distP = abs(pLevs(pLev)-peakP);
         if distP < pTol
           distGrid(pLev,bin) = distP;           
           alpha(pLev,bin) = a;
           beta(pLev,bin) = b;
         end
         
       end
       a = a + da;
       % If we've got too near N and found nothing, do some resetting:
       if (N-a < amin) && distP >=pTol 
         N=N+Nstep; a=amin; 
         da = (N-2*amin)/gridSize;
       end
     end
   
   end % end for all the bins at this level
   
   Nmin = Nmin+Nstep;
   
 end
 
 % Make sure middle option is symmetric
 if rem(nBins,2)==1
      mbin = (nBins+1)/2;
      alpha(:,mbin) = 0.5*(alpha(:,mbin) + beta(:,mbin));
      beta(:,mbin) = alpha(:,mbin);
 end
 
 % final output and writes to disk:
 % parameters to output structure:
 Outp.abArr = [];   Outp.abArr(:,:,1) = alpha;    Outp.abArr(:,:,2) = beta;
 % histograms to output structure:
 pArr = [];
 for pLev=1:nLevs   % for each level
   for bin=1:nBins 
     pArr(:,pLev,bin) = ...
         (betacdf(binEnd, alpha(pLev,bin),beta(pLev,bin)) - ...
          [0, betacdf(binEnd(1:end-1),alpha(pLev,bin),beta(pLev,bin))]);
   end
 end
 Outp.pArr = pArr;
 
 % record to disk if need be:
 if ~isempty(diskName)
   fNstem = [diskName,num2str(nBins),'x',num2str(nLevs)];
   mat2csv2Dfl(alpha,[fNstem 'al.csv'],0,1);
   mat2csv2Dfl(beta,[fNstem 'be.csv'],0,1);
   Outp.NB=['made with betaOptions.m. pArr cols=histograms, rows= bin of peak P, pages=peak prob. levels. So one option is pArr(:,confidence,place)'];
   save(fNstem,'Outp');
 end

 end % of whole fn