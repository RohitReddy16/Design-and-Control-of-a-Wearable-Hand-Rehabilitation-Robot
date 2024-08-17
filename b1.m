% Define parameters
Tss = 0.35; % single support paretic stance duration in seconds
T1 = 0.15 * Tss; % 15% of Tss
fs = 10e3; % sampling frequency in Hz
N = round(T1 * fs); % number of samples
t = linspace(0, T1, N); % time vector
theta_i = 5; % initial angle in degrees
theta_f = 20; % final angle in degrees
b0 = 3; % initial slot height in degrees
b11 = 1; % final slot height in degrees

% Commanded reference trajectory (straight line)
theta_ref = linspace(theta_i, theta_f, N);

% Calculate top and bottom edge trajectories of the slot
b = linspace(b0, b11, N); % slot height decreases linearly
t_edge = theta_ref + b/2; % top edge of the slot
b_edge = theta_ref - b/2; % bottom edge of the slot

% Plot the slot and reference trajectory
figure;
plot(t, t_edge, 'r', t, b_edge, 'r', t, theta_ref, 'b');
legend('Top edge', 'Bottom edge', 'Reference trajectory', 'Location','northwest');
xlabel('Time (s)');
ylabel('Angle (degrees)');
title('Slot and Reference Trajectory')

% Absolute positions of the top and bottom edges of the slot at 20 ms
i_20ms = round(20e-3 * fs); % index corresponding to 20 ms
t_edge_20ms = t_edge(i_20ms);
b_edge_20ms = b_edge(i_20ms);
fprintf('At 20 ms, the top edge is at %.2f degrees and the bottom edge is at %.2f degrees.\n', t_edge_20ms, b_edge_20ms);
