% We should write a function that takes as input t and X, and returns the
% right-hand side of the ODE system given by Eqs.(1)-(2).
function derivative = DiseaseFreeODE_model(t,X) % Define the function
global Kbirth Kmature Dj Ds Dover              % These variables are shared
J = X(1);        % Let the population of juvenile devils correspond to X(1)
S = X(2);        % Let the population of healthy adult devils correspond to X(2)
derivative = [Kbirth*S - Kmature*J - Dj*J - Dover*J*(J+S); 
              Kmature*J - Ds*S - Dover*S*(J+S)];   % Define the differential equation
end