# sleep_analysis
MATLAB script to crop DAM sleep data into bespoke 30 minute bins 

% Hannah Clarke - DRI Fly Lab Cardiff 
% Updated: 06/06/2023

%AIM: 
% Take monitor file - trim to start and end 
% Set own bin start and ends that are different to 0 or 30 past the hour
%export in the same format as DAM File Scan software 

%% USER input needed
% For this code to work the user must create a text file (.txt) with columns
% referring to the following  (Call it FileDetails)

%1:Run - this must be the name of the directory that your monitor files for
%that run were saved e.g. if the path to the monitor folders was
%/Run1/monitors this variable would be Run1
%2:First light on - when the light first comes on - in the format of
%09:00:00 for instance 
%3:Mon_txt - what is the name of the monitor file e.g. Monitor1.txt
%4:Header Name - this is the prefix of what you called your 1 minute DAM
%file Scan output e.g. Run1Ct
%5:Monitor number - Monitor number in short hand e.g. M001C or M012C
%6:Header_bin - The end of the first bin e.g. if lights came on at 9am this
%value will be 0930. If they came on at 9:01 this would equal 09:31
%7:Header Date: Date of light coming on in long e.g. 06 Jun 2023
%8:Date_start - Date in short where the flight first comes on e.g. 6 Jun 23

%Please see example txt file in repo (FileDetails_example.txt)

%Paths need to be changed 
% User needs to change start of path_to_monitor and save_path (lines 48 and
% 49) as well as path in bins_num (line 66)

%User also needs to create a file with the Bins needed (call it bins.txt)
%see Bins_example.txt this has 30 mins bins for the experiment 
