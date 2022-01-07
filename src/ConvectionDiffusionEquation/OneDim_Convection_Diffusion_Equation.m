clear all   % clear all the variables in the workspace and start fresh
close all   % close all figures
clc         % clear cmd window

%% defining the problem
n_points = 101;
dom_length = 1;
h = dom_length/(n_points-1);    %grid space
x = 0:h:dom_length;
phi(1) = 10;    %the first index starts from one in matlab while from zero in C
phi(n_points) = 20; %everything else between 1 and n_points would be zero if you don't initialize anything
phi_new(1) = 10;
phi_new(n_points) = 20;
rho = 1;
u = 10;    %we can change it for V&V, such as 1, -20
gamma = 1;
Pec = rho*u*dom_length/gamma    %Peclet number

%% Exact solution
phi_exact = phi(1) + (phi(n_points)-phi(1)).*(exp(Pec.*x/dom_length)-1)./(exp(Pec) - 1);
figure(1);  %assign index to the figure rather than letting matlab to find an arbitrary figure
plot(x, phi_exact, 'ro')   %plot the data markers, 'r' stands for red and 'o' stands for the shape of the markers

%% Numerical solution -- Central Differencing scheme
error_mag = 1;  %error magnitude, this particular definition/value is only for the first loop to get into the iterations
error_req = 1e-7;  %tolerance: required error
iterations = 0; %record how many iterations to converge

while error_mag > error_req     %iterate until reaching steady state, stop when the error between two time steps is small enough
    %solve the discretized form of governing equations
    for i = 2:(n_points-1)  %perform one iteration, solve the solution for all the interior points of the next time step
        a_E = gamma/h - rho*u/2;
        a_W = gamma/h + rho*u/2;
        a_P = gamma/h + gamma/h + rho*u/2 - rho*u/2;
        phi_new(i) = (a_E*phi(i+1) + a_W*phi(i-1))/a_P;
    end
    iterations = iterations + 1;    %after calculating the entire domain, iterations plus one
    %calulation of error magnitude
    error_mag = 0;
    for i = 2:(n_points-1)
        error_mag = error_mag + abs(phi(i)-phi_new(i)); %cumulative error
    end
    phi = phi_new;
end

%% Plotting
 figure(1); %call the figure tagged as 1
 hold on    %don't erase the existing figure
 plot(x, phi, 'b', 'LineWidth', 1)  %'b' stands for blue
 xlabel('x')
 ylabel('phi')
 legend('Exact solution', 'Differnce scheme')
    



