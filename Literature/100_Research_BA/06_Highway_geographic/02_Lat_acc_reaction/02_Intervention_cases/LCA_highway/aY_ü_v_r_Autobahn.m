
clear all

%% Querbeschleunigung über Radius und Geschwindigkeit

% Initialisierung

v = [10:5:100];
r = [250:50:1200];
ayMax = 2.5;

[V,R] = meshgrid(v,r);

% Kalkulation

A = (V./3.6).^2 ./ R;
Amax = A;
A(A>0) = ayMax;

% Ausgabe
surf(V,R,A);

hold on
alpha 0.3;
surf(V,R,Amax);
hold off

title('Querbeschleunigung Fahrzeug (Autobahnfahrt) [ay = f(v,R)]');
xlabel('Geschwindigkeit v [km/h]');
ylabel('Kurvenradius R [m]');
zlabel('Querbeschl. ay [m/s^2]');
set(gca, 'Xtick', v); 
xlim([min(v) max(v)]);
set(gca, 'Ytick', r); 
ylim([min(r) max(r)]);

clc