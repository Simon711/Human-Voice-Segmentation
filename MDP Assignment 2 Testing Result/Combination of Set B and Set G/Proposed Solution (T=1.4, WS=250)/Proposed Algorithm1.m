function [S,N] = Algorithm1(Y,Thres,win)
      %Simple segmentation algorithm
      %Input : Y - the signal to be segmented
      %        Thres  - the  threshold value as deciding factor to select point            
      %        win - window size for energy analysis         
      
      N = round(length(Y)/win); % number of framed
      st = 1; % start index of the window
      for n= 1:N-1 % loop for each window
            e = Energy(Y(st:win+st),win); %energy calculation per frames
            x(n) = e; %array of energy
            st = (st+win); %incrementing the start point
      end
      
       
      S =[]; %initialize the segmentation array
      ind=1; %initialize the index
      for m=1: N-2 % loop for segmentation
         if (x(m)< Thres) && (x(m+1)>Thres) %if the energy is less than threshold and the next energy is greater than threshold
             S(ind) = m-1; % start of segment
             ind=ind+1; % index of segment
         elseif (x(m)> Thres) && (x(m+1)<Thres) %if the energy is greater than threshold and the next energy is less than threshold
             S(ind) = m-1; % start of segment
             ind=ind+1; % index of segment
         end 
      end
      S = S*win;  % segmentation points. convert back to sample unit
      N = length(S);     % number of segmentation points
end
