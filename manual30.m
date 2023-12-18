%% MATLAB script that does what DAM file scan does for 30 minute bins 
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

%% Manual 30 

% TO DO: Import your .txt file as a cell array and call it FileDetails

%Assigning variables 
for file_count=1:size(FileDetails,1)
    
    run = FileDetails(file_count,1);
    first_light = cellstr(FileDetails(file_count,2));
    mon_txt = FileDetails(file_count,3);
    header_name = FileDetails(file_count,4);
    monitornumber = FileDetails(file_count,5);
    header_bin = FileDetails(file_count,6);
    header_date = FileDetails(file_count,7);
    date_start = cellstr(FileDetails(file_count,8));

path_to_monitor=join(["changeme", run, "/Monitors/", mon_txt],""); %TO DO user change me
save_path =join(["changeme", run, "/NEW-30/"],""); % TO DO user change me 

% find start point 
monitor_data = importdata(path_to_monitor);
date_correct=strcmp(monitor_data.textdata(:,2),date_start);
time_correct = strcmp(monitor_data.textdata(:,3),first_light);
data_time_correct = date_correct + time_correct;
first_light_on_pos = find(data_time_correct==2); %This should be index of first light 
bin_1_end = monitor_data.textdata(first_light_on_pos+31,3);
last_pos = first_light_on_pos + 14399; % 10 days after (if not 10 days experiment change this)

trimmed_data = monitor_data.data(first_light_on_pos:last_pos,8:39); %trimmed to start end and also 32 channels 
bins_num=importdata("changeme/bins.txt"); % TO DO user change me
bins_num = bins_num +1; %needs to be from end of first bin

for channel=1:32
    result=zeros(480,1); %Assign as 480 at the begining 
    for bin=1:480
            current_bin_start = (bins_num(bin) - 29); %bins go 2-31, 32-61
            current_bin_end = bins_num(bin);
            if current_bin_end == 14401 
                current_bin_end = 14400;
            end
            result(bin,1)=sum(trimmed_data(current_bin_start:current_bin_end,channel));
    end % end of bins 
    
if channel < 10 
    filename = join([save_path, header_name, monitornumber, "0", channel, ".txt"],"");
    header = strjoin([header_name monitornumber "0" channel header_date],"");
    result = [header;480;30;header_bin;result];
    writematrix(result,filename)
else 
    filename = join([save_path, header_name, monitornumber, "", channel,".txt"],"");
    header = strjoin(["",header_name, monitornumber, channel, header_date],"");
    result = [header;480;30;header_bin;result];
    writematrix(result,filename)
end % end of if 
end % end of the channels within that monitor

%track progress
file_count
channel
bin

end %end of the files 

