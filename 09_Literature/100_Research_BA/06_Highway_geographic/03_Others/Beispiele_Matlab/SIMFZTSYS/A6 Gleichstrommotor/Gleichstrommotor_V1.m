clear all
clc

%% Parameter:

k_mot = 0.03;               % [Vs]      Motorkonstante
J_mot = 0.0001;             % [kgm^2]   Trägheitsmoment Motor
L = 0.013;                  % [H]       Induktivität Motorspule
R = 2;                      % [Ohm]     Widerstand Motorwicklung
M_Last = 0.05;              % [Nm]      Lastmoment
M_Reib = 0.01;              % [Nm]      Reibmoment
U = 12;                     % [V]       Betriebsspannung