%% ES 204 Dynamics - The Four‑Petal Flight: Dynamics of Pilot Reaction Forces Analysis
% This script computes and plots the reaction of the seat on a pilot in
% flight
%
% Given:
%   v_p = 80(m/s) - constant speed
%  W = 130 (lb) - Weight
%  g = 32.2 (ft/s^2) - gravity
%  m = W/g (slugs) - weight
% r = -600cos2θ (ft) - path


clc
clear
close all
%% Setting constants
  v_p = 80;
  W = 130;
  g = 32.2;  
  m = W/g;  

  %% Setup
  theta_deg = 0:1:90;

  theta = deg2rad(theta_deg);

%% Calculations for r derivatives with respect to theta
r = -600.*cos(2.* theta); %(ft)

%simple derivative in this case since r is differentiated with respect to θ

dr_dtheta = 1200.*sin(2.* theta);  %(ft/rad)

% second derivative

d2r_dtheta2 = 2400.*cos(2.* theta);    %(ft/rad^2)

%% Calculating angular velocity(theta dot)

%from the velocity components (transverse and radial): 
%v_p^2 = (dr/dt)^2 + (r*dθ/dt)^2

%To break it down:

%Radial Velocity:
%v_r = (dr/dt) = dr_dtheta * theta_dot

%Transverse velocity:
%v_theta= r * theta_dot

%v_p is the magnitude of the radial and transverse velocities.

%simplifying:
%v_p^2 = [(dr_dtheta)^2 + (r)^2] * theta_dot^2
%rearranging:
% theta_dot = v_p / sqrt((dr_dtheta)^2 + (r)^2)

%let:

denominator = dr_dtheta .^2 + r .^2;

theta_dot = v_p ./ sqrt(denominator); %(rad/s)

%% Calculating angular acceleration (theta double dot)

%gotten by differentiating theta-dot w.r.t 

%theta_double_dot = -v_p^2*[r^2 + (dr_dtheta)^2]^(-2) * (dr_dtheta)[ r +
%d2r_dtheta2]

%From the angular velocity calculation, we know: denominator = dr_dtheta .^2 + r .^2

%Creating another variable:
numerator = dr_dtheta .* (r + d2r_dtheta2);

%Putting it all together:

theta_double_dot = -(v_p^2)* numerator / (denominator.^2);

%% solving for r_dot and r_doubledot:
% using chain rule:

r_dot = dr_dtheta .* theta_dot;

r_doubledot = d2r_dtheta2 .* theta_dot.^2 + dr_dtheta .* theta_double_dot;

%% Calculating acceleration components

%Radial acceleration
a_r = r_doubledot - r.*theta_dot.^2;

%Transverse acceleration
a_theta = r.* theta_double_dot + 2 .* r_dot.*theta_dot;

%% Now that these have been calculated, the force analysis can be done
%since fbd = kinetic digram

%Weight acts downwards and N acts perp to the path

% we need to find the angle between the radial axis and the tangent:

psi = atan(r./ dr_dtheta);

%Resolving the weight components:
W_r = -W.* sin(theta);
W_theta = -W.* cos(theta);

%using Newton's second law of motion:

%N = (m.*a_theta - W_theta)./ cos(psi);

%N_r + W_r = m*a_r 
%Rearranging:
%N_r = m*a_r - W_r;

N_r = m*a_r - W_r;  %radial component of seat force(lb)


%N_theta + W_theta = m* a_theta
%Rearranging:
N_theta = m*a_theta - W_theta;

N_theta = m*a_theta - W_theta;    %tranverse component of seat force(lb)

%Since the N required is the magnitude:

N = sqrt(N_r.^2 + N_theta.^2); 

%% Plotting the graph:

plot(theta_deg, N, 'LineWidth', 2)
grid on;
xlabel('Theta(°)');
ylabel('Seat Reaction Force (lb)');
title('Seat Reaction Force N vs Theta')

