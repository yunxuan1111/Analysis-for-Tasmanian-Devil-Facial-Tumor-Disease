% We should write a script to solve the ODEs

% Variables are shared
global Kbirth Kmature Dj Ds Dover Iinfected Idiseased Tincubation Tprogression De Di Dd

% Specify values of the following variables
Kbirth = 0.055;
Kmature = 0.04;
Dj = 0.007;
Ds = 0.02335;
Dover = 2.3*10^(-7);
Iinfected = 1.0*10^(-05);
Idiseased = 3.84*10^(-05);
Tincubation = 0.0976;
Tprogression = 0.0931;
De = 0.02335;
Di = 0.022609;
Dd = 0.29017;

X0 = [16165; 18450; 0; 0; 1];  % initial condition: 16165(J), 18450(S), 0(E), 0(I), 1(D)
tspan = devil_data(:,1)*12;    % define time interval, integrate in months
[t,X]=ode45(@DiseaseODE_model,tspan,X0); % get the numerical solution in vector form
t = t/12;                      % convert to years

% Create a figure that plots the simulation results for J, S, E, I, D, and T along
% with the observed data from Part 1
figure(3)                      % build a figure
hold on                        % combine all the plots
plot(t,X(:,1))                 % plot for J: Juveniles
plot(t,X(:,2))                 % plot for S: Susceptibles
plot(t,X(:,3))                 % plot for E: Exposed
plot(t,X(:,4))                 % plot for I: Infected
plot(t,X(:,5))                 % plot for D: Diseased
plot(t,X(:,1) + X(:,2) + X(:,3) + X(:,4) + X(:,5)) % plot for total (J+S+E+I+D)
plot(devil_data(:,1),devil_data(:,2),'.')   % plot for observed data
xlabel('Year')
ylabel('Population')
title('Disease ODE Model')
legend('J','S','E','I','D','Total','Observed')
grid on
set(gca,'FontSize',12)    % Increase the font size of legends, axis labels, and title
set(gca, 'YTickLabel', get(gca, 'YTick'))  % Display the numbers on y-axis in thousands
hold off