function [x,phi] = FDM_1D_s1(geom,BC,t)
%FDM_1D_s1 Use Finite Difference Method for Poisson's equation in 1D
%   Solves Poisson problem in 1D
%   inputs: geom,BC
%   outputs: x,phi

% collect inputs
a = geom.a;
b = geom.b;
n = geom.n;

x = linspace(a,b,n);
dx = (b-a)/(n-1); % grid spacing

K = zeros(n);
rhs = zeros(n,1);

% cycle on internal nodes
for i=2:n-1
    K(i,i-1) = 1;
    K(i,i) = -2; % main diagonal
    K(i,i+1) = 1;

    rhs(i) = dx^2*t;
end

% boundary conditions
K(1,1) = 1;
rhs(1) = BC.a.val; % value of BC in a

K(n,n) = 1;
rhs(n) = BC.b.val; % value of BC in b

% ready to solve the system!
phi = K\rhs;

end