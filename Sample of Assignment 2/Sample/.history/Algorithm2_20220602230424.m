function [S,N,Z,x] = Algorithm1(Y,Thres,win)
    %Simple segmentation algorithm
    %Input : Y - the signal to be segmented
    %        Thres  - the  threshold value as deciding factor to select point            
    %        win - window size for energy analysis         
    
    N = round(length(Y)/win); % number of framed
    st = 1;
    
    for n= 1:N-1
        
    e = Energy(Y(st:win+st),win);%energy calculation per frames
    z = ZeroX(Y(st:win+st),win,0);%zero crossing rate calculation per frames
    x(n) = e; %array of energy
    Z(n) = z; %array of zero crossing rate
    st = (st+win);   
    %y(n) = x(n)/Z(n); % ratio energy over zero crossing rate, voice and unvoice
    end
    
    zsl=round(sum(Z)/N);%average of zero crossing rate
    et=round(sum(x)/N); %average of energy value 
    
    S =[];
    ind=1;
    for m=1: N-2
       %if (x(m)< Thres) & (x(m+1)>Thres)
       if (x(m) < zsl) & (x(m)> et)    
             S(ind) = m;
             ind=ind+1;       
       end 
    end
    S = S*win;  % segmentation points. convert back to sample unit
    N = length(S);     % number of segmentation points
    end