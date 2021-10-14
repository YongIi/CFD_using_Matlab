clear all   % clear all the variables in the workspace and start fresh
close all   % close all figures
clc         % clear cmd window

%% defining the mesh
n_points = 5;
dom_size = 1;
h = dom_size/(n_points - 1);

%% Initialising the problem and Boundary conditions
y(1) = 0;
y(n_points) = 1;    %code should be general instead of hard coding

y_new(1) = 0;
y_new(n_points) = 1;    %matlab automatically assumes the points in between are 0

error_mag = 1;  %error magnitude, this particular definition/value is only for the first loop to get into the calulations
error_req = 1e-7;  %tolerance: required error 
iterations = 0; %record how many iterations to converge
iterations1 = 0;

%% Calculations
while error_mag > error_req
    %solve the discretized form of governing equations
    for i = 2: (n_points-1)
        y_new(i) = 0.5.*(y(i-1)+y(i+1));    %the dot .means that it's multiplied to every element
        iterations = iterations + 1;
    end
    iterations1 = iterations1 + 1;
    
    %calulation of error magnitude
    error_mag = 0;
    for i = 2: (n_points-1)
        error_mag = error_mag + abs(y(i)-y_new(i));
    end
    % Assigning new to be old
    y = y_new;
end

%% Plotting
x_dom = ((1:n_points)-1).*h;    %the dot sign .means that every element in the vector gets multiplied by the grid spacing
%figure;plot(x_dom,y);
plot(x_dom,y);