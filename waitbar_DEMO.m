%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                   Waitbar                                    %
%                                                                              %
%                                                                              %
%                                                   Juan Ignacio Mendoza Garay %
%                                                             doctoral student %
%                                 Department of Music, Art and Culture Studies %
%                                                      University of Jyv?skyl? %
%                                                                  March, 2017 %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Tested with Matlab R2015a

% ==============================================================================
% Description:

% This script shows a way to code the waitbar when using nested loops.

% Notation for loop counters:

% i_0 = outermost loop
% i_1 = loop inside loop i_0
% i_2 = loop inside loop i_1 (and therefore also inside loop i_1)
% i_3a = loop inside loop i_2 (and therefore also inside loop i_2 and i_1)
% i_3b = another loop inside loop i_2 (and therefore also inside loop i_2 and i_1)

% Nested loops increase number.
% Loops nested inside the same loop increase letter. 

% ==============================================================================

clc

% Create a waitbar with a message:
wbar = waitbar(0,'Patience is a virtue.');

% set waitbar's text size:
wbar_axes = findobj(wbar, 'type','axes');
wbar_text = get(wbar_axes,'title');
set(wbar_text,'fontsize',20);

% Set amount of iterations for each loop:
 iter_i_0 = 3;
 iter_i_1 = 4;
 iter_i_2 = 10;
iter_i_3a = 5;
iter_i_3b = 5;

% Set amount of time for each loop:
pausetime = 5; % miliseconds (more than 10 ms starts getting super slow)
pausetime = pausetime/1000; % seconds

% Fraction that the waitbar should advance each time a loop is completed:
wbarfrac = 1/( iter_i_0 * iter_i_1 * iter_i_2 * (iter_i_3a + iter_i_3b));

% Initialise a variable that will acumulate the fractions for display:
wbarcurr = 0; 

% Nested loops:
for i_0 = 1:iter_i_0    
    
    for i_1 = 1:iter_i_1
        
        for i_2 = 1:iter_i_2
            
            for i_3a = 1:iter_i_3a
                pause(pausetime)
                wbarcurr = wbarcurr + wbarfrac;
                waitbar(wbarcurr)
            end
            
            for i_3b = 1:iter_i_3b
                pause(pausetime)
                wbarcurr = wbarcurr + wbarfrac;
                waitbar(wbarcurr)
            end
            
            pause(pausetime)
            wbarcurr = wbarcurr + wbarfrac;
            waitbar(wbarcurr)
        end

        pause(pausetime)
        wbarcurr = wbarcurr + wbarfrac;
        waitbar(wbarcurr)
    end
        
    pause(pausetime)
    wbarcurr = wbarcurr + wbarfrac;
    waitbar(wbarcurr)
end

close(wbar)

