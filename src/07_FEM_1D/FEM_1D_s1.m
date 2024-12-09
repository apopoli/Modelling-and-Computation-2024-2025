function [phi] = FEM_1D_s1(x,p,t,phi_a,phi_b)
%FEM_1D_s1 Solves for phi in a 1D domain using the FEM
%   HP: p and t are uniform

n = length(x); % number of nodes
nel = n-1; % number of elements

L = max(x)-min(x); % domain lenght
delta = L/nel; % spacing

% initialize matrices
K = zeros(n,n); % coefficient matrix (nxn), zeros(n)
rhs = zeros(n,1); % right-hand-side matrix (column array)

K_el = zeros(2,2); % element matrix
rhs_el = zeros(2,1); % element right-hand-side array

% loop to assemble K and rhs
for i=1:nel % cycle through all elements

    % element matrix
    K_el(1,1) = p/delta;
    K_el(1,2) = -p/delta;
    K_el(2,1) = -p/delta;
    K_el(2,2) = p/delta;
    
    % assemble element matrix entries into k
    K(i:i+1,i:i+1) = K(i:i+1,i:i+1) + K_el;

    % element right-hand side
    rhs_el(1) = - t*delta/2;
    rhs_el(2) = - t*delta/2;

    % assemble element rhs entries into rhs
    rhs(i:i+1) = rhs(i:i+1) + rhs_el;

end

% boundary conditions
K(1,:) = 0;
K(1,1) = 1;
rhs(1) = phi_a;

K(end,:) = 0;
K(n,n) = 1;
rhs(end) = phi_b;

% solve for phi
phi = K\rhs;

end