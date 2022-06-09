clear all

% Initialisierung

m = 0.2             % schwingende Masse[kg]
T = [1:0.05:4.5]    % Ventilhubzeit (für vollen Hub) [ms]
h = 8               % Ventilhub [mm]

% Berechnung

for i = 1 : length(T)
   c(i) = (pi / (T(i)/1000))^2 * m / 1000   % c - Federkonstante [N/mm]
   Fh(i) = c(i) * (h / 2) / 1000            % Fh - Haltekraft des Permanentmagnets (Endlage) [kN]
end

% Graphische Ausgabe
set(gca,'GridColor','k')
set(gca,'GridAlpha',0.5)
set(gca,'FontSize',16)
title('Federrate und Haltekraft über Ventilhubzeit (reibungsfrei, m = 200 g, h = 8 mm)')
xlabel('Ventilhubzeit T* [ms]')
set(gca, 'Xtick', T(1):0.25:T(length(T))); 

yyaxis left
plot(T,c)
ylabel('Federrate c [N/mm]') 
ylim([0 1200])
set(gca, 'Ytick', 0:100:1200); 

hold on

yyaxis right
plot(T,Fh)
ylabel('Haltekraft Fh [kN]') 
ylim([0 12])
set(gca, 'Ytick', 0:1:12); 

hold off

grid on