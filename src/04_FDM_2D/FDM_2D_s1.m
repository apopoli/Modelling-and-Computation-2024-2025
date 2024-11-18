function [phi,X,Y] = FDM_2D_s1(geom,t)
%UNTITLED Summary of this function goes here
%   geom: structure with info on the geometry
%   t: source term

nx = geom.nx;
Lx = geom.Lx;
dx = Lx/(nx-1); % nx-1 number of subdivisions along x
x = 0:dx:Lx;

ny = geom.ny;
Ly = geom.Ly;
dy = Ly/(ny-1); % ny-1 number of subdivisions along y
y = 0:dy:Ly;

% so far 2 1D-grids, we need a 2D grid
% X is a matrix where each row is a copy of x, and Y is a matrix where each column is a copy of y
[X,Y] = meshgrid(x,y);

% define [K] and {rhs}
K = zeros(nx*ny); % square matrix
rhs = zeros(nx*ny,1); % column array

% fill K and rhs
kx = 1/dx^2; % horizontal coffients
ky = 1/dy^2; % vertical coefficients
kc = -2*(kx+ky); % central coefficient

for j = 1:ny
    for i = 1:nx
        % compute linear index
        k = (j-1)*nx + i;

        if i==1||i==nx||j==1||j==ny % on the boundary
            K(k,k) = 1;
            rhs(k) = 0; % boundary condition
        else
            % internal nodes
            K(k,k) = kc; % central
            K(k,k+1) = kx; % right
            K(k,k-1) = kx; % left
            K(k,k+nx) = ky; % top
            K(k,k-nx) = ky; % bottom

            rhs(k) = t;
        end
    end
end

% solve linear system
phi = K\rhs;

phi = reshape(phi,nx,ny)'; % make phi a matrix

end