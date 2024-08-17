% Define parameters
T = 1; % duration in seconds
fs = 200; % sampling frequency in Hz
N = T * fs; % number of samples
t = linspace(0, T, N); % time vector
x_ref = 10 * (10*t.^3 - 15*t.^4 + 6*t.^5); % minimum jerk trajectory
b0 = 0.05 * 10; % initial slot height
b1 = 0.025 * 10; % final slot height
K = 100; % position gain for SIC
B = 1; % velocity gain for SIC

% Calculate top and bottom edge trajectories of the slot
b = linspace(b0, b1, N); % slot height decreases linearly
t_edge = x_ref + b/2; % top edge of the slot
b_edge = x_ref - b/2; % bottom edge of the slot

% Add noise to the reference trajectory
x_actual_noise = x_ref + randn(size(x_ref));
x_actual_no_noise = x_ref;

% Plot the slot and trajectories with noise
figure;
plot(t, t_edge, 'r', t, b_edge, 'r', t, x_ref, 'b', t, x_actual_noise, 'g');
legend('Top edge', 'Bottom edge', 'Reference trajectory', 'Actual trajectory with noise', 'Location','northwest');
xlabel('Time (s)');
ylabel('Position (cm)');
title('Slot Trajectory with Noise')

% Plot the slot and trajectories without noise
figure;
plot(t, t_edge, 'r', t, b_edge, 'r', t, x_ref, 'b', t, x_actual_no_noise, 'k');
legend('Top edge', 'Bottom edge', 'Reference trajectory', 'Actual trajectory without noise', 'Location','northwest');
xlabel('Time (s)');
ylabel('Position (cm)');
title('Slot Trajectory without Noise')

% Calculate the commanded force trajectory with noise
F_noise = zeros(size(t));
for i = 2:N
    if x_actual_noise(i) > t_edge(i) || x_actual_noise(i) < b_edge(i) % outside the slot
        F_noise(i) = K * (x_ref(i) - x_actual_noise(i)) + B * (x_ref(i) - x_ref(i-1) - (x_actual_noise(i) - x_actual_noise(i-1)));
    else % inside the slot
        F_noise(i) = B * (x_ref(i) - x_ref(i-1) - (x_actual_noise(i) - x_actual_noise(i-1)));
    end
end

% Calculate the commanded force trajectory without noise
F_no_noise = zeros(size(t));
for i = 2:N
    if x_actual_no_noise(i) > t_edge(i) || x_actual_no_noise(i) < b_edge(i) % outside the slot
        F_no_noise(i) = K * (x_ref(i) - x_actual_no_noise(i)) + B * (x_ref(i) - x_ref(i-1) - (x_actual_no_noise(i) - x_actual_no_noise(i-1)));
    else % inside the slot
        F_no_noise(i) = B * (x_ref(i) - x_ref(i-1) - (x_actual_no_noise(i) - x_actual_no_noise(i-1)));
    end
end

% Plot the commanded force trajectory with noise
figure;
plot(t, F_noise);
xlabel('Time (s)');
ylabel('Commanded force (N)');
title('Commanded Force trajectory based on Control Law')
