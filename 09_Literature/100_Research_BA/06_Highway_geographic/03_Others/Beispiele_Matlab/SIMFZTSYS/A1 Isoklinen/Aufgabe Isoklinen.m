% 1)

% Initialisierung

y = [-5:1:5]
t = [0:1:10]
dT = 0.1

% Programm

hold on
for i = 1: length(y)
for j = 1: length(t)
   dy = 2 * t(j)
   plot([t(j) - dT, t(j) + dT],[y(i) - dy * dT, y(i) + dy * dT])
end 
end
grid on



% 2)

% Initialisierung

y = [-5:1:5]
t = [0:1:10]
dT = 0.1

% Programm

hold on
for i = 1: length(y)
for j = 1: length(t)
   dy = -(t(j) / y(i))
   plot([t(j) - dT, t(j) + dT],[y(i) - dy * dT, y(i) + dy * dT])
end 
end
grid on




% 3)

% Initialisierung

y = [-5:1:5]
t = [0:1:10]
tau = 2
u0 = 3
T = 5
w = 2*pi/T
dT = 0.1

% Programm

hold on
for i = 1: length(y)
for j = 1: length(t)
   dy = (u0 * sin(w * t(j)) - y(i)) / tau
   plot([t(j) - dT, t(j) + dT],[y(i) - dy * dT, y(i) + dy * dT])
end 
end
grid on
