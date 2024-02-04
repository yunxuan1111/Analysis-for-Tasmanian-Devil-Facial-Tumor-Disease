% We should write a script to solve the ODEs
global Kbirth Kmature Dj Ds Dover   % These variables are shared
Kbirth = 0.055;                     % specify value of constant Kbirth
Kmature = 0.04;                     % specify value of constant Kmature
Dj = 0.007;                         % specify value of constant Dj
Ds = 0.02335;                       % specify value of constant Ds
Dover = 2.3*10^(-7);                % specify value of constant Dover
X0 = [16165; 18450];                % initial condition: 16165 J and 18450 S
tspan = devil_data(:,1)*12;         % define time interval, integrate in months
[t,X]=ode45(@DiseaseFreeODE_model,tspan,X0); % get the numerical solution in vector form
t = t/12;                           % convert to years

% Create a figure that plots the simulation results for J, S, and T along
% with the observed data from Part 1
figure(2)                           % build a figure
hold on                             % combine all the plots in figure(2)
plot(t,X(:,1))                      % plot for J
plot(t,X(:,2))                      % plot for S
plot(t,X(:,1) + X(:,2))             % plot for total (J+S)
plot(devil_data(:,1),devil_data(:,2),'.') % plot for observed data
xlabel('Year')                      
ylabel('Population')
title('Disease Free ODE Model')
legend('J','S','Total','Observed')
grid on
set(gca,'FontSize',12)       % Increase the font size of legends, axis labels, and title
set(gca, 'YTickLabel', get(gca, 'YTick')) % Display the numbers on y-axis in thousands
hold off