function n = nextbase36char(input)
% n = nextbase36char(input)
%
% Version: 15 April 2017
%
% Returns the next number n, counted from input, in base 36.
% Notation is English alphabet and digits (A,B,?Z,0,1,?9).
% Input has to be a character or empty.
%
% Examples:
%   input = [ ]   ; n = 'A'
%   input = 'A'   ; n = 'B'
%   input = 'Z'   ; n = '0'
%   input = '0'   ; n = '1'
%   input = '9'   ; n = 'AA'
%   input = 'AA'  ; n = 'AB'
%   input = 'AZ'  ; n = 'A0'
%   input = 'A9'  ; n = 'BA'
%   input = '99'  ; n = 'AAA'
%   input = 'YZZ' ; n = 'YZ0'
%   input = 'Z99' ; n = '0AA'
%
% Juan Ignacio Mendoza - 2017
% University of Jyv?skyl?

n = input;
strlength = length(n);
allchars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

if isempty(n)
    n = 'A';
elseif sum(n == '9') == strlength
    n = ['A',char((n == '9') .* 'A')];
else
    i_1 = 1;
    i_2 = strlength;
    while and(i_1 ~= 0, i_2 ~= 0)
        if n(i_2) ~= '9'
            n(i_2) = allchars(find(allchars == n(i_2))+1);
            i_1 = 0;
        elseif n(i_2) == '9'
            n(i_2) = 'A';
        end
        i_2 = i_2 -1;
    end
end

end
