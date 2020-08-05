function [pro] = individualProb(p,ps,t)
%individualProb calculates prob of an element to be removed at tiem t;
%   Detailed explanation goes here
pro = 0;
% digitOld = digits(32);
for i = 0:1:t/2
    ele1 = (1-p)^(t-i);
    ele2 = (1-ps)^(t-2*i);
    ele3 = (ps)^(i);
    ele4 = ( (nchoosek((t-i),i)) );
    ele = ele1*ele2*ele3*ele4;
    pro = pro + ele;
end
pro = pro * p;
% digits(digitOld);
end

