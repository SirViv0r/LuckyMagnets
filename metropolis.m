function system = metropolis(system, L, dim, n, beta, B, therm_ups, meas_ups, neighbors)
%METROPOLIS does an MC simulation of a system with the specified
%parameters, using the Metropolis scheme
%
%   input:  original system configuration system, lattice size L, spatial
%           dimension dim, O(n) model vector dimension n, inverse
%           temperature beta, thermalization steps therm_ups, measurement
%           steps meas_ups, matrix of all neighbors neighbors
%   output: tensor containing all lattice sites and their respective states
%           after all simulation steps
%
%   One step of Metropolis goes as follows:
%   1.  Choose a random lattice site
%   2.  Choose a random spin direction
%   3.  Calculate difference in energy that this spin change would result in
%   4.  Change the spin to the newly chosen one with probability
%           P = max(1, exp(-beta*delta_E))
%   5.  Repeat steps 1.-4. L^dim number of times

    

    for i=1:(therm_ups + meas_ups)
        for j = 1:L^dim
            site = randi(L^dim);
            %choose a new orientation
            orientation = randn(1,n);
            orientation = orientation / norm(orientation);
            deltaE=dE(system,B,site,orientation,neighbors);
            if rand()<=exp(-beta*deltaE)
                system(site,:) = orientation;
            end
        end
    end

end

function res = dE(system,B,site,orientation,neighbors)
%dE returns the difference in energy between two states, where only one
%spin differs
%   input:  system configuration system, external field B, changed site
%           site, new orientation orientation, neighbors neighbors
%   output: change in energy

    %external B field always points in x direction
    res = -2*B*system(site,1);
    for i=neighbors(site,:)
        res = res + dot(system(site,:), system(i,:));
        res = res - dot(orientation, system(i,:));
    end

end

