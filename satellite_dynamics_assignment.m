%% ES 204 Dynamics - Satellite Polar Coordinate Analysis
% This script computes and plots the velocity and acceleration components
% of an Earth satellite in polar coordinates.
%
% Given:
%   r = (1.91e7) / (1 + 0.5*cos(theta))  [m]
%   r * v_theta = 8.72e10                 [m^2/s]
%
% Polar coordinate kinematics:
%   v_r     = r_dot
%   v_theta = r * theta_dot
%   a_r     = r_ddot - r * theta_dot^2
%   a_theta = r * theta_ddot + 2 * r_dot * theta_dot

clc
clear
close all

%% Constants
C1 = 1.91e7;        % Constant in r equation
C2 = 8.72e10;       % angular momentum constant [m^2/s]
e = 0.5;            % Eccentricity factor

%% Setup
theta_deg = 0:1:180;              % generate theta values in degrees, 1 degree increments
theta     = deg2rad(theta_deg);   % convert to radians

%% Calculate r for each theta
%Plug in constant values from above

r = C1 ./ (1 + e * cos(theta));

%% To Calculate velocity components
v_theta = C2 ./ r;  % Transverse velocity

% Calculate dr/dtheta
dr_dtheta = (C1 * e * sin(theta)) ./ ((1 + e * cos(theta)).^2);

theta_dot = v_theta ./ r;

% Calculate radial velocity: v_r = (dr/dtheta) * (v_theta / r)
v_r = dr_dtheta .* (v_theta ./ r); %(v_theta ./ r) = theta_dot

% Calculate total velocity magnitude
v = sqrt(v_r.^2 + v_theta.^2);

%% Acceleration calculations

% a_r     = r_doubledot - r * theta_dot^2
% a_theta = r * theta_doubledot + 2 * r_dot * theta_dot

% Finding derivatives first
% We need to differentiate v_r with respect to theta to get r_doubledot
% v_r = dr_dtheta * (v_theta / r) = dr_dtheta * (C2 / r^2)
% r_dot = v_r
% r_doubledot = d(r_dot)/dt = d(r_dot)/dtheta * theta_dot
%(v_theta ./ r) = theta_dot

%Computing d2r_dtheta2 from dr_dtheta to find d_rdot_dtheta
% Second derivative d^2r/dtheta^2
f     = 1 + e*cos(theta);
d2r_dtheta2 = C1* e * (cos(theta).*f + e*2*sin(theta).^2) ./ f.^3;

%d_rdot_dtheta
d_thetadot_dtheta = -2 * C2 * dr_dtheta ./ (r.^3); % from theta_dot = C2/ r^2 also to be used for a_theta calculation
d_rdot_dtheta = d2r_dtheta2 .* theta_dot + dr_dtheta .* d_thetadot_dtheta;

%referrring to the r_doubledot formula:
r_doubledot = d_rdot_dtheta .* theta_dot;

%theta_doubledot for a_theta calculations:
theta_doubledot = d_thetadot_dtheta .* theta_dot;

%Using this for acceleration calculations:
a_r = r_doubledot - r .* theta_dot.^2;

%a_theta = r .* theta_doubledot + 2 * v_r .* theta_dot; %gives very small values close to 0 can be assumed to be zero

%Therefore:
a_theta = zeros(size(theta));

%% Acceleration Components
%from simplified hand calculations(alternative)

% Radial acceleration
%a_r = -C2^2 ./ r.^3;

% Transverse acceleration 
%a_theta = zeros(size(theta));

%% --- Total Acceleration ---
a = sqrt(a_r.^2 + a_theta.^2);

%% To create plots for Velocity
figure('Position', [100, 100, 1200, 800]);

% Plot 1: v_r vs theta
subplot(2,3,1);
plot(theta_deg, v_r, 'b-', 'LineWidth', 2);
xlabel('\theta (degrees)');
ylabel('v_r (m/s)');
title('Radial Velocity vs Angular Position');
grid on;
xlim([0 180]);

% Plot 2: v_theta vs theta
subplot(2,3,2);
plot(theta_deg, v_theta, 'r-', 'LineWidth', 2);
xlabel('\theta (degrees)');
ylabel('v_\theta (m/s)');
title('Transverse Velocity vs Angular Position');
grid on;
xlim([0 180]);

% Plot 3: v vs theta
subplot(2,3,3);
plot(theta_deg, v, 'g-', 'LineWidth', 2);
xlabel('\theta (degrees)');
ylabel('v (m/s)');
title('Total Velocity vs Angular Position');
grid on;
xlim([0 180]);

%% Create plots for Acceleration
% Plot 4: a_r vs theta
subplot(2,3,4);
plot(theta_deg, a_r, 'b-', 'LineWidth', 2);
xlabel('\theta (degrees)');
ylabel('a_r (m/s^2)');
title('Radial Acceleration vs Angular Position');
grid on;
xlim([0 180]);

% Plot 5: a_theta vs theta
subplot(2,3,5);
plot(theta_deg, a_theta, 'r-', 'LineWidth', 2);
xlabel('\theta (degrees)');
ylabel('a_\theta (m/s^2)');
title('Transverse Acceleration vs Angular Position');
grid on;
xlim([0 180]);

% Plot 6: a vs theta
subplot(2,3,6);
plot(theta_deg, a, 'g-', 'LineWidth', 2);
xlabel('\theta (degrees)');
ylabel('a (m/s^2)');
title('Total Acceleration vs Angular Position');
grid on;
xlim([0 180]);

sgtitle('Satellite Motion Analysis in Polar Coordinates', 'FontSize', 14, 'FontWeight', 'bold');
