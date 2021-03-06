clear all

%% Calculation tool in order to get the z-function of a defined (butterworth) s-function:
%(Basis: Signaltheorie/Anleitung_Versuch_9_Filter.pdf [TU Munich], https://de.wikipedia.org/wiki/Butterworth-Filter and ISO 15037)
% Version: WORKING!

% VARIABLEN:

% Declare variable s:
syms s;

% Passband frequency (Hz):
fD = 3;
wD = fD * 2 * pi();

% CALCULATIONS:

% Transfer-function BW 7th order (-3db @ passband-frequency/Durchlassfrequenz):
H = (1 + s/wD) * (1 + 0.445*s/wD + (s/wD)^2) * (1 + 1.247*s/wD + (s/wD)^2) * (1 + 1.8019*s/wD + (s/wD)^2);

% Expansion:
h = expand(H)

% Set polynominalcoefficients in den-vector (Nenner):
den = sym2poly(h)

% Num-vector (Z?hler):
num = 1;

% s-function:
sFcn = tf(num, den)

% Plot step response:
figure(1)
stepplot(sFcn)

% z-function ? la Tustin-method (incl. discrete timestep):
Ts = 0.01;
zFcn = c2d(sFcn,Ts,'tustin')

% Put coefficients of z-function out:
[numCell , denCell , TsScaler] = tfdata(zFcn);
zaeh = [numCell{:}];
nenn = [denCell{:}];

% Plot frequency response (Bode-diagram):
opts = bodeoptions('cstprefs');
opts.FreqScale = 'linear';
opts.MagScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
figure(2)
bode(sFcn, zFcn, opts)
grid on

% Write:
csvwrite('param_zaeh.csv', zaeh);
csvwrite('param_nenn.csv', nenn);
 