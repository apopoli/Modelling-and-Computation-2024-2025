function [phi,X,Y] = FDM_2D_s2(geom,BCs,t)
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

% CHECK
if not(isa(t,"function_handle")) % check if t is not an anonymous function
    t = @(x,y) t;
end

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

        if and(i==1,j==1) % on S-W corner
            K(k,k) = 1;
            rhs(k) = 0.5*(BCs.S.val+BCs.W.val); % average
        elseif(j==1) % S-edge
            K(k,k) = 1;
            rhs(k) = BCs.S.val;
        elseif(i==1) % W-edge
            K(k,k) = 1;
            rhs(k) = BCs.W.val;
        elseif and(i==nx,j==ny) % N-E corner
            K(k,k) = kc; % central
            K(k,k-1) = 2*kx; % left
            K(k,k-nx) = 2*ky; % bottom

            rhs(k) = t(x(i),y(j))...
                - 2*BCs.E.val/dx - 2*BCs.N.val/dy; % evaluates t at considered node
        elseif(i==nx)
            K(k,k) = kc; % central
            K(k,k-1) = 2*kx; % left
            K(k,k+nx) = ky; % top
            K(k,k-nx) = ky; % bottom

            rhs(k) = t(x(i),y(j)) - 2*BCs.E.val/dx; % evaluates t at considered node
        elseif (j==ny) % N-edge
            % internal nodes
            K(k,k) = kc; % central
            K(k,k+1) = kx; % right
            K(k,k-1) = kx; % left
            K(k,k-nx) = 2*ky; % bottom

            rhs(k) = t(x(i),y(j)) - 2*BCs.N.val/dy; % evaluates t at considered node
        else
            % internal nodes
            K(k,k) = kc; % central
            K(k,k+1) = kx; % right
            K(k,k-1) = kx; % left
            K(k,k+nx) = ky; % top
            K(k,k-nx) = ky; % bottom

            rhs(k) = t(x(i),y(j)); % evaluates t at considered node
        end
    end
end

% solve linear system
phi = K\rhs;

phi = reshape(phi,nx,ny)'; % make phi a matrix

end