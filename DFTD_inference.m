% We should write a script to solve the ODEs
clear
clc
array = zeros(176,1);     % preallocate a 176-by-1 matrix
DFTD_start = (5:1:180);
for i = 5:1:180
    [t1, y, error] = CompleteSim_fun(i);
    array(i-4,1) = error;  % Store the error outputted from the function in an array
    pause(0.005)           % a pause(0.005) to control the animation speed
end

% plot DFTD_start vs. error
figure(4)
plot(DFTD_start,array)
title("Error Analysis (Complete ODE Model vs Data)")
xlabel("DFTD Start Time (months)")
ylabel("Error")
grid on
set(gca,'FontSize',12)

% min(DFTD_start)=106 by graph

% plot J, S, E, I, D, and T for the best value of
% DFTD_start found in part (b-c) along with the observed data
DFTD_start = 106;
load('devil_data.mat')
[t, y, error] = CompleteSim_fun(DFTD_start); % get the time for the lowest DFTD_start value
t = 1985 + t/12;           % generate the x axis in year
figure(5)
hold on
plot(t,y(:,1),'LineWidth',3)
plot(t,y(:,2),'LineWidth',3)
plot(t,y(:,3),'LineWidth',3)
plot(t,y(:,4),'LineWidth',3)
plot(t,y(:,5),'LineWidth',3)
plot(t,y(:,1) + y(:,2) + y(:,3) + y(:,4) + y(:,5),'LineWidth',3)
plot(devil_data(:,1),devil_data(:,2),'.')
xline(1985 + DFTD_start/12,'--')  % plot the best value of DFTD_start
xlabel('Year')
ylabel('Population')
set(gca, 'YTickLabel', get(gca, 'YTick'))
title('ODE Model for Population of Tasmanian Devils')
grid on
legend('J','S','E','I','Dis','Total','Observed Data','DFTD Start Time')
set(gca,'FontSize',12)
set(gca, 'YTickLabel', get(gca, 'YTick'))
hold off

