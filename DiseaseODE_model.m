% Create a function to return the right-hand side of the ODE system given by Eqs.(3)-(7)
function d_output = DiseaseODE_model(t,X) 

% Variables are shared
global Kbirth Kmature Dj Ds Dover Iinfected Idiseased Tincubation Tprogression De Di Dd
J = X(1);     % Let the population of Juvenile devils correspond to X(1)
S = X(2);     % Let the population of Susceptibles adult devils correspond to X(2)
E = X(3);     % Let the population of Exposed adult devils correspond to X(3)
I = X(4);     % Let the population of Infected adult devils correspond to X(4)
D = X(5);     % Let the population of Diseased adult devils correspond to X(5)
T = J + S + E + I + D;   % Let T be the total population

% Define the differential equation
d_output = [Kbirth*(S+E+I)-Kmature*J-Dj*J-Dover*J*T; 
    Kmature*J-Iinfected*S*I-Idiseased*S*D-Ds*S-Dover*S*T;
    Iinfected*S*I + Idiseased*S*D - Tincubation*E - De*E - Dover*E*T;
    Tincubation*E - Tprogression*I - Di*I - Dover*I*T;
    Tprogression*I - Dd*D - Dover*D*T];  
end