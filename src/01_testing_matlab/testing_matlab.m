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

%% A few more examples...
clc

x = 1E-6;
y = 1+x;
disp(y)

x = 1E-16;
y = 1+x;
disp(y)

eps % prints out machine precision

% numerical cancellation
a = 1E8 + 1E-5;
b = 1E8;
disp(a-b) % expected: 1E-5

%% visualization
% close all % close all plot windows

y = @(x) ((1+x)-1)./x; % anonymous function, same as fun_y(1)

% logspace(1,3,5) % five logarithmically-spaced values between 1E1 and 1E3
x = logspace(-16,-6,1E3);

loglog(x,y(x),x,ones(length(x)))
xlabel('x')
ylabel('y(x)')
fontsize(14,'points')
legend('Numerical: $y(x) = \frac{(1+x)-1}{x}$','Exact: $y(x) = \frac{(1+x)-1}{x}$','Interpreter','Latex')
