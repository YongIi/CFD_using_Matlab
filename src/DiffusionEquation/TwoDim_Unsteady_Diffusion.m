clear all   % clear all the variables in the workspace and start fresh
close all   % close all figures
clc         % clear cmd window

%% defining the mesh
n_points = 51;
dom_size = 1;
h = dom_size/(n_points - 1);
dt = 0.0001;
alpha = dt/(h*h);

%% Initialising the problem and Boundary conditions
y(n_points, n_points) = 0;
y(1,:) = 1; 

y_new(n_points, n_points) = 0;
y_new(1,:) = 1;

error_mag = 1;  %error magnitude, this particular definition/value is only for the first loop to get into the calulations
error_req = 1e-6;  %tolerance: required error 
iterations = 0; %record how many iterations to converge

%Tracking the error magnitude
error_track = 0;  %used to track the error with time to see how the error increase or decrease with time
%save the error at any particular time step to see how the error changes throught the calculations

%% Calculations
while error_mag > error_req  %iterate until reaching steady state, stop when the error between two time steps is small enough
    %solve the discretized form of governing equations
    for i = 2: (n_points-1)  %perform one iteration, solve the solution of the next time step
        for j = 2: (n_points-1)
            y_new(i,j) = y(i,j)+alpha.*(y(i-1,j)+y(i+1,j)+y(i,j-1)+y(i,j+1)-4*y(i,j));    %the dot .means that it's multiplied to every element
        end
    end
    iterations = iterations + 1; %after calculating the entire domain, iterations plus one
    
    %calulation of error magnitude
    error_mag = 0;
    for i = 2: (n_points-1)
        for j = 2: (n_points-1)
            error_mag = error_mag + abs(y(i,j)-y_new(i,j));
        end
    end
    error_track(iterations) = error_mag;
    
    %output the error, verify how the calculation is proceeding and validate whether you're going in the right direction or not
    if rem(iterations, 1000) == 0
        iterations
        error_mag
    end
    
    % Assigning new to be old
    y = y_new;
end

%% Plotting
x_dom = ((1:n_points)-1).*h;
y_dom = 1-((1:n_points)-1).*h;
[X,Y]=meshgrid(x_dom,y_dom);
contourf(X,Y,y,12)
colorbar

xlabel('x')
ylabel('y')
title('2D\_Diffusion\_Equation')
print(gcf, 'pic_name.png', '-dpng', '-r300');
%get current figure, give its name, type of the file, the resolution: 300 dpi
%which is clear than 'save as png' by default and won't blow up whenever you zoom in the figure

%Plot the error with time
figure;  %open a new figure instead of replacing the old figure
time = dt.*(1:iterations);
plot(time, error_track)

%% Concept of subplots
figure;
subplot(1,2,1)
plot(time,error_track)
subplot(1,2,2)
contourf(X,Y,y,12)
colorbar
