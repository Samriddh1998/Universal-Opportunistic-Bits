%% Convert Fig to PDF
% Just open the figure then execute the following script.

set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,'Paper_Fig2and1' ,'-dpdf','-r0')
close