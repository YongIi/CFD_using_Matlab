clear all   % clear all the variables in the workspace and start fresh
close all   % close all figures
clc         % clear cmd window

%% double percentage sign can be used to highlight different sections
%% every section can be executed by hitting control and enter

%% Defining the polynomial function
poly_p=[3 5 7];   %decreasing order of x and their coefficient, 1x3 matrix 

%% Derivativing the function - theoretically
p_der = polyder(poly_p);
p_der_eval = polyval(p_der,0)

%% Finite difference method - Forward
x_0 = 0;
h=0.2;
der_for_diff_first = (polyval(poly_p,x_0+h)-polyval(poly_p,x_0))/h

%% Finite difference method - Backward
x_0 = 0;
h=0.2;
der_bac_diff_first = (polyval(poly_p,x_0)-polyval(poly_p,x_0-h))/h

%% Finite difference method - Central
x_0=0;
h=0.2;
der_cen_diff_first = (polyval(poly_p,x_0+h)-polyval(poly_p,x_0-h))/(2*h)


