function s = mcspread(d)
% Sum of inter-marker distances per frame.
%
% syntax:
%   s = mcspread(d);
%
% input:
%   d: MoCap structure
%
% output:
%   s: spread time-series
%
% VERSION: 1 June 2021
%
% Juan Ignacio Mendoza
% University of Jyväskylä

n_cols = d.nMarkers * 3;
pdists = NaN(d.nFrames, (d.nMarkers^2-d.nMarkers)/2) ;

for i_frame = 1:d.nFrames
    
    this_frame(1:d.nMarkers,1) = d.data(i_frame,1:3:n_cols); % x
    this_frame(1:d.nMarkers,2) = d.data(i_frame,2:3:n_cols); % y
    this_frame(1:d.nMarkers,3) = d.data(i_frame,3:3:n_cols); % z
    
    pdists(i_frame,:) = pdist(this_frame);
end

s = sum(pdists,2);
