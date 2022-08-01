clear all

% Initialisierung

dT = [0.001,0.01,0.1,0.5,1,2,4]
g = 9.81

% Numerische Lösung

hold on
for j = 1 : length(dT)
    y1 = 10             % [m]           Anfangshöhe
    y2 = 100            % [m/s]         Anfangsgeschwindigkeit
    t = [0:dT(j):24]
    for i = 1 : length(t)
        Y(i)= y1;
        y1 = y1 + y2 * dT(j); 
        y2 = y2 + (-g) * dT(j);
    end
    plot (t,Y,'g')
    clear Y
end

% Analytische Lösung

y1 = 10             % [m]           Anfangshöhe
y2 = 100            % [m/s]         Anfangsgeschwindigkeit
t = [0:0.1:24]

for i = 1 : length(t)
    Y(i)= -0.5*g*t(i)^2 + y2*t(i) + y1;
end
plot (t,Y,'r')
clear Y    

% Beschriftung Fenster
title('Vergleich numerische/analytische Lösung')
xlabel('Zeit [s]')
ylabel ('Höhe [m]')
xlim([0 24])
set(gca, 'Xtick', 0:2:24); 

grid on