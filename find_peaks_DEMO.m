%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                             FIND PEAKS IN A CURVE                            %
%                                DEMONSTRATION                                 %
%                                                                              %
%                               26 January 2018                                %
%                                                                              %
%                          Juan Ignacio Mendoza Garay                          %
%                               doctoral student                               %
%                 Department of Music, Art and Culture Studies                 %
%                            University of Jyv?skyl?                           %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test_input = sin(0:0.001:(pi*5)); % define the input signal

close all
figure('Position',get( 0, 'Screensize' ))
amt_subplots = 5;

subplot_count = 1;
subplot(amt_subplots,1,subplot_count)
plot(test_input,'k','LineWidth',3)
title('input signal','FontSize',14)
subplot_count = subplot_count + 1;

test_first = (diff(test_input)); % first derivative (differentiation) of the input signal
test_first_norm = test_first / max(test_first); % normalise it, don't criticise it

subplot(amt_subplots,1,subplot_count)
plot(test_first_norm,'r','LineWidth',3)
ylim([min(test_first_norm), max(test_first_norm)])
title('normalised first derivative','FontSize',14)
subplot_count = subplot_count + 1;

test_sign_first = sign(test_first_norm); % find the sign of the first derivative (positive = 1; negative = -1) 
subplot(amt_subplots,1,subplot_count)
plot(test_sign_first,'color',[0.2, 0.8, 0.2],'LineWidth',3)
title('sign of first derivative','FontSize',14)
subplot_count = subplot_count + 1;

test_deriv_sign = diff(test_sign_first); % local extrema: derivative of the sign of the first derivative of the input signal

subplot(amt_subplots,1,subplot_count)
plot(test_deriv_sign,'b','LineWidth',3)
title('local extrema: derivative of direction of first derivative','FontSize',14)
subplot_count = subplot_count + 1;

% The peaks of the input are located where zero-crossings of the first derivative change from positive to negative.

peaks_indexes_bool = test_deriv_sign < 0; % get boolean indexes of negative local extrema

subplot(amt_subplots,1,subplot_count)
plot(test_input,'k','LineWidth',3)
hold on
plot(peaks_indexes_bool,'m','LineWidth',3)
title('input signal (black) and boolean indexing of local extrema (magenta)','FontSize',14)
