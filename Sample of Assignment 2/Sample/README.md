
This is a readme file on how to use the sample script

Description of some important files

1. script2.m  
    This is the main file to be executed. The file will call the segmentation algorithm,perform evaluations and print the result in the report.txt in the [result] folder.

2.  Energy.m 
    The energy function. This file is called from file Algorithm1.m. The function receive Y, the signal and P the window size. It will return the energy per frame

3. Algorithm1.m //Algorithm2.m is the enhanced and solved the problem in Algorithm1.m
    The file is the segmentation algorithm used in the class example. This will be the benchmark algorithm. This function is called from script2.m. 
    The function receive Y, the signal, Thres  which is the  threshold value as deciding factor to select segentation point and win, the window size. 
    It will return the list of automatic segmentation and number of auto segmentation points

4. Find_Match.m
   Purpose is to find the Match points given the segmentation points and reference points. 
   The function receive V, the reference points and U, the segmentation points and alos Time tolerence in second. 
   It will return the number of Match within the given time tolerence.


What you need to do

1. All modifications (to change experimental parameters) are in script2.m 
2. Try your data with the bench-mark algorithm (Algorihm1)
3. Test with different Threshold, Time Tolerence
4. Get the Match Rate,P(M) Omission Rate,P(O) and Insertion Rate,P(I) at the folder [result] file record.txt.
5. use different threshold.
6. Use diffeent time tolerence {0.0, 0.04, 0.08,0.12,0.16.0.2 }
7. For each test copy the result and plot all the perfromance.
8. Conclude your experiment for the bench mark algorithm.
9. Repeat 1 - 8 using your own algorithm.
10. Compare and report your work.

**Note: This sample code only give you one run for all the patterns in the file using one parameter set.
**       It is faster if you could enhanced the code to run all the parameter sets with one run. (think about it). 

Changes you may want to make

1. File names list and position/directory. Line 8-10
2. Experiment parameters. Line 16 - 18
3. The Algorithm. Line 44 (create a new algorithm function and the function)
    
Other placess that you may need to.
