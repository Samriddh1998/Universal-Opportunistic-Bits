% We will calculate teh expected time [12.9123099074397][13.8563899036312]
K = 4;
N = 2^K;
threshold_limit = 60;
if K == 4
    load('p_s matrix/p_s4.mat')
elseif K == 5
    load('p_s matrix/p_s5.mat')
elseif K == 6
    load('p_s matrix/p_s6.mat')
end
time_end = 80;

A = zeros(2.^K,time_end);
PT = zeros(1,N);
PS2 =zeros(1,N); 
for M = 1:2^K
    ps= p_sCopy(M);
    p = (1+1*ps)/M;
    %% Table Maker
    
    %%
    a = zeros(1,time_end); % individual
%     b = zeros(1,time_end); % expectation;
%     c = zeros(1,time_end);
    d = zeros(1,time_end+1);
    ex=d;
    for t = 0:(time_end-1)
        a(t+1) = indivProb(p,ps,t);   
%         b(t+1) = (t)*a(t+1);
%         c(t+1) = (t+1)*a(t+1);
    end
    d(2:end) = a;
    d(1)=0;
    d = d*ps + [a,0];
    d = d/(1+ps);
    sum(d);
    pt = 1 - sum(d(1:threshold_limit));
    A(M,:) = a;
    D(M,:) = d;
    PT(M) = pt;
    PS2(M)= ps*(1-pt*(1-ps)); 
end
%%
save(['p_thLim',num2str(threshold_limit),'_K',num2str(K)],'PT')
subplot(2,1,1)
plot(PT)
subplot(2,1,2)
plot(PS2);
hold on
plot(p_sCopy);
grid on


