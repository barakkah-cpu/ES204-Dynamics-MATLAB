%% ES 204 Dynamics - Bycicle Dynamics
% This script computes and plots the velocity and acceleration components
% of an Earth satellite in polar coordinates.
%
%
% Information gotten fom graph:
%   Phase 1(0 to 2s): acceleration occurs from 0 to 1 m/s^2
%   Phase 2(2 to 12s): acceleration is constant at 1 m/s^2
%   Phase 3(12 to 14s): decceleration occurs from 1 to 0 m/s^2

clc
clear
close all
%% constants (converted to m)
front_radius = 0.120; %front gear radius (m)
rear_radius = 0.045; %rear gear radius (m)
wheel_radius = 0.330; %wheel radius (m)

% setting the gear ratio:
gear_ratio = front_radius/rear_radius; %from the equation: r1omega1 = r2omega2
%% Defining the paramaters for the motion sequence:
dt = 0.001; %time step (s)
t_end = 14;  % end time(s), the question requires only 14 
t = 0:dt:t_end; % time vector
n = length(t); %number of steps
%% Calculation of the angular acceleration of the front gear

%intializing arrays
alpha_1 = zeros(1, n);
omega_1 = zeros(1, n);
theta_1 = zeros(1, n);

%Now for th efirst step in calculating:

for j = 1:n
    if t(j) <= 2

        alpha_1(j) = (1/2) * t(j);

    elseif t(j) <= 12 

        %constant: 1 rad/s^2

        alpha_1(j) = 1;

    elseif t(j) <= 14

        alpha_1(j) = 1 - (1/2) * (t(j)-12);

    else 
        
        %Set after 14s: 0

        alpha_1(j) = 0;

    end

end


%% Setup integration

%Update each time step: for each time step: omega = omega+ alpa*dt, 
%theta = that*dt + omega*dt

for j = 2:n

    
    omega_1(j) = omega_1(j-1) + 0.5* (alpha_1(j)+alpha_1(j-1))*dt;
    
    theta_1(j) = theta_1(j-1) + 0.5* (omega_1(j)+omega_1(j-1))*dt;

end

%% Using the gear ratio relationship and values from the front gear, we can find the values for the second gear

omega_2 = gear_ratio * omega_1;
theta_2 = gear_ratio * theta_1;

%% find the bicyle linear motion using known relations:

v = wheel_radius * omega_2; % velocity(m/s)
s = wheel_radius * theta_2; % position(m)
a = wheel_radius * gear_ratio * alpha_1; % acceleration (m/s^2)

% find th enumber of revolutions:since the wheel is rigidly attached to the
% front gear 
 
%answers for question s3 and 4
% Question 3: How many revolutions does the cyclist pedal? 

% (Based on front gear/pedal angular displacement at 14s) 
revolutions = theta_1(end) / (2*pi); %number of revolutions
 
% Question 4: Total distance travelled? 
s_total = s(end); %total distance travelled (m)

fprintf('Total pedal revolutions: %.2f revs\n', revolutions); 

fprintf('Total distance travelled: %.2f meters\n', s_total); 

%% Plots

% Figure 1: Front gear 

figure('Position', [100, 100, 1400, 900]); 

subplot(2,3,1); 

yyaxis left; 

plot(t, omega_1, 'b-', 'LineWidth', 1.5); 

ylabel('\omega_1 (rad/s)'); 

yyaxis right; 

plot(t, theta_1, 'r-', 'LineWidth', 1.5); 

ylabel('\theta_1 (rad)'); 

xlabel('Time (s)'); title('Front Gear'); 

grid on; legend('\omega_1', '\theta_1'); 

 

% Figure 2: Rear gear 

subplot(2,3,2); 

yyaxis left; 

plot(t, omega_2, 'b-', 'LineWidth', 1.5); 

ylabel('\omega_2 (rad/s)'); 

yyaxis right; 

plot(t, theta_2, 'r-', 'LineWidth', 1.5); 

ylabel('\theta_2 (rad)'); 

xlabel('Time (s)'); title('Rear Gear'); 

grid on; legend('\omega_2', '\theta_2'); 

 

% Figure 3: Angular acceleration profile 

subplot(2,3,3); 

plot(t, alpha_1, 'g-', 'LineWidth', 1.5); 

xlabel('Time (s)'); ylabel('\alpha_1 (rad/s^2)'); 

title('Angular Acceleration of Front Gear'); 


grid on; ylim([-0.1, 1.2]); 

 

% Figure 4: Bicycle s(t), v(t), a(t) om same axis to show relationship

subplot(2,3,4); 

yyaxis left

plot(t, s, 'b-', 'LineWidth', 1.5);

ylabel('Position s(m)')

yyaxis right

plot(t, v, 'r-', 'LineWidth', 1.5); hold on

plot(t, a, 'g-', 'LineWidth', 1.5); 

ylabel('v (m/s), a (m/s^2)')

xlabel('Time (s)'); 

title('Bicycle Motion vs Time'); 

legend('s(t)', 'v(t)', 'a(t)'); grid on; 

 

% Figure 5: v(s) – velocity vs position, v and s are a function of t

subplot(2,3,5); 

plot(s, v, 'r-', 'LineWidth', 1.5); 

xlabel('Position s (m)'); ylabel('Velocity v (m/s)'); 

title('v(s) – Phase Plot'); grid on; 

 

% Figure 6: a(s) – acceleration vs position 

subplot(2,3,6); 

plot(s, a, 'g-', 'LineWidth', 1.5); 

xlabel('Position s (m)'); ylabel('Acceleration a (m/s^2)'); 

title('a(s)'); grid on; 

 

sgtitle('ES 204 Dynamics – Bicycle Gear System'); 
