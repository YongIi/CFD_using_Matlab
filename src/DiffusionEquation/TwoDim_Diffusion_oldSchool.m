clear all   % clear all the variables in the workspace and start fresh
close all   % close all figures
clc         % clear cmd window

%% defining the mesh
n_points = 51;
dom_size = 1;
h = dom_size/(n_points - 1);

%% Initialising the problem and Boundary conditions
y(n_points, n_points) = 0;
y(1,:) = 1; 

y_new(n_points, n_points) = 0;
y_new(1,:) = 1;

error_mag = 1;  %error magnitude, this particular definition/value is only for the first loop to get into the calulations
error_req = 1e-6;  %tolerance: required error 
iterations = 0; %record how many iterations to converge
iterations1 = 0;

%% Calculations
while error_mag > error_req
    %solve the discretized form of governing equations
    for i = 2: (n_points-1)
        for j = 2: (n_points-1)
            y_new(i,j) = 0.25.*(y(i-1,j)+y(i+1,j)+y(i,j-1)+y(i,j+1));    %the dot .means that it's multiplied to every element
            iterations = iterations + 1;
        end
    end
    iterations1 = iterations1 + 1;
    
    %calulation of error magnitude
    error_mag = 0;
    for i = 2: (n_points-1)
        for j = 2: (n_points-1)
            error_mag = error_mag + abs(y(i,j)-y_new(i,j));
        end
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
