
% this script will read segmentation point in unit second and plot 
% them with the pattern
% ADD : CALCULATE FIND THE PERFORMANCE FOR ALL



%open fail
Filename = {'0075','1206','2433','3630','4137','5580','6255','7565','8299','9472'};
Folder1='./pattern/';    % folder of the pattern
Folder2='./refpoint/';   % folder consist the reference point files

FOut = fopen('./result/record.txt','wt')
Fs = 16000; % sampling rate

%Experimetal parameters
Time = 0.01:0.01:0.10;   %time tolerence, between 0.01 - 0.1
Threshold = 2.0; %1.8/1.9/2.0/2.1
Winsize = 250; %250/300/350





for i=1:10 %loop for time tolerance

   N = 0;   % total nummber of auto segmentation points
   P = 0;    % total number of manual / reference segmetation points;
   M = 0;   % ttal number of match;

   %printf the parameters infomations in the file
   fprintf(FOut,' Information on all %d patterns');
   fprintf(FOut,'\tTime Tolerence = %1.2f',Time(i));
   fprintf(FOut,'\tThreshold = %1.2f',Threshold);
   fprintf(FOut,'\tWin Size = %d\n\n',Winsize);
   fprintf(FOut,'\tRate-->  \tP(M)\tP(O)\tP(I)\n');
   for n=1:length(Filename) % number of files in the folder1 
       
      %open reference points per pattern (points in seconds)
      FILE1 =strcat(Folder2,char(Filename(n)),'.SEG');
      f1=fopen(FILE1,'r');
      S1 = fscanf(f1,'%g');
      S1 = S1 * Fs;   % convert to sample unit
         
      %open TEST file per pattern
      FILE2 = strcat(Folder1,char(Filename(n)),'.wav');
      Y = audioread(FILE2);
      
      %calculate the automatic segmentation / call function
      [S2 K] = Algorithm1(Y,Threshold,Winsize);
            
      %plot the file with segmentation points (both reference and manual)
         %figure('Name',char(Filename(n)),'NumberTitle','on')
         %PlotSegment2(Y,S1,S2);         
      
      % find total N
         N = N + K;

         %find Match and find total M
      Match = Find_Match(S1,S2,Time(i));
      M = M + Match;

      % print into file individual perfromance
      % 8 is number of reference segmentation points per pattern
      PM = Match/8; % Match rate 
      PO = (8-Match)/8 % Omission Rate
      PI = (K-Match)/K;  % Insertion Rate
         
      fprintf(FOut,'\tPattern %d\t%2.2f \t%2.2f \t%2.2f\n',n,PM,PO,PI);
      
      %pause; 
      %empty variables
      clear Y;
      clear S1;
      clear S2;
   end
         
               
      % find total P 
         %For each pattern P=8 so, total P = 8*n 
         % where n is number of pattern tested
         P = 8*n;
         
            
      %calculate the performance
      MatchRate     = M/P;        
      OmissionRate  =(P-M)/P;
      InsertionRate =(N-M)/N;
      
      
      %print into file
      fprintf(FOut,'\n\nTotal P: %d Total N: %d Total M: %d\n',P,N,M);      
      fprintf(FOut,'Total Match Rate = %2.2f\n',MatchRate);
      fprintf(FOut,'Total Omission Rate = %2.2f\n',OmissionRate);
      fprintf(FOut,'Total Insertion Rate = %2.2f\n',InsertionRate);

      %parameter to save the whole match rate for all patterns
      Wmatch(i) = MatchRate;
      Winsertion(i) = InsertionRate;
      Wommision(i) = OmissionRate;

end %loop for time tolerance

   % print all match, insertion and omission in a file
   fprintf(FOut, '\n Match Rate:\n');
   for x=1:10
      fprintf(FOut, '%2.2f\n', Wmatch(x));
   end
   fprintf(FOut, '\n Insertion Rate:\n');
   for x=1:10
      fprintf(FOut, '%2.2f\n', Winsertion(x));
   end
   fprintf(FOut, '\n Omission Rate:\n');
   for x=1:10
      fprintf(FOut, '%2.2f\n', Wommision(x));
   end

   
  
    
    fclose(f1);   
    fclose(FOut);
    disp('end');

    
    % sgtitle('Performance indicator experiment on Threshold');
    sgtitle("Window Size = 250, Threshold = " + Threshold);

    subplot(3,1,1); 
    plot(Time, Wmatch, 'LineWidth', 2); 
    title('Match Rate');

    subplot(3,1,2); 
    plot(Time, Winsertion, 'LineWidth', 2); 
    title('Insertion Rate');

    subplot(3,1,3); 
    plot(Time, Wommision, 'LineWidth', 2); 
    title('Omission Rate');
 
 
    % experiment variable => the value we change or test on
    % control variable => the value we keep it no change