clear all

%% Berechnung z-Funktion eines konfigurierbaren Butterworth-Filters 
%(Basis: Signaltheorie/Anleitung_Versuch_9_Filter.pdf und ISO 15037)

% FINALLY WORKING!

% Variable s anlegen:
syms s;

% Variables:

% Edge frequency (Hz):
fD = 3;
wD = fD * 2 * pi();

% Calculations:

% Übertragungsfunktion BW n. Ordnung:
H = (1 + s/wD) * (1 + 0.445*s/wD + (s/wD)^2) * (1 + 1.247*s/wD + (s/wD)^2) * (1 + 1.8019*s/wD + (s/wD)^2);

% Ausmultiplizieren:
h = expand(H)

% Polinominalkoeffizienten in Nenner-Vektor setzen:
den = sym2poly(h)

% Zähler-Vektor:
num = 1;

% s-Übertragungsfunktion:
sFcn = tf(num, den)

figure(1)
stepplot(sFcn)

% z-Funktion nach Tustin-Methode bilden (inkl. diskreter Timestep):
Ts = 0.015;
zFcn = c2d(sFcn,Ts,'tustin')

% Ausgabe der Koeffizeienten aus obiger z-Funktion:
[numCell , denCell , TsScaler] = tfdata(zFcn);
zaeh = [numCell{:}];
nenn = [denCell{:}];

% Zeichne beide Frequenzgänge (Bode-Diagramme):
opts = bodeoptions('cstprefs');
opts.FreqScale = 'linear';
opts.MagScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';

figure(2)
% bode(sFcn, opts)
bode(sFcn, zFcn, opts)

grid on

% HALDE:
% e = sqrt((1 / 10^(A_n / 20))^2 - 1);
% Serial edge frquency gain (dB):
% A_n = 10^((20 * log10(A_n_eq_1)) / n / 20);
 