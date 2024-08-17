import numpy as np
import matplotlib.pyplot as plt

# Given values
theta_0 = 5  # initial angle in degrees
theta_1 = 20  # commanded angle in degrees
T_ss = 0.35  # single support paretic stance duration in seconds
b_0 = 3  # initial slot height in degrees
b_1 = 1  # final slot height in degrees
sampling_frequency = 10000  # 10 kHz

# Step 1: Calculate commanded reference trajectory
N = int(T_ss * sampling_frequency)
i_values = np.arange(N)
theta_ref_i = theta_0 + (i_values / N) * (theta_1 - theta_0)

# Step 2: Calculate slot dynamics
t_i = theta_ref_i + b_0
b_i = theta_ref_i - b_1

# Step 3: Plot the dynamics
plt.plot(i_values, t_i, label='Top Edge')
plt.plot(i_values, b_i, label='Bottom Edge')
plt.xlabel('Sampling Instant (i)')
plt.ylabel('Angle (degrees)')
plt.legend()
plt.title('Slot Dynamics')
plt.show()

# Step 4: Check if the slot collapses as desired (visual inspection)

# Step 5: Calculate positions at 20 ms
position_at_20ms_index = int(0.02 * sampling_frequency)
position_at_20ms = t_i[position_at_20ms_index], b_i[position_at_20ms_index]
print(f'Positions at 20 ms: Top Edge = {position_at_20ms[0]} degrees, Bottom Edge = {position_at_20ms[1]} degrees')
