% Workspace leeren:

clc
clearvars -except F_halte_EM 
 

%% Simulation reibbehafteter Feder-Masse-Schwinger

% Konstruktive Ausführung / Setup:

% - Richtungskonvention: x nach OBEN bzw. (+) POSITIV


%% Kennlinie HKCM R40x15x30NI-N40 Permanentmagnet

% Kennlinie anhand HKCM-Formal und Haltekraft aus Datenblatt:

F_halte_PM = 840;               % Haltekraft Eisenplatte    [N]
Faktor_St37 = 1;                % Materialfaktor            [1] (hier: =1, da Haltekraft direkt gemessen)


%% Initialisierung der Systemgrößen

% Endanschläge:
v_max = 0;                      % [m/s]     max. Aufprallgeschwindigkeit
d_Schaft = 8;                   % [mm]      Schaftdurchmesser ideell federnd
l_Schaft = 85;                  % [mm]      Schaftlänge ideell federnd
E_Stahl = 210000;               % [N/mm^2]  E-Modul Stahl
c_stop = d_Schaft^2 * pi() / 4 * E_Stahl / l_Schaft * 1000            
                                % [N/m]     Federsteifigkeit Anschlagsys.
d_stop = 12000;                 % [Ns/m]    Scheindämpfung Endanschlag

% Reibverluste:

k_Wirbel = 25;                  % [TEST]    TEST
F_reib = 19;                    % [N]       Kraft Coulomb´sche Reibung

% Hub/Abstände/Maße/Konstanten:
h = 8;                          % [mm]      Ventilhub gesamt
s_Luft_PM = 0.05;               % [mm]      min. Luftspalt P-Magnet
s_Luft_EM = 0.15;               % [mm]      min. Luftspalt E-Magnet
h_0 = 4;                        % [mm]      Anfangspos. (h_0 aus [-4,4])
v_0 = 0;                        % [mm/s]    Anfangsgeschwindigkeit
g = 9.81;                       % [m/s^2]   Erdbeschleunigung
my_GRHR = 0.3;                  % [1]       Reifkoeffizient PA/Stahl

% Permanentmagnete (ringförmig):
D_Pmag = 40;                    % [mm]      Außendurchmesser
d_Pmag = 15;                    % [mm]      Innendurchmesser 
h_Pmag = 30;                    % [mm]      Höhe

% Schraubenfeder (2 Stück):
c_Einzel = 94.595;              % [N/mm]    Federkonstante (Einzelfeder)
c_Ersatz = 2 * c_Einzel;        % [N/mm]    Federkonstante (vorgespannt)
m_Feder = 0.031008;             % [kg]      eff. bewegte Masse der Federn
m_FS = 0.0049;                  % [kg]      Masse Federscheibe 
m_SR = 0.00092;                 % [kg]      Masse Sicherungsring

% IMPORT Masse Ventilkörper aus CAD:
m_VK = 0.171;                   % [kg]      bewegte Ventilmasse

% Berechnung dynamische Masse:

m_dyn = m_VK + m_Feder + 2 * m_FS + 2 * m_SR
                                % [kg]      gesamt bewegte Masse


%% Elektromagnete

% Allgemeine Größen:

my_r = 225;                         % [1]   Permeabilität Eisen
my_0 = 1.257 * 10^-6;               % [1]   Permeabilität Luft
d_i = 17.3;                         % [mm]  Spulendurchmesser innen
k_w = 0.86;                         % [1]   Füllfaktor Wicklung
rho = 0.0178;                       % [mm^2Ohm/m] spez. Leitungswiderstand
U_bat = 48;                         % [V]   Batteriespannung
R_v = 2.7;                            % [Ohm] Vorwiderstand Spule

% Elektromagnet speziell:

d_Schaft_Lager = 6;                 % [mm]  Durchmesser Schaft @ Gleitlager
d_Anker = 12.2;                     % [mm]  Durchmesser Tauchanker
l = 32;                             % [mm]  eff. Spulenlänge
t = 7;                              % [mm]  eff. Spulendicke
d_D = 1.15;                         % [mm]  Durchmesser Kupferlackdraht
d_Cu = 1;                           % [mm]  Durchmesser Kupferleiter

% Berechnungen:
l_Fluss = (2*l + 17/3*t + (d_Anker-d_Schaft_Lager)/2)/1000                         
                                    % [m]   Länge Pfad magn. Fluss
A_Fluss = ((d_Anker/1000)^2 - (d_Schaft_Lager/1000)^2)*pi()/4  
                                    % [m^2] Fläche (v. mag. Fluss d.fl.)
A_w = l*t;                          % [mm^2]Spulenquerschnittsfläche
d_m = d_i + t;                      % [mm]  Mittendurchmesser Spule
n = floor((k_w*A_w*4)/(pi()*d_D^2)) % [1]   Windunggszahl
L_Draht = d_m*pi()*n/1000           % [m]   Drahtlänge pro Spule
R = L_Draht*rho*4/(d_Cu^2*pi())     % [Ohm] Spulenwiderstand              
R_eff = R + R_v                     % [Ohm] effektiver Spulenwiderstand
i_max = U_bat / R_eff               % [A]   max. Spulenstrom
F_max = -0.5*n^2*A_Fluss*my_0*my_r*(1-my_r)*i_max^2/(l_Fluss+s_Luft_EM/1000*(my_r-1))^2
                                    % [N]   Maximalkraft @ max. Strom   
L_max = n^2*A_Fluss*my_0*my_r/(l_Fluss+s_Luft_EM/1000*(my_r-1))
                                    % [H]   max. Induktivität
tau = L_max/R_eff                   % [s]   Zeitkonstante Spule
    