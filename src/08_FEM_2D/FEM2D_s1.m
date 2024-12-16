function [phi]=FEM2D_s1(msh,p,t,BC)

% import mesh info
T = msh.TRIANGLES(:,1:3); % connectivity
x = msh.POS(:,1:2); % x and y coordinates of nodes

nnodes = size(x,1); % number of nodes - number of rows of x
nel = size(T,1); % number of elements

% initialize matrices for linear system
K = zeros(nnodes); 
rhs = zeros(nnodes,1);

% cycle to compute and assemble element matrix and right-hand-side element array
for i=1:nel

    i_vertices = T(i,:);
    pv = x(i_vertices,:);
    
    PV = [ones(3,1) pv];
    Area = 1/2*det(PV);

    inv_PV = inv(PV);

    gradL = inv_PV(2:3,:);

    K_el = p * (gradL'*gradL) * Area; % gradL is constant on the element!
    % rhs as shape function sampled at three nodes times t, assumed uniform
    % 1/3*t_i + 1/3*t_j + 1/3*t_k
    rhs_el = ones(1,3) * t * Area/3;  

    K(i_vertices,i_vertices) = K(i_vertices,i_vertices) + K_el;
    rhs(i_vertices) = rhs(i_vertices) + rhs_el';
end

% Boundary conditions
% we have to "transfer" BCs from edeges to nodes
nodal_BC = set_BCs_on_nodes(msh, BC); % BC values on nodes
% example :
% col1: node index
% col2: BC type (2->Dirichlet, 1->Neumann)
% col3: BC value
% nodal_BC =
% 
%      1     2     0
%      2     2     0

for i=1:size(nodal_BC,1)
    i_node = nodal_BC(i,1);
    switch (nodal_BC(i,2)) % type of BC
        case (1) % Neumann
            % nothing to do
        case (2) % Dirichlet
            K(i_node,:) = 0;
            K(i_node,i_node) = 1;
            rhs(i_node) = nodal_BC(i,3); % value
    end
end

% Solve linear system
phi = K\rhs;

end