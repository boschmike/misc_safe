%% Parameter:

m = 1600;                   % [kg]      Fahrzeugmasse
Jr = 10;                    % [kgm^2]   Trägheitsmoment Rad
Jmot = 10;                  % [kgm^2]   Trägheitsmoment Motor
rRad = 0.4;                 % [m]       Raddurchmesser
cW = 0.3;                   % [1]       cW-Wert
A = 2;                      % [m^2]     Fläche Fahrzeug
rho = 1.2;                  % [kg/m^2]  Luftdichte
g = 9.81;                   % [m/s^2]   Erdbeschleunigung
beta_max = 10;              % [°]       Steigungswinkel max.
fr0 = 0.9 * 10^-2;          % [1]       Rollwiderstandsparameter 0
fr1 = 0.15 * 10^-2;         % [1]       Rollwiderstandsparameter 1
fr4 = 0.12 * 10^-2;         % [1]       Rollwiderstandsparameter 4
i=[3.91 2.71 1.57 1 0.89];  % [1]       Getriebeübersetzungen
iHA = 4;                    % [1]       Hinterachsübersetzung
% Schaltschwellen:
v12 = 20;
v23 = 40;
v34 = 75;
v45 = 100;                  % [km/h]    Geschwindigkeit

v0 = 20;                    % [m/s]     Anfangsgeschwindigkeit

% Schlupfkennlinie

% Breakpoints:
s = [0 0.05 0.1 0.2 1];                     %   [1]     Schlupf
% Reibwertdaten:
mu = [0 0.5 0.8 0.6 0.5];                   %   [1]     Reibbeiwert

% Motorkennfeld 

% Breakpoints:
Winkel_DK = [0 10 20 30 50 90];             %   [°]     DK-Winkel
nMot = [600 1000 2000 3000 4000 5000 6000]; %   [U/min] Motordrehzahl
% Matrizendaten:
Mmot = [60  100 101 102 103 105;
        50  90  110 120 122 124;
        0   50  125 140 160 170;
        0   30  100 150 166 175;
        0   0   60  135 170 175;
        0   0   40  120 165 180;
        0   0   0   85  148 175;]           %   [Nm]    Motormoment
    
    