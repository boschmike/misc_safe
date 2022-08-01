clear all

%% PROJEKT "Aktiver Stabilisator"

% Daten Gravitation:

g = 9.81;                                   % Erdbeschleunigung     [m/s2]

% Daten Aktuator:

n_Zyl = 2;                                  % Anzahl Aktorzylinder  [1]
d_Kolben = 0.16;                            % Durchmesser Zylinder  [m]
h_Aktor = 0.25;                             % Hebelarm Stabiaktor   [m]
A_Kolben = n_Zyl*d_Kolben^2*pi()/4;         % Kolbenfläche          [m2]              

% Daten Achse:

b_r = 2.3;                                  % Spurbreite            [m]
b_f = 1.7;                                  % Federabstand wirksam  [m]
b_d = 1.9;                                  % Dämpferabstand wirks. [m]
m_A = 250;                                  % Masse Achse           [kg]
J_x_A = 150;                                % Trägh.m. Achse X-X    [kgm2]
c = 220725;                                 % Federkonstante Achsf. [N/m]
d = 23000;                                  % Dämpferkonstante      [Ns/m]

% Daten Räder:

m_R = 80;                                   % Masse Komplettrad     [kg]
c_R = 949935;                               % Federkonstante        [N/m]
d_R = 500;                                  % Dämpferkonstante      [Ns/m]

% Daten Stabilisator:

b_s = 1;                                    % Breite Stabi wirksam  [m]
h_Stabi = 0.30;                             % Hebelarm Stabi        [m]
G = 79.3 * 10^9;                            % Schubmodul Stahl      [N/m2]
s_Stabi = 0.006;                            % Wandstärke Stabi      [m]
d_m_Stabi = 0.06;                           % mitl. Durchm. Stabi   [m]
I_p_Stabi = 2*pi()*(d_m_Stabi/2)^3*s_Stabi  % pol. Flächenm. Stabi  [m4]

% Daten Fahrzeugaufbau:

m_F = 5400;                                 % red. Fahrzeugmasse    [kg]
h_S_DZ = 0.7;                               % Schwerp.höhe wirksam  [m]
J_x_F = 5500;                               % Trägh.m. Aufbau X-X   [kgm2]
