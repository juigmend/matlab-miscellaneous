
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                  CHANGE ALL FILE-NAME EXTENSIONS IN A FOLDER                 %
%                                                                              %
%                                5 February 2018                               %
%                                                                              %
%                          Juan Ignacio Mendoza Garay                          %
%                               doctoral student                               %
%                 Department of Music, Art and Culture Studies                 %
%                            University of Jyv?skyl?                           %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script has been tested with Matlab R2015a

% ==============================================================================

% DESCRIPTION:
%   Replaces all extensions of a kind ("old extension") with another extension
%   ("new extension") in a folder.
%   The extension itself should be preceded with a dot.
% For example, if the extension is 'm', it should be written as '.m'

% INSTRUCTIONS:
%   Edit parameters indicated with an arrow (<---)

% ==============================================================================
% clear
clc

     dir_name = '/Users/despicableme/Documents/Myproject/'; % <--- folder name
old_extension = '.M';                                       % <--- old extension
new_extension = '.m';                                       % <--- new extension

%...............................................................................

cd (dir_name)
dir_info = dir(dir_name);
files_n = length(dir_info);

for i = 1:files_n
    [~,this_name,this_extension] = fileparts(dir_info(i).name);
    if strcmp(this_extension,old_extension)
        movefile([this_name,old_extension],[this_name,'.m_bad']);
        movefile([this_name,'.m_bad'],[this_name,new_extension]);
    end
end