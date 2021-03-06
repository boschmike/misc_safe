
clear all

%% Querbeschleunigung ?ber Radius und Geschwindigkeit

% Initialisierung

v = [10:5:100];
r = [80:20:800];

[V,R] = meshgrid(v,r);

% Kalkulation

A = (V./3.6).^2 ./ R;
A(A>0) = 2.5;
A1 = A;

% Ausgabe
surf(V,R,A);

hold on
alpha 0.5;
surf(V,R,A1);
hold off

title('Querbeschleunigung Fahrzeug [ay = f(v,R)]');
xlabel('Geschwindigkeit v [km/h]');
ylabel('Kurvenradius R [m]');
zlabel('Querbeschl. ay [m/s^2]');
set(gca, 'Xtick', v); 
xlim([min(v) max(v)]);
set(gca, 'Ytick', [100:50:800]); 
ylim([min(r) max(r)]);

clc