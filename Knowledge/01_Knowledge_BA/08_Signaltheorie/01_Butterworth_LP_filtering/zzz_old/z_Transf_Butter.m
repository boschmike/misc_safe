clear all

% Variable s anlegen:
syms s;

% % �bertragungsfunktion BW 7. Ordnung:
% H = (s + 1) * (s^2 + 0.445*s + 1) * (s^2 + 1.247*s + 1) * (s^2 + 1.8019*s + 1);

% % �bertragungsfunktion BW 4. Ordnung:
% H = (1 + 0.765*s + s^2) * (1 + 1.848*s + s^2);

% % �bertragungsfunktion BW 3. Ordnung:
% H = (s + 1) * (s^2 + s + 1);

% �bertragungsfunktion BW 1. Ordnung:
H = 2*s + 1;

% Ausmultiplizieren:
h = expand(H);

% Polinominalkoeffizienten in Nenner-Vektor setzen:
den = sym2poly(h);

% Z�hler-Vektor:
num = 1;

% s-�bertragungsfunktion:
sFcn = tf(num, den)

% z-Funktion nach Tustin-Methode bilden (inkl. diskreter Timestep):
Ts = 0.005;
zFcn = c2d(sFcn,Ts,'tustin')

% Ausgabe der Koeffizeienten aus obiger z-Funktion:
[numCell , denCell , TsScaler] = tfdata(zFcn);

% Zeichne beide Frequenzg�nge (Bode-Diagramme):
bode(sFcn, zFcn)
grid on