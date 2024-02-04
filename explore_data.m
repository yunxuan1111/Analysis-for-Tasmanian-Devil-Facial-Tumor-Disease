% Load devil_data
load('devil_data.mat') 

% Create a figure for the total number of Tasmanian devils vs time
figure(1)                                 % Create a figure
plot(devil_data(:,1),devil_data(:,2),'.') % Plot the figure with points
xlabel('Year')                            
ylabel('Population')                      
title('Total Number of Tasmanian Devils vs Time') 
grid on                                   % Turn the grid on in the figure
set(gca,'FontSize',12)   % Increase the font size of axis labels and title
set(gca, 'YTickLabel', get(gca, 'YTick')) % Display the numbers on y-axis in thousands