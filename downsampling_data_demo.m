%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                       Comparison of Different Methods                        %
%                                     for                                      %
%                              Downsampling Data                               %
%                                                                              %
%                                                   Juan Ignacio Mendoza Garay %
%                                                             doctoral student %
%                                   Music Department - University of Jyv?skyl? %
%                                                                January, 2017 %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script has been tested with Matlab R2015a

% ==============================================================================
% Description

% Comparison of Different Methods for Downsampling Data
% Method 4 uses Method's 3 interp1 funtion, so Method 3 and 4 are basically the same.
% However, Method 3 should be faster.
% Method 4 requires the Mocap Toolbox.
% Download the Mocap Toolbox from here: 
% https://www.jyu.fi/hum/laitokset/musiikki/en/research/coe/materials/mocaptoolbox

% ==============================================================================
% Instructions

% Parameters that may be changed for exploration are marked with a long arrow
% like this:

% variable_name = value; <------------------------------------------------------ parameter description  

% ==============================================================================
% Initialisation

set(0, 'DefaulttextInterpreter', 'none') % prevents Matlab interpreting underscores (_) as a subscript flag

clc
clear
close all
addpath 'my_drive/MocapToolbox_v1.5' % <---------------------------------------- add path of Mocap Toolbox
addpath(genpath('my_drive/my_folder')) % <-------------------------------------- add path of data or enclosing folder

scrsz = get(groot,'ScreenSize');

% %% ---------------------------------------------------------------------------
% Specify data files and parameters

data_filename = 'accel_test_100Hz.txt'; % <------------------------------------- name of the data file
original_freq       = 100; % <-------------------------------------------------- original sampling frequency in Hz
target_freq         = 10;  % <-------------------------------------------------- target sampling frequency in Hz

% Observations:
% The data file should contain x, y and z vectors in each line.
% Each line should display data sampled at a consecutive regular interval.

% The file accel_test_100Hz.txt has a sample rate of 100Hz.
% In other words, each line has been written at an interval of 1/100 of a second.

% %% ---------------------------------------------------------------------------
% Read data

fid_data = fopen(data_filename,'rt');
data{1,2} = textscan(fid_data,'%f %f %f');
data{1,2} = cell2mat(data{1,2});
length_original_data = size(data{1,2},1);
total_time = length_original_data/original_freq;

% %% ---------------------------------------------------------------------------
% Resampling

labels{1} = 'original';
downsampling_factor = original_freq/target_freq;
data{1,1} = original_freq;
data(2:6,1) = {target_freq};

% %% ...........................................................................
% METHOD 1: downsample function

labels{2} = 'downsample';

tic;
data{2,2} = downsample(data{1,2},downsampling_factor);
computing_times{1} = toc;

% %% ...........................................................................
% METHOD 2: decimate function

labels{3} = 'decimate';

tic;
for i = 1:3
    data{3,2}(:,i) = decimate(data{1,2}(:,i),downsampling_factor);
end
computing_times{2} = toc;

% %% ...........................................................................
% METHOD 3: resample function

labels{4} = 'resample';

tic;
data{4,2} = resample(data{1,2},target_freq,original_freq);
computing_times{3} = toc;

% %% ...........................................................................
% METHOD 4: interp1 function

labels{5} = 'interp1';

tic;
t1 = (0:(length_original_data-1))/original_freq;
t2 = 0:(1/target_freq):t1(end);
data{5,2} = interp1(t1,data{1,2},t2,'linear');
computing_times{4} = toc;

% %% ...........................................................................
% METHOD 5: mcresample function

labels{6} = 'mcresample';

tic;
d = mcinitstruct('MoCap data',data{1,2},original_freq);
d2 = mcresample(d,target_freq);
data{6,2} = d2.data;
computing_times{5} = toc;

% %% ---------------------------------------------------------------------------
% Display computation times :

disp('----------------------------------------------------------')
disp('Computing times:')
disp(' ')
disp(['METHOD 1 (downsample) = ',num2str(computing_times{1}),' sec.'])
disp(['METHOD 2 (decimate)   = ',num2str(computing_times{2}),' sec.'])
disp(['METHOD 3 (resample)   = ',num2str(computing_times{3}),' sec.'])
disp(['METHOD 4 (interp1)    = ',num2str(computing_times{4}),' sec.'])
disp(['METHOD 5 (mcresample) = ',num2str(computing_times{5}),' sec.'])
disp('----------------------------------------------------------')

% %% ----------------------------------------------------------------------------
% Visualize original and downsampled data

close all
fig_1 = figure('Position',scrsz);

% comment/uncomment:
bounds_seconds = []; % <-------------------------------------------------------- visualisation boundaries (in seconds; empty is no bounds)
% bounds_seconds = [85 95];
% bounds_seconds = [0 10];

if isempty(bounds_seconds)==1
    bounds_seconds = [0 length_original_data/original_freq];
end

for i = 1:6
    subplot(6,1,i);
    bounds_samples = round(bounds_seconds* data{i,1});
    bounds_samples(1) = bounds_samples(1) + 1;
    plot(data{i,2}(bounds_samples(1):bounds_samples(2),:))
    set(gca,...
        'ylim',[min(min(data{i,2}(bounds_samples(1):bounds_samples(2),:))) max(max(data{i,2}(bounds_samples(1):bounds_samples(2),:)))],...
        'xlim',[1,size(data{i,2}(bounds_samples(1):bounds_samples(2),:),1)],...
        'xtick',[0:(10*data{i,1}):size(data{i,2}(bounds_samples(1):bounds_samples(2),:),1)],...
        'xticklabel', [ bounds_seconds(1) : 10 : bounds_seconds(2) ]...
         )
    xlabel('seconds')
    title(labels{i})    
end

