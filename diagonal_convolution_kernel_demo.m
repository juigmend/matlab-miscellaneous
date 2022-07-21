%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                   Convolution of a Matrix's Main Diagonal                    %
%                                and a Kernel                                  %
%                                                                              %
%                                                   Juan Ignacio Mendoza Garay %
%                                                             doctoral student %
%                                   Music Department - University of Jyv?skyl? %
%                                                                  March, 2016 %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script has been tested with Matlab R2015a

% ==============================================================================
% Description:

% Convolve (A.K.A. correlate) a kernel along the main diagonal of a matrix.

% The result is a curve whose peaks determine the points of change from one
% pattern to another, of a signal.
% First a self-similarity distance matrix has to be produced from the signal
% (referred below as the"original matrix"). Then convolce the kernel along the
% diagonal of the matrix.
% This method can be useful to find segmentation boundaries
% of an audio signal (c.f. Foote & Cooper, 2003) or any other signal 
% (e.g., motion capture data). Typically the distance matrix is not of the raw
% (e.g., audio or mocap) signal but of a feature of it (e.g., energy, spectral
% components, etc.).

% ==============================================================================
% Initialisation:

clc
clear
close all

scrsz = get(groot,'ScreenSize');

%%% ============================================================================
% Produce a matrix (the"original matrix").
% Comment/uncomment to select an original 100*100 matrix:

%%% ............................................................................
% fade left to right and slightly diagonally:
%original_matrix = reshape([1:10000],100,100);

%%% ............................................................................
% only ones:
% original_matrix = ones(100,100);

%%% ............................................................................
% gaussian bell:

%   [original_x original_y] = meshgrid((-(100-1)/2):((100-1)/2), (-(100-1)/2):((100-1)/2));
%   original_matrix = exp( -((2*pi*original_x/100).^2) / 2 - ((2*pi*original_y/100).^2) / 2);

%%% ............................................................................
% self-similarity of an AMFM signal:

use_preset = 4; % <----------------------- Use parameters (a preset is a column)
signal_parameters = ...
    [80  80   100  50  90; ...  % FM modulating frequency
    1600 1600 1000 500 800; ... % FM carrier frequency
    20   20   10   10  20; ...  % FM strength 
    40   160  50   25  40;...   % AM modulating frequency
    0.5  0.5  1    1   0.5];    % AM strength (between 0 and 1)
sample_time = 0.0001; 
total_time = 0.1-sample_time; 
t = [0:sample_time:total_time]; % time grid
FM_signal = sin(...
    2*pi*signal_parameters(2,use_preset)*t+...
    (signal_parameters(3,use_preset).*sin(2*pi*signal_parameters(1,use_preset)*t))...
    );
AM_FM_signal = (1+signal_parameters(5,use_preset)*sin(2*pi*signal_parameters(4,use_preset)*t)).*FM_signal;
distance_bandwidth = size(AM_FM_signal,2)*0.02; % <----- size of the distance moving window (samples)
distance_hop = distance_bandwidth/2; % <---------------- hop size (samples)
amount_distance_windows = fix((size(AM_FM_signal,2)-distance_bandwidth)/distance_hop + 1);
original_matrix = zeros(amount_distance_windows);
for row = 2:amount_distance_windows % make the distance matrix
   a =  AM_FM_signal( distance_hop*(row-1)+1 : distance_bandwidth+(distance_hop*(row-1)) );
   for column = 1:(row-1)
       b = AM_FM_signal( distance_hop*(column-1)+1 : distance_bandwidth+(distance_hop*(column-1)) ); 
       original_matrix(row,column) = norm(a-b); % euclidean distance
       original_matrix(column,row) = original_matrix(row,column);
   end
end


%%% ----------------------------------------------------------------------------
% Make a kernel :

W = 8; % <------------------------------- kernel width

[kernel_x kernel_y] = meshgrid((-(W-1)/2):((W-1)/2), (-(W-1)/2):((W-1)/2));
gaussian_kernel = exp( -((2*pi*kernel_x/W).^2) / 2 - ((2*pi*kernel_y/W).^2) / 2);

%%% ............................................................................
% comment/uncomment to select a kernel:

%kernel = gaussian_kernel; % gaussian kernel

kernel = gaussian_kernel .* (kron([-1, 1; 1,  -1],ones(W/2))); % gaussian tapered checkerboard kernel (c.f. Foote & Cooper, 2003)

%%% ----------------------------------------------------------------------------
% METHOD 1: Sliding Kernel

% Convolve (A.K.A. correlate) the kernel along the main diagonal of the 
% original matrix.
% To make the convolution slide the kernel along the main diagonal, 
% from the point where the center of the kernel is at the beginning of the 
% original matrix and ending where the center of the kernel is at the end of the
% original matrix.
% At each point element-wise multiply the kernel and add all the elemnts of the 
% resulting matrix (which has the size of the kernel). This will give a score
% at each point. The vector containing all these scores is the result of 
% convolution. 
% The convolution vector is plotted as a curve. 

%%% ............................................................................
% add a margin to the original matrix: 

tic

margin = W/2; % margin (W/2 will cause the kernel to start with is center at the beginning of the original matrix)

original_size = size(original_matrix);
margined_matrix = ...
    zeros(original_size + margin*2); % initialise with zeros a bigger matrix (A.K.A. margined matrix) to contain the original matrix
margined_begin = margin + 1;
margined_end = margin + original_size(1);
margined_matrix( margined_begin : margined_end , margined_begin : margined_end ) = ...
    original_matrix; % put the original matrix into the bigger matrix

%%% ............................................................................
% Convolve it, baby!

end_offset = W - 1;
convolution_curve = zeros(1, (original_size(1) + 2* (margin-W) ));

for i = 1:( original_size(1) + 2*margin - W )
    sliding_window_beginning = i;
    sliding_window_end = end_offset + i ;
    sliding_window = margined_matrix( sliding_window_beginning : sliding_window_end , sliding_window_beginning : sliding_window_end );
    convolution_curve_1(i) = sum(sum( sliding_window .* kernel ));
end

timer_1 = toc;

%%% ----------------------------------------------------------------------------
% METHOD 2: Matrix Convolution

% Convolve the whole matrix in 2 dimensions. This will produce a matrix of 
% length W bigger than the original (this corresponds to the added margins in
% method 1). Then take the main diagonal and trim its borders, each having a 
% length of W/2.

tic

convolved_matrix = conv2(original_matrix,kernel); % convolve original matrix with kernel
convolution_curve_2 = diag(convolved_matrix); % extract diagonal
convolution_curve_2 = convolution_curve_2( fix(W/2) : end - fix(W/2) , 1 ); % trim borders

timer_2 = toc;

%%% ----------------------------------------------------------------------------
% Plots:

fig = figure('Position',[1 scrsz(4)-scrsz(4)*1/2 scrsz(3) scrsz(4)*1/2]);

subplot(4,8,[1,2,9,10])
imagesc(original_matrix)
axis square
title('original matrix')

subplot(4,8,[3,4,11,12])
imagesc(margined_matrix)
axis square
title('margined matrix (method 1)')

subplot(4,8,[5,6,13,14])
imagesc(kernel)
axis square
title('kernel (methods 1 and 2)')

subplot(4,8,[7,8,15,16])
imagesc(convolved_matrix)
axis square
title('convolved matrix (method 2)')

subplot(4,8,[17:24])
plot(convolution_curve_1,'Color',[0 0.4 1])
xlim([1,length(convolution_curve_1)])
title('convolution curve - method 1')

subplot(4,8,[25:32])
plot(convolution_curve_2,'Color',[0 0.5 0.2])
xlim([1,length(convolution_curve_2)])
title('convolution curve - method 2')

%%% ----------------------------------------------------------------------------
% Display computation times :

disp('----------------------------------------------------------')
disp('Computing times of convolution of diagonal with a kernel:')
disp(['METHOD 1 = ',num2str(timer_1),' sec.'])
disp(['METHOD 2 = ',num2str(timer_2),' sec.'])
disp('----------------------------------------------------------')