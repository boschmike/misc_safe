clear all

%% Berechnung z-Funktion eines konfigurierbaren Butterworth-Filters 
%(Basis: Signaltheorie/Anleitung_Versuch_9_Filter.pdf und ISO 15037) 

% Variable s anlegen:
syms s;

% Variables:

% Edge frequency (Hz):
fD = 2;
wD = fD * 2 * pi();
% Passband frequency (Hz):
fS = 6;
wS = fS * 2 * pi();
% Thresholds:
HD = 0.995;
HS = 0.01;

% Calculations:

% Epsilon:
e = sqrt((1/HD^2) - 1);
% Lamda:
l = sqrt((1/HS^2) - 1);
% Filter order:
n_raw = log10(l/e)/log10(wS/wD);
n = ceil(n_raw);

% Übertragungsfunktion BW n. Ordnung:
H = 1 + e * (-s / wD)^3

% Ausmultiplizieren:
h = expand(H)

% Polinominalkoeffizienten in Nenner-Vektor setzen:
den = sym2poly(h)

% den(2)= 0.0000000000001;
% den(3) = den(2);
% den(4) = den(3);
% den(5) = den(4);
% den(6) = den(5);
% den(7) = den(6);

% Zähler-Vektor:
num = 1;

% s-Übertragungsfunktion:
sFcn = tf(num, den)

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
bode(sFcn, zFcn, opts)

grid on


% HALDE:

% e = sqrt((1 / 10^(A_n / 20))^2 - 1);
% Serial edge frquency gain (dB):
% A_n = 10^((20 * log10(A_n_eq_1)) / n / 20);
 