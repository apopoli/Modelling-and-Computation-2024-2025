clear variables
clc % delete previous text in command

format long % enables full precision in showing results

eps_0 = 8.854E-12; % electric permittivity (F/m)
disp(eps_0);

kb = 1.38E-23; % Boltzmann constant (J/K)
disp(kb);

Na = 6.022E23; % Avogadro's number (-)
disp(Na);

% Let's test logical operators...
isequal(Na,Na)

isequal(Na,Na-kb) % surprise... MATLAB uses a finite number of digits to represent numbers
Na + kb

%% what are the limits
realmax % largest number considered by matlab

realmin % smallest number considered by matlab