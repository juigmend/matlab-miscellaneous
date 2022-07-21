function n = nextbase26char(input)
% n = nextbase26char(input)
%
% Version: 14 April 2017
%
% Returns the next number n, counted from input, in base 26. 
% Notation is english alphabet.
% Input has to be a character or empty.
%
% Examples:
%   input = [ ]   ; next = 'A'
%   input = 'A'   ; next = 'B'
%   input = 'Z'   ; next = 'AA'
%   input = 'AA'  ; next = 'AB'
%   input = 'AZ'  ; next = 'BA'
%   input = 'YZZ' ; next = 'ZZA'
%
% Juan Ignacio Mendoza - 2017
% University of Jyv?skyl?

code = input;
strlength = size(code,2);

if isempty(code)
    code = 'A';
elseif code(end) ~= 'Z'
    code(end) = char(code(end) + 1);
elseif sum(code == 'Z') == strlength
    code = ['A',char((code == 'Z') .* 'A')];
elseif sum(code == 'Z') ~= 0
    i_1 = 0;
    i_2 = strlength;
    while i_1 == 0
        if code(i_2) >= 'Z'
            code(i_2) = 'A';
            code(i_2 -1) = char(code(i_2 -1) + 1);
            if code(i_2 -1) == 'Z'
                i_1 = 1;
            end
        else
            i_1 = 1;
        end
        i_2 = i_2 -1;
    end
end
n = code;

end
