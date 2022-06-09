% Workspace leeren:

clc
clear all

%% Kennlinie HKCM R40x15x30NI-N40 Permanentmagnet

% Kennlinie anhand HKCM-Formal und Haltekraft aus Datenblatt:

F_halte_PM = 840;               % Haltekraft Eisenplatte    [N]
Faktor_St37 = 1;                % Materialfaktor            [1] (hier: =1, da Haltekraft direkt gemessen)


%% Initialisierung der Systemgrößen

% Endanschläge:
v_max = 0;                      % [m/s]     max. Aufprallgeschwindigkeit
c_stop = 1.626*10^8;            % [N/m]     Federsteifigkeit Anschlagsys.
d_stop = 11000;                 % [Ns/m]    Scheindämpfung Endanschlag

% Hub/Abstände/Maße/Konstanten:
h = 8;                          % [mm]      Ventilhub gesamt
s_Luft_PM = 0.05;               % [mm]      min. Luftspalt P-Magnet
h_0 = -4;                       % [mm]      Anfangspos. (h_0 aus [-4,4])
v_0 = 0;                        % [mm/s]    Anfangsgeschwindigkeit
g = 9.81;                       % [m/s^2]   Erdbeschleunigung
my_GRHR = 0.3;                  % [1]       Reifkoeffizient PA/Stahö

% Permanentmagnete (ringförmig):
D_Pmag = 40;                    % [mm]      Außendurchmesser
d_Pmag = 15;                    % [mm]      Innendurchmesser 
h_Pmag = 30;                    % [mm]      Höhe

% Ventilkörper:
d_Schaft = 8;                   % [mm]      Schaftdurchmesser grundlegend10
D_Teller = D_Pmag;              % [mm]      Tellerdurchmesser
t_Teller = 7;                   % [mm]      Tellderdicke      
l_Luft = 0.5;                   % [mm]      Abstand "Luft"

% Schraubenfeder (2 Stück):
c_Einzel = 94.595;              % [N/mm]    Federkonstante (Einzelfeder)
c_Ersatz = 2 * c_Einzel;        % [N/mm]    Federkonstante (vorgespannt)
m_Feder = 0.031008;             % [kg]      eff. bewegte Masse der Federn
m_FS = 0.0049;                  % [kg]      Masse Federscheibe 
m_SR = 0.00092;                 % [kg]      Masse Sicherungsring

% IMPORT Masse Ventilkörper aus CAD:
m_VK = 0.171;                   % [kg]      gesamt bewegte Masse

% Berechnung dynamische Masse:

m_dyn = m_VK + m_Feder + 2 * m_FS + 2 * m_SR
S = [0:0.2:10];

for i = 1 : length(S)
    F(i) = F_halte_PM * Faktor_St37 / (1 + S(i));
end

% Grafische Abbildung (Zelle 1):

subplot(1,2,1)
plot(S, F, 'r')
title('Kennlinie: HKCM R40x15x30Ni-N40')
xlabel('Hub [mm]')
ylabel('Kraft [N]')
ylim([0 700])
set(gca, 'Ytick', 0:50:700); 
xlim([0 10])
set(gca, 'Xtick', 0:1:10);
legend('Kraft Permanentmagnet')
grid on

%% Kennlinien Feder und Feder + Permanentmagnet

S_total = [(-h/2):0.1:(h/2)];

% Kennlinien berechnen:

for i = 1 : length(S_total)
    s_oben = S_total(i) + (h/2) + s_Luft_PM;
    s_unten = -S_total(i) + (h/2) + s_Luft_PM;
    s_Feder = S_total(i);
    F_pm_oben = F_halte_PM * Faktor_St37 / (1 + s_oben);
    F_pm_unten = F_halte_PM * Faktor_St37 / (1 + s_unten);
    
    F_Feder(i) = -c_Ersatz * s_Feder;
    F_total(i) = -F_pm_oben + F_pm_unten + F_Feder(i);
end

% Ausgabe min. Haltekraft Elektromagnet: 
F_halte_EM = F_total(1)

% Grafische Abbildung (Zelle 2, beide Kennlinien):
 
subplot(1,2,2)
hold on
plot(S_total, F_total, 'r')
plot(S_total, F_Feder, 'b')
hold off
title('Kennlinien: Feder und Feder + Permanentmagnet')
xlabel('Hub [mm]')
ylabel('Kraft [N]')
ylim([-1000 1000])
set(gca, 'Ytick', -1000:250:1000); 
xlim([(-h/2) (h/2)])
set(gca, 'Xtick', (-h/2):1:(h/2));
legend('Feder und Permanentmagnet (kombiniert)', 'Feder Febrotec D13530 (R=94.6 N/mm)')
grid on
