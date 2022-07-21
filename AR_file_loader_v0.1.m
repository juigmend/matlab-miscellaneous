%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                        File Loader for Audiofile Rating                      %
%                                  version 0.1                                 %
%                                                                              %
%                                                   Juan Ignacio Mendoza Garay %
%                                                             doctoral student %
%                                 Department of Music, Art and Culture Studies %
%                                                      University of Jyv?skyl? %
%                                                                  March, 2017 %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script has been tested with Matlab R2015a and Macintosh OS 10.11.6

% ==============================================================================
% Description:

% This script loads plain text files with extension .txt into a matrix.

% The .txt files should have only one value (an integer number) on each row and 
% should be labelled as follow: 'pX.txt' (without the quotes),  where the X is 
% an integer number. All the .txt files should have the same amount of rows. 

% The resulting matrix is called 'data' and will have the values for each .txt
% file in each of its columns. For example:
% data(:,1) is all values in file p1.txt;
% data(:,2) is all values in file p2.txt.

% ==============================================================================
% Initialisation:

clc
clear
close all

% ==============================================================================
% Load files:

datadir = ('/MYDRIVE/MYFOLDER'); % directory where the files are
addpath(genpath(datadir)) % add path of the directory
textfilesindir = dir([datadir,'/*.txt']); % finds all .txt files in the directory

counter = 1;
for i = 1:size(textfilesindir,1) % go through all .txt files
    [~,filenames{i},~] = fileparts(textfilesindir(i).name); % extract the file names without path or extension
    partnums(i) = strtok(filenames(i),'p');% extract the part of the filename after the p (should be the "participant number")   
    if isfinite(str2num(partnums{i})) == 1 % check if the participant number is actually a number or something else
        data(:,counter) = importdata(textfilesindir(i).name); % load the data from the .txt file into the 'data' matrix
        counter = counter + 1;
    end
end
