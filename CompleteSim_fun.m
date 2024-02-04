% We will write a function which outputs the time, ODE solution, and error (using Eq. (8))
% DFTD_start means the date when the disease first appeared
function  [t, y, error] = CompleteSim_fun(DFTD_start) 

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

% load "devil_data"
load('devil_data.mat') 

% solve the disease-free version of the model up to DFTD_start
X01 = [16165; 18450; 0; 0; 0];               
tspan1 = 0:1:DFTD_start;
[t1,y1]=ode45(@DiseaseODE_model,tspan1,X01);

% solve the disease version of the model from DFTD_start to 2020 
% using the last values of J and S from the disease-free version
% of the model as initial conditions
X02 = [y1(DFTD_start+1,1); y1(DFTD_start+1,2); 0; 0; 1];
tspan2 = DFTD_start:1:409;
[t2,y2]=ode45(@DiseaseODE_model,tspan2,X02);

% Concatenate the time (t) and solution (y) arrays outputted from the
% two separate calls to ode45 to get one array for t and one array for y
t = cat(1,t1(1:(length(t1)-1),1),t2);
y = cat(1,y1(1:(length(y1)-1),:),y2);

% calculate the error
sum = 0;
T = zeros(410,1);    % preallocate a 410-by-1 matrix
for i = 1:410        % time range is 0:1:409, so there will be 410 total values, which are put into the matrix
    T(i) = y(i,1)+y(i,2)+y(i,3)+y(i,4)+y(i,5); % total value(J+S+E+I+D)
    sum = sum + (T(i)- devil_data(i,2))^2;     % culculate the sum part of error
end
error = sqrt(sum/410);    

% plot a version of Fig 5 corresponding to the value of DFTD_start passed into the function
t1 = 1985 + t/12;                     % get the x axis range in year
figure(6)                             % create a new figure
clf                                   % clear the figure prior to plotting
hold on                               % combine all the following plots
plot(t1,y(:,1),'LineWidth',3)         % plot for J: Juveniles with line width 3
plot(t1,y(:,2),'LineWidth',3)         % plot for S: Susceptibles
plot(t1,y(:,3),'LineWidth',3)         % plot for E: Exposed
plot(t1,y(:,4),'LineWidth',3)         % plot for I: Infected
plot(t1,y(:,5),'LineWidth',3)         % plot for D: Diseased
plot(t1,y(:,1) + y(:,2) + y(:,3) + y(:,4) + y(:,5),'LineWidth',3) % plot for total (J+S+E+I+D)
plot(devil_data(:,1),devil_data(:,2),'.') % plot for observed data
xline(1985 + DFTD_start/12,'--')      % plot for the value of DFTD_start
xlabel('Year')
ylabel('Population')
set(gca, 'YTickLabel', get(gca, 'YTick'))
title('ODE Model for Population of Tasmanian Devils')
grid on
legend('J','S','E','I','Dis','Total','Observed Data','DFTD Start Time')
set(gca,'FontSize',12)
set(gca, 'YTickLabel', get(gca, 'YTick'))
hold off
end