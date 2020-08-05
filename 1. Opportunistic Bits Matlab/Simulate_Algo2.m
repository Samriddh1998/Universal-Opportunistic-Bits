
ps = [];
for K = 15:15
N = 2^K;
count = zeros(1,N);
COUNT_MAX = 10000;
% cnt_arr = zeros(1,1000);
% sto_arr = zeros(8,2,1000);
for M = 1:2^11:N/4       
    
    Storage = zeros(M,2); 
    % Initally fill Storage from 1 to M
    Storage(1:M,1) = (1:M)'; % equivalnt to randomly filling the space with random numbers.
    Storage(:,2) = ones(M,1);
    cnt = 0;
    for i = 1:COUNT_MAX % Total transmissions      
        space = sum(Storage(:,2)); % it is always = M at this point
        Storage = sortrows(Storage,2,"descend");
%         sto_arr(:,:,i) = Storage;
%% Transmission of DU-packet(s)
% if storage is full then we remove/TRANSMIT a packet
% Case A: All OB are different -> NO PAIRED TRANSMISSION
% Case B: All OB are not different -> PAIRED TRANSMISSION

        if(space == M) 
%           Case A:
            if(Storage(1,2) == 1) 
                %cnt = cnt; % No DU pair
                Storage(1,:) = 0;
                space = space-1;
%           Case B:
            else
                Storage(1,2) = Storage(1,2) - 2;
                if Storage(1,2) == 0 
                    Storage(1,1) = 0;
                end
                cnt = cnt+1; 
                space = space-2; % Doing the calculations seperately but can be done together
            end        
        end
%         cnt_arr(i) = cnt;
%% Filling up the storage unit
%       Case B: Current space will be decreased by 2 since a pair is
%       transmitted
        if(space == M-2)
            r = randi(N); % Random DU/OB introduced
            [index] = find(Storage(:,1) == r);
            if(isempty(index)) 
                Storage(end,:) = [r,1];
            else
                Storage(index,2) = Storage(index,2) + 1; 
            end
        end
%       Case A: Case B:
        r = randi(N);
        [index] = find(Storage(:,1) == r);
        if(isempty(index)) 
            Storage(find(Storage(:,1) == 0,1),:) = [r,1];
        else
            Storage(index,2) = Storage(index,2) + 1; 
        end
        
    end
count(M) = cnt;
end
ps = [ps,count/COUNT_MAX]; 
 plot(count/COUNT_MAX);
 hold on
 if ps == 1
     M = N;
 end
%  plot(count/1000,'*');
end
grid on;
%% 
title("Algo 1 vs Simulation of Algo 1 to calculte PS");
xlabel("M");
ylabel("DU-pair transmission probability p_s");
