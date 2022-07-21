%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                                                              %
%                          NOVELTY SCORE OF A 2D SIGNAL                        %
%                                     DEMO                                     %
%                                                                              %
%                          Juan Ignacio Mendoza Garay                          %
%                               doctoral student                               %
%                 Department of Music, Art and Culture Studies                 %
%                            University of Jyv?skyl?                           %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script has been tested with Matlab R2015a

% c.f. Foote & Cooper, 2003

% ==============================================================================
% Change these parameters and see what happens:

slength =  99; % <--- length of original sequence
   chpt =  49; % <--- change point
 gk1d_w =  20; % <--- length of Gaussian Kernel 1D
 gchk_w =  20; % <--- length of Gaussian Checkerboard Kernel

% ------------------------------------------------------------------------------
clc
clearvars cm kernel_1d kernel_2d m monpos nov seq seq_smooth sprows

if isempty(findobj('type','figure','name','novelty demo')) == 0
    close 'novelty demo'
end

sprows = 5;

seq = zeros(slength,2);
seq(1:chpt,1) = 1; 
seq(slength-chpt:end,2) = 1; 

monpos = get(0,'MonitorPositions');
figure('Position',monpos(1,:),'name','novelty demo');
subplot(sprows,3,2:3);
plot(seq);
xlim([1 slength])
title('Original Sequence')
legend('1','2','location','best')

kernel_1d = gausswin(gk1d_w);

subplot(sprows,3,4)
plot(kernel_1d)
title('Gaussian kernel 1D')

seq_smooth = zeros(slength,2);
seq_smooth(:,1) = conv(seq(:,1),kernel_1d,'same');
seq_smooth(:,2) = conv(seq(:,2),kernel_1d,'same');
mean_seq_smooth = mean(seq_smooth');

subplot(sprows,3,5:6)
plot(seq_smooth)
hold on
plot(mean_seq_smooth,'k--');
xlim([1 slength])
hold off
title('Sequence convolved with Gaussian kernel 1D')
legend('1','2','mean','location','best')

m = pdist2(seq_smooth,seq_smooth);

subplot(sprows,3,8:9)
imagesc(m)
title('Distance matrix')

gchk_kernel = fspecial('gaussian',[gchk_w gchk_w],pi);
gchk_kernel = gchk_kernel .* (kron([-1, 1; 1,  -1],ones(gchk_w/2)));

subplot(sprows,3,10)
imagesc(gchk_kernel);
title('Gaussian checkerboard kernel')

cm = conv2(m,gchk_kernel,'same');
subplot(sprows,3,11:12)
imagesc(cm)
title('Distance matrix convolved with Gaussian checkerboard kernel')

nov = diag(cm);
subplot(sprows,3,14:15)
plot(nov)
xlim([1 slength])
title('novelty')