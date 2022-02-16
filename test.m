% add relevant subfolders to path
addpath("algorithms/")


% geometrical parameters
L = 20;     % lattice size
dim = 2;    % spatial dimension of the lattice
n = 1;      % O(n) model used (n=1: Ising, n=2: XY, n=3: Heisenberg, ...)

% simulation parameters
beta = 0.4;        % inverse temperature for the simulation (beta=1/T, k_b=1)
B = 0;              % external magnetic field
therm_ups = 200;    % updates until measuring begins (for thermalization)
meas_ups = 200;     % ammount of steps during which measurements are taken

% get neighbors
neighbors = load_geometry(L, dim);

% initialize the system
system = randn(L^dim,n);
for i=1:L^dim
    system(i,:) = system(i,:) / norm(system(i,:));
end

% do the simulation
system_new = metropolis(system, L, dim, n, beta, B, therm_ups, meas_ups, neighbors);

figure(1)
subplot(1, 2, 1), imagesc(reshape(system, L, L));
subplot(1, 2, 2), imagesc(reshape(system_new, L, L));

