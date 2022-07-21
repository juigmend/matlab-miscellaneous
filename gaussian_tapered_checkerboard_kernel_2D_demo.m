%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                   2D Gaussian Tapered Checkerboard Kernel                    %
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

% Produce a Gaussian Kernel, then transform it so that it has positive and 
% negative zones like a checkerboard of 4 squares (c.f. Foote & Cooper, 2003).
% Plot each stage.

% ==============================================================================
% Initialisation:

clc
clear
close all

scrsz = get(groot,'ScreenSize');
fig = figure('Position',[1 scrsz(4)-scrsz(4)*1/2 scrsz(3) scrsz(4)*1/2]); % adjust position

%% % ----------------------------------------------------------------------------
% 2D Gaussian Kernel:

N = 40; % kernel size
[kernel_x kernel_y] = meshgrid((-(N-1)/2):((N-1)/2), (-(N-1)/2):((N-1)/2));
gaussian_kernel = exp( -((2*pi*kernel_x/N).^2) / 2 - ((2*pi*kernel_y/N).^2) / 2);

subplot(1,3,1)
surf(gaussian_kernel)
title('2D Gaussian Kernel')

%% % ----------------------------------------------------------------------------
% Checkerboard Matrix:

checkerboard = kron([-1, 1; 1,  -1],ones(N/2));
 
subplot(1,3,2)
imagesc(checkerboard)
title('Checkerboard Matrix')

%% % ----------------------------------------------------------------------------
% 2D Gaussian-tapered Checkerboard Kernel:

gaussian_checkerboard_kernel = gaussian_kernel .* checkerboard;

subplot(1,3,3)
surf(gaussian_checkerboard_kernel)
title('2D Gaussian-tapered Checkerboard Kernel')


