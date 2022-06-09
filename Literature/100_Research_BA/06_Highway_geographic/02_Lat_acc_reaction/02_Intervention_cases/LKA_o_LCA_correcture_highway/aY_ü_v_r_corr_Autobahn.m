
clc
clear all

% Init:

v0 = [10:5:100];
R0 = [250:50:1200];
ayMax = 2.5;
tC = 2;
p = 0.3;
bS = 3.5;
bF = 2.5;

[V,R] = meshgrid(v0,R0);

% Calc:

s = V./3.6*tC;
Ra = R + bS/2;
Rp = Ra - p;
h = Rp - 0.5*sqrt(4*(Rp.^2) - s.^2);
H = h + p;
r = (4*H.^2+s.^2)./(8*H);
A = (V./3.6).^2./(r-bF/2);

Amax = A;
A(A>0) = ayMax;

% Ausgabe
surf(V,R,A);
 
hold on
alpha 0.3;
surf(V,R,Amax);
hold off

title(sprintf('Querbeschleunigung Fahrzeug (Korrekturmaneuver, p = %f m, v = konst)', p));
xlabel('Geschwindigkeit v [km/h]');
ylabel('Kurvenradius R [m]');
zlabel('Querbeschl. ay [m/s^2]');
set(gca, 'Xtick', v0); 
xlim([min(v0) max(v0)]);
set(gca, 'Ytick', R0); 
ylim([min(R0) max(R0)]);
