function t = maketimestamp
%
% Returns an irrepeatable number, as a string.
%
% Version: 15 May 2018
%
% Juan Ignacio Mendoza
% University of Jyv?skyl?

pause(1) % ensures that there are no two equal time stamps, since below the seconds are rounded
clock_data_str = num2str(round(clock));
t = clock_data_str( clock_data_str ~= ' ' ); 

end
