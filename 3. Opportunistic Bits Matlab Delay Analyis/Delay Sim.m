
ps = [];
for K = 5
N = 2^K;
count = zeros(1,N);
delay = 6000; % Max delay of 50 units is acceptable.
dlCtr = zeros(N,1);
NosIter = 20000;
BigStack = zeros(N,2*NosIter);
BigStack2 = zeros(N,2*NosIter);
BigTnxno = zeros(N,1);
for M = 6:4:N
%     offset(M) = M*(M-1)/2;
    
    Storage = zeros(M,2);
    Time = zeros(M,10);
    Time2 = nan(M,10);
    Time2(:,1) = repmat(delay,M,1);
    Stack = zeros(1,NosIter*2);
    Stack2 = zeros(1,NosIter*2);
    % Initally fill Storage from 1 to M
    Storage(1:M,1) = (1:M)'; % equivalnt to randomly filling the space with random numbers.
    Storage(:,2) = ones(M,1);
    cnt = 0;
    tnxno = 0; % no of items passed = cnt + i;
    for i = 1:NosIter % Total transmissions      
        space = sum(Storage(:,2)); % it is always = M at this point
        [Storage,sortIndex] = sortrows(Storage,2,"descend");
        Time = Time(sortIndex,:);
        Time2 = Time2(sortIndex,:);
        if(space == M) % Always Happens -- :)
            if(Storage(1,2) == 1) % Single packet disposal => Oldest one thrown
                    xxx=randi(M);
                    selectIndex = xxx;
                  [oldestTime] = (Time2(xxx,1));
                  
                  if(true) % swapping
                      Storage([1,selectIndex],:) = Storage([selectIndex,1],:);
                      Time([1,selectIndex],:) = Time([selectIndex,1],:);
                      Time2([1,selectIndex],:) = Time2([selectIndex,1],:);
                  end
                Storage(1,:) = 0;
                space = space-1;
                  Stack(tnxno+1) = - Time(1,1) + tnxno;
                  Stack2(tnxno+1) = - Time2(1,1) + tnxno;
                  Time(1,1) = 0;
                  Time2(1,1) = NaN;
            else
                    nosPairs=sum(Storage(:,2)>=2);
                    xxx=randi(nosPairs);
                    selectIndex = xxx;
                  [oldestTime] = (Time2(xxx,1));
                  if(true) 
                      dlCtr(M) = dlCtr(M) + 1;
                      % if delay is unbearable WE SWAP AND REMOVE THE DELAY
                      if(Storage(selectIndex,2)>=2)  % DU-Pair removal
                            Storage([1,selectIndex],:) = Storage([selectIndex,1],:);
                            Time([1,selectIndex],:) = Time([selectIndex,1],:);
                            Time2([1,selectIndex],:) = Time2([selectIndex,1],:); 
                            Storage(1,2) = Storage(1,2) - 2;
                            Stack(tnxno+1) = -Time(1,1)+tnxno;
                            Stack(tnxno+2) = -Time(1,2)+tnxno;
                            Stack2(tnxno+1) = -Time2(1,1)+tnxno;
                            Stack2(tnxno+2) = -Time2(1,2)+tnxno;
                            Time(1,1:2) = 0;
                            Time(1,:) = circshift(Time(1,:),-2);
                            Time2(1,1:2) = NaN;
                            Time2(1,:) = circshift(Time2(1,:),-2);
                         if Storage(1,2) == 0 
                             Storage(1,1) = 0;
                         end
                         cnt = cnt+1; 
                         space = space-2; % Doing the calculations seperately but can be done together
                      else % Single element removal
                           Storage([1,selectIndex],:) = Storage([selectIndex,1],:);
                           Time([1,selectIndex],:) = Time([selectIndex,1],:);
                           Time2([1,selectIndex],:) = Time2([selectIndex,1],:); 
                          Storage(1,:) = 0;
                          space = space-1;
                           Stack(tnxno+1) = - Time(1,1) + tnxno;
                           Stack2(tnxno+1) = - Time2(1,1) + tnxno;
                           Time(1,1) = 0;
                           Time2(1,1) = NaN;
                      end
                  else
                        Storage(1,2) = Storage(1,2) - 2;
                        Stack(tnxno+1) = -Time(1,1)+tnxno;
                        Stack(tnxno+2) = -Time(1,2)+tnxno;
                        Stack2(tnxno+1) = -Time2(1,1)+tnxno;
                        Stack2(tnxno+2) = -Time2(1,2)+tnxno;
                        Time(1,1:2) = 0;
                        Time(1,:) = circshift(Time(1,:),-2);
                        Time2(1,1:2) = NaN;
                        Time2(1,:) = circshift(Time2(1,:),-2);
                        if Storage(1,2) == 0 
                            Storage(1,1) = 0;
                        end
                        cnt = cnt+1; 
                        space = space-2;
                  end
            end        
        end
%% Filling up the storage unit
        if(space == M-2)
            r = randi(N); % Random DU/OB introduced
            tnxno = tnxno + 1;
            [index] = find(Storage(:,1) == r);
            if(isempty(index)) 
                Storage(end,:) = [r,1];
                Time(end,1) = tnxno;
                Time2(end,1) = tnxno+delay;
            else
                Storage(index,2) = Storage(index,2) + 1; 
                Time(index,Storage(index,2)) = tnxno;
                Time2(index,Storage(index,2)) = tnxno+delay;
            end
        end
%       Case A: Case B:
        r = randi(N);
        tnxno = tnxno + 1;
        [index] = find(Storage(:,1) == r);
        if(isempty(index))
            idxZ = find(Storage(:,1) == 0,1);
            Storage(idxZ,:) = [r,1];
            Time(idxZ,1) = tnxno;
            Time2(idxZ,1) = tnxno+delay;
        else
            Storage(index,2) = Storage(index,2) + 1; 
            Time(index,Storage(index,2)) = tnxno;
            Time2(index,Storage(index,2)) = tnxno+delay;
        end
        zzz  = 1;
        Time;
        Storage;
    end
count(M) = cnt;
BigStack(M,:) = Stack;
BigStack2(M,:) = Stack2;
BigTnxno(M,1) = tnxno;

end
ps = [ps,count/NosIter]; 
 plot(count/NosIter);
 grid on;
 hold on
%  plot(count/1000,'*');
end
%%
title("Algo 1 vs Simulation of Algo 1 to calculte PS");
xlabel("M");
ylabel("DU-pair transmission probability p_s");

hold off

plot(sum(BigStack,2)./BigTnxno,'blue',"Marker",'*')
hold on
mat = 0:N-1;
matx = mat-ps/(2);
matxx = mat - (ps.^2)./(1+ps);
matxxx = mat - (ps)./(1+ps);

% plot((0:N-1)- ps,'green')
plot(matx,'green')
plot(matxx,'red')
grid on;
AvgDelay = sum(BigStack,2)./BigTnxno;

figure
hold on
plot(matxxx-AvgDelay','magenta')
plot(matxx-AvgDelay','green')
plot(matx-AvgDelay','red')

grid on;
hold off

% if(mod(K,2)==0) 
%     dim1 = 2^(K/2);
%     dim2 = dim1;
% else
%     dim1 = 2^((K-1)/2);
%     dim2 = dim1*2;
% end
%%
% for M = 1:N
%    subplot(2,2,mod((M-1),4)+1);
%    h(M) = histogram(BigStack(M,100:NosIter),'BinMethod',"integers");
%    if((mod(M-1,4)+1)==4)
%        figure
%    end
% %    ylim([0,1]);
% end
%%
% plot(max(BigStack,[],2))

% for i = 1:16
%     subplot(4,4,i);
%     histogram(BigStack2(i,1:1000));
% end


