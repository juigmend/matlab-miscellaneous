function s = mcspread(d,varargin)
% Sum of inter-marker distances per time-window.
%
% syntax:
%   s = mcspread(d);
%   s = mcspread(d,w,hop);
%   s = mcspread(d,w,hop,dim);
%
% input:
%   d: MoCap structure
%   w: window length in frames (optional, default = 1)
%   hop: window hop in frames (optional, default = 1)
%   dim: dimensions, logical [x,y,z] (optional, default = [1,1,1])
%
% output:
%   s: spread time-series
%
% note:
%   This function used on a plane (i.e., two non-zero dim) may give a more 
%   accurate estimation of the change in area covered than function mcboundrect.
%
% VERSION: 5 June 2021
%
% Juan Ignacio Mendoza
% University of Jyväskylä

n_dims = 3;
dims = 1:3;

if nargin == 1
    
    w = 1;
    hop = 1;
else
    
    w = varargin{1};
    hop = varargin{2};
    
    if nargin == 4 % dim
        
        if ~isvector(varargin{3}) || (length(varargin{3})~=3) || any(varargin{3}>1) || any(varargin{3}<0)
            error('third argument (dim) should be a vector of 3 boolean values')
        end
        n_dims = sum(varargin{3});
        dims = varargin{3}.*(1:3);
        dims = dims(dims>0);
    end
end
    
n_w = floor((d.nFrames-(w))/hop)+1;
s_w = d.nMarkers * w;

pdists = NaN(n_w, (s_w^2-s_w)/2);
these_vals = zeros(s_w,n_dims);

w_m = w-1;
w_start = 1;
for i_w = 1:n_w
    
    w_end = w_start + w_m;
    this_w = d.data(w_start:w_end,:);

    for i_dim = 1:n_dims
        this_w_dim = this_w(:,dims(i_dim):3:end);
        these_vals(:,i_dim) = this_w_dim(:); 
    end
    
    pdists(i_w,:) = pdist(these_vals);
    w_start = w_start + hop;
end

s = sum(pdists,2);
