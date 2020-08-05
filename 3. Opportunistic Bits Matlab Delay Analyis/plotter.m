for M = 6:4:32
    anss=[];a=[];b=[];
    a = BigStack(M,1:BigTnxno(M));
    b = D(M,:);%D variable
    for i = 0:99
        anss(i+1)=sum(a==(i))/BigTnxno(M);
    end
%     if mod(M-1,4) == 0
%         figure
%     end
%      subplot(2,2,mod(M-1,4)+1)
% %     subplot(4,4,M)
    figure
    grid on;
    semilogy(anss(1:80),'blue',"LineWidth",2);
    hold on;
    semilogy(b(1:80),'black',"LineWidth",2);
    xlabel("time","FontSize",14,"FontWeight","bold")
    ylabel("p(t)","FontSize",14,"FontWeight","bold")
    title([num2str(M)],"FontSize",14,"FontWeight","bold")
    legend
end
% title("probability of removal as a function of time");
% M = 16
% a = BigStack(M,1:BigTnxno(M))
% for i = 1:100
% anss(i)=(sum(a==i))/BigTnxno(M);
% end
% plot(anss)

% plot(xaxis,'MarkerSize','9')


