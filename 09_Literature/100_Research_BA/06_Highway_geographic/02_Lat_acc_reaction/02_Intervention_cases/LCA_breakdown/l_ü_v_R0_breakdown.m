clc
clear all

% Init:

v0 = [10:5:85];
R0 = [250:50:1500];
ayMax = 6;
tRea = 1.5;
bS = 3.75;
bF = 2.55;
rMin = 8;
aV = 2;

[V,R] = meshgrid(v0,R0);

% Calc:

r = (V./3.6).^2./ayMax;
r(r<rMin) = rMin;
x1 = R - r;
y1 = (V./3.6).*tRea + aV;
l = R + bS/2 - bF/2 - (sqrt(x1.^2 + y1.^2) + r);

lmax = l;
l(l~=0) = 0;

% Ausgabe
surf(V,R,l);
 
hold on
alpha 0.3;
surf(V,R,lmax);
hold off

title(sprintf('Sollspurabweichung (Systemausfall und Fahrerreaktion mit aY = %f [m/s^2], v = konst)', ayMax));
xlabel('Geschwindigkeit v [km/h]');
ylabel('Kurvenradius R [m]');
zlabel('Abstand Außenmarkierung [m]');
set(gca, 'Xtick', v0); 
xlim([min(v0) max(v0)]);
set(gca, 'Ytick', R0); 
ylim([min(R0) max(R0)]);
