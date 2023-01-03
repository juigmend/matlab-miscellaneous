function s = mcspread(d)
% Sum of inter-marker distances per frame.
%
% syntax:
%   s = mcspread(d);
%
% input:
%   d: MoCap structure (*) 
%      or matrix where rows are frames and columns are xyz dimensions of markers
%      e.g., marker_1_x, marker_1_y, marker_1_z, marker_2_x, marker_2_y, etc.
%
% output:
%   s: spread time-series (or scalar if only one frame)
%
% (*) see the MoCap toolbox:
% https://www.jyu.fi/hytk/fi/laitokset/mutku/en/research/materials/mocaptoolbox
%
% VERSION: 2 January 2023
%
% Juan Ignacio Mendoza
% University of Jyväskylä

if ~isstruct(d)
    
    d_tmp = d;
    clear d
    d.data = d_tmp;
    [d.nFrames,n_cols] = size(d.data);
    d.nMarkers = n_cols / 3;
else
    n_cols = d.nMarkers * 3;
end
    
pdists = zeros(d.nFrames, (d.nMarkers^2-d.nMarkers)/2) ;

for i_frame = 1:d.nFrames
    
    this_frame(1:d.nMarkers,1) = d.data(i_frame,1:3:n_cols); % x
    this_frame(1:d.nMarkers,2) = d.data(i_frame,2:3:n_cols); % y
    this_frame(1:d.nMarkers,3) = d.data(i_frame,3:3:n_cols); % z
    
    pdists(i_frame,:) = pdist(this_frame);
end

s = sum(pdists,2);
