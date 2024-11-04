%% implement f(x) and df/dx and plot between 0 and 2
clear variables

f = @(x) 2*x.^4 + 3*x.^3 + x.^2 + 0.5*x - 3;
df_dx_e = @(x) 8*x.^3 + 9*x.^2 + 2*x + 0.5;

x = linspace(0,2,25);

plot(x,f(x),'-o',...
    x,df_dx_e(x),'-x');
xlabel('x')
fontsize(14,'points')
legend('f(x)','df/dx','Location','best');

%% Testing numerical formulas
clc

x = 1; % point for evaluation of derivative

% define anonymous function for FWD/BWD/CD
df_dx_FW = @(x,h) (f(x+h)-f(x))./h;
df_dx_BW = @(x,h) (f(x)-f(x-h))./h;
df_dx_C = @(x,h) (f(x+h)-f(x-h))./(2*h);

h = 1E-3;
df_dx_FW(x,h)
df_dx_BW(x,h)
df_dx_C(x,h)

format long

T = table(h,df_dx_e(x),...
    df_dx_FW(x,h),df_dx_BW(x,h),df_dx_C(x,h),...
    'VariableNames',{'h','exact','FWD','BWD','CD'});
disp(T)

%% make it systematic
h = logspace(-16,-1,16);

% use transpose operator to turn row-arrays to column-arrays
T = table(h',df_dx_e(repelem(x,16))',...
    df_dx_FW(x,h)',df_dx_BW(x,h)',df_dx_C(x,h)',...
    'VariableNames',{'h','exact','FWD','BWD','CD'});
disp(T)

% we see effect of:
% roundoff-error -> machine arithmetics
% truncation error -> truncation in Taylor series

%% Plot of the error
h = logspace(-16,-1,1E2);

% define a relative error function
err = @(x,h,fun) abs((df_dx_e(x)-fun(x,h))/df_dx_e(x));

loglog(h,err(x,h,df_dx_FW),...
    h,err(x,h,df_dx_BW),'--',...
    h,err(x,h,df_dx_C),'-.','LineWidth',2)
grid on
xlabel('h');
ylabel('relative error')
legend('FW','BW','C','Location','best')
fontsize(14,'points')

% roundoff error proportional to eps/h
% truncation error proportional to:
% h (first-order methods)
% h^2 (second-order methods)

% With CD, the value of h for which truncation error
% is comparable to roundoff error is much larger than
% for first-order methods

% Plot err for FWD and eps/h, h
figure
loglog(h,err(x,h,df_dx_FW),h,eps./h,'--',h,h,'--','LineWidth',2)
legend('err FW','theoretical roundoff','theoretical truncation');
ylim([1E-10 inf]);

% Try to do the same for CD
% theoretical roundoff error: eps/h
% theoretical truncation error: h^2

