function [inputArg1] = rem_com_row(inputArg1)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
index = 1;
while index < size(inputArg1,1)
    if(inputArg1(index,:) == inputArg1(index+1,:))
        inputArg1(index+1,:) = [];
    else
        index = index + 1;
    end
end

end

