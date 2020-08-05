%% This is Data dependent on previous value of ps form simulate_algo2
%  Just run with equal values of K.
load("ps_mat_k_5.mat")
Marker(1) = "*";
Marker(2) = 'o';
Marker(3) = 'x';
Marker(4) = 's';
iterNo = 0;
gamma_arr = [];

for N = [6,8,12,24]
    iterNo = iterNo +1;
K = 5;
M = 1:32;
SNR = 10;% SNR = 10db = 10log100; ratio 
n1=2*N/(2*N-K);
n2=log(1+n1*SNR)/log(1+SNR);
gamma = 1-ps + n1*n2*ps;
gamma_arr = [gamma_arr; gamma];
plot(M,gamma);%,Marker(iterNo),"MarkerSize",12,"LineWidth",2);

hold on;
legend;
end
% plot(gamma_arr(1,:),Marker(1));
title("Spectral efficiency gain vs the stored number of DU's for K = 5");
xlabel("M");
ylabel('Spectral Efficiency Gain \gamma');