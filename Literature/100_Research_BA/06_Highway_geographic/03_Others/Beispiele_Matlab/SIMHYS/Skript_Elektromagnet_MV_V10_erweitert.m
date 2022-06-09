%Übung Elektromagnet  
clear
close all
te=0.03;
pVec= [12 10 6];  %!!!Variation  

Anzahl=size(pVec,2);

for i= 1:Anzahl
    p=pVec(i);     %Generierung des aktuellen Parameterwerts
Ui=p                %!!!Zuweisung Parameterwert

%Elektromagnet
%Ui=12;              %Eingangsspannung V
w=800;              %Windungszahl 
my0=1.257*0.000001; %magnetische Feldkonstante [Vs/(Am)]
myr=50;             %Permeabilität Stahl
l1=0.052;           %mittlere Weglänge der Feldlinien Eisen [m]
lges=0.06;          %mittlere Weglänge der Feldlinien Eisen + Luft [m]
maxhub=0.002;       %maximaler Ankerhub [m]
R=11;               %elektrischer Widerstand Spule [Ohm]
A=37.7*0.000001;      %Eisenquerschnitt [m^2]
m=0.010;            %Ankermasse [kg]

c_Feder = 1000;     %Federkonstante [N/m]
d_Daempfer = 10;    %Dämpfungskonstante [Ns/m]
F_vorspann = 0.5;   %Federvorspannkraft [N]
p_hyd = 400000;     %Druck [N/m^2]
A_v = 0.002^2*pi()/4; %Hydr. Fläche [m^2]

g=9.81;             %Erdbeschleunigung [m/s^2]

[t,x,y]=sim('Elektromagnet_MV_V10_erweitert', [0 te]); %!!!Simulationssteuerung

% Steuerung Postprozess
farbe = 'b';

if i==2
    farbe = 'r';
end

if i==3
    farbe = 'k';
end

if i==4
    farbe = 'g';
end

if i==5
    farbe = 'c';
end

if i==6
    farbe = 'm';
end

subplot (2,3,1); plot (t,y(:,5))
hold all
grid on
axis ([0 te 0 15])
xlabel('t s')
ylabel ('Spannung  V')

subplot (2,3,4); plot (t,y(:,1))
hold all
grid on
%axis ([0 te 0 1.5])
xlabel('t s')
ylabel ('Strom  A')

subplot (2,3,2); plot (t,y(:,2))
hold all
grid on
%axis ([0 te 0 10])
xlabel('t s')
ylabel ('Weg mm')

subplot (2,3,5); plot (t,y(:,3))
hold all
grid on
xlabel('t s')
ylabel ('Geschwindigkeit m/s')

subplot (2,3,3); plot (t,y(:,4))
hold all
grid on
xlabel('t s')
ylabel ('Magnetkraft N')

subplot (2,3,6); plot (t,y(:,6))
hold all
grid on
xlabel('t s')
ylabel ('dL/dx Vs/Am')

end