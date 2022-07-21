function maxcorrlags = mcwinxcorr(d1,d2,w,h,u)
%
% DESCRIPTION: 
% MCWINXCORR computes windowed cross-correlation of two one-dimensional signals.
%
% SYNTAX:
% maxcorrlags = mcwinxcorr(d1,d2);
% maxcorrlags = mcwinxcorr(d1,d2,w);
% maxcorrlags = mcwinxcorr(d1,d2,w,h);
% maxcorrlags = mcwinxcorr(d1,d2,w,h,u);
% 
% INPUT:
% d1, d2: MoCap data structures, norm strutures or numerical arrays of one column vector
% w: width of the window (optional, default = 10)
% h: hop of the window (optional, default = 50)
% u: width and hop unit, 'percentage' or 'frames' (optional, default = 'percentage')
%
% OUTPUT:
% maxcorrlags: a row vector containing cross-correlation lags at maximum correlation
%
% OBSERVATIONS:
% If the length of d1 and d2 are not the same, then zeros will be added at the
% end of the shortest to match the length of the largest.
%
% VERSION: 16 May 2017
%
% Juan Ignacio Mendoza - 2017
% University of Jyv?skyl?


% process inputs:

if nargin == 1
    disp([10,'There has to be at least two arguments', 10])
    return
end

if nargin == 2
    w = 10;
end

if isstruct(d1)
    data_1 = d1.data;
else
    data_1 = d1;
end

if isstruct(d2)
    data_2 = d2.data;
else
    data_2 = d2;
end

if (size(data_1,2)==1)==0 || (size(data_2,2)==1)==0
    disp([10,'Data has to be uni-dimensional (i.e., one column vector)', 10])
    return
end

length_data_1 = size(data_1,1);
length_data_2 = size(data_2,1);
length_data = length_data_1;

if (length_data_1 == length_data_2) == 0 % check that lengths are equal
    difl = abs(length_data_1 - length_data_2);
    if length_data_1 > length_data_2
        data_2 = vertcat(data_2, zeros(difl,1));
    elseif length_data_1 < length_data_2
        data_1 = vertcat(data_1, zeros(difl,1));
        length_data = length_data_2;
    end
end

if nargin > 2
    if ~isnumeric(w) || ~isnumeric(h)
        disp([10, 'The third and fourth arguments have to be numerical', 10])
        return;
    end
end

if nargin < 5
    u = 'percentage';
    h = 50;
end

if strcmp(u,'percentage')
    window_width = round(length_data * w/100);
    window_hop = round(length_data * h/100);
elseif strcmp(u,'frames')
    window_width = w;
    window_hop = h;
end

% windowed correlation:

amount_windows = fix((length_data - window_width) / window_hop + 1);
maxcorrlags = zeros(1,amount_windows);
thiswindow_data_1 = zeros(window_width,1);
thiswindow_data_2 = thiswindow_data_1;

for i = 1:amount_windows
    thisendingofwin = (window_hop * (i - 1)) + window_width;
    thiswindow_data_1 = data_1( (thisendingofwin - window_width + 1): thisendingofwin );
    thiswindow_data_2 = data_2( (thisendingofwin - window_width + 1): thisendingofwin );
    [xcorrs_tmp,xcorrlags_tmp] = xcorr(thiswindow_data_1,thiswindow_data_2);
    
    if length(xcorrlags_tmp(xcorrs_tmp==max(xcorrs_tmp))) ~= 1
        error('More than one maximum. Try a different window size.')
        break
    end
    
    maxcorrlags(1,i) = xcorrlags_tmp(xcorrs_tmp==max(xcorrs_tmp));
end

end
