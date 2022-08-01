t = [0:0.1:5]
A = 2
T = 2
y = sin(2*pi()/T*t)
p = plot(t,y)
get(p)
ha = gca
set(p,'lineWidth',1)
set(p,'lineStyle','-')
set(ha,'fontsize',5)
set(p,'color',[0.5,0.5,1])
set(ha,'Xgrid','on')

s = struct('Auto',{{'Fiat','Audi'}},'Gewicht',[1300,1600])
s.Auto
s.Gewicht
