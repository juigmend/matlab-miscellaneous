%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                              AVOID NESTED LOOPS                              %
%                                                                              %
%                                  8 June 2017                                 %
%                                                                              %
%                                                                              %
%                          Juan Ignacio Mendoza Garay                          %
%                               doctoral student                               %
%                 Department of Music, Art and Culture Studies                 %
%                            University of Jyv?skyl?                           %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ==============================================================================

% Problem: Evaluate function 'thefunction' with all combinations of parameters
%          in structure 'params', for an arbitrary amount of values.

% Solution 1: Nested loops.

% Solution 2: While indexing. This solution allows to resume the process if it 
%             is halted during execution. To resume, replace the variables
%             'param_indexes' and 'counter' after 'while counter < nvarcomb'
%             with the last recorded values of 'param_indexes' and 'counter'
%             before the halt.

% ==============================================================================

clear
clc

params.A = 1:4;
params.B = 10:10:40;
params.C = 100:100:400;

fnames = fieldnames(params);

thefunction = @(A,B,C) A + B + C;

% %% -----------------------------------------------------------------------------
% 1) Solution with nested loops:

tic
results_1 = zeros(length(params.A)*length(params.B)*length(params.C),1);
counter = 0;
for i_A = 1:length(params.A)
    for i_B = 1:length(params.B)
        for i_C = 1:length(params.C)

         counter = counter + 1;
         results_1(counter) = thefunction(params.A(i_A),params.B(i_B),params.C(i_C));
     
        end
    end
end
ctimes(1) = toc;

% %% -----------------------------------------------------------------------------
% 2) Solution without nested loops:

tic
lfn = length(fnames);
nvarcomb = 1;
for i = 1:lfn
    nvarcomb = nvarcomb * length(params.(fnames{i}));
    param_lengths(i) = length(params.(fnames{i})); %  length of each parameter
end

param_indexes = ones(1,lfn); % each cell of this matrix will store the index of each parameter

results_2 = zeros(nvarcomb,1);
counter = 1;
while counter < nvarcomb
   
    results_2(counter) = thefunction(params.A(param_indexes(1)),params.B(param_indexes(2)),params.C(param_indexes(3)));
    counter = counter + 1; 
    
    % update the indexes:
    escape = 0;
    paramind = lfn;
    while escape == 0 && paramind > 0
        
        if param_indexes(paramind) < param_lengths(paramind)
            param_indexes(paramind) = param_indexes(paramind) + 1;
            escape = 1;
        elseif param_indexes(paramind) == param_lengths(paramind)
            param_indexes(paramind) = 1;
        end
        
        paramind = paramind - 1;
        
    end
end
ctimes(2) = toc;

% %% -----------------------------------------------------------------------------
% display computation times:

disp(['time of solution 1 (nested loops)  = ',num2str(ctimes(1))])
disp(['time of solution 2 (while indexes) = ',num2str(ctimes(2))])