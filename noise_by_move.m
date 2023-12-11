% distance_until_noise = distance_until_noise - (abs(cmd_vel(1)*sampling_time)+r*abs(cmd_vel(2))*sampling_time);
% if distance_until_noise <=0.0
%     distance_until_noise = distance_until_noise + exprnd(1.0/(1e-100+noise_per_meter));
%     pose(3) = pose(3) + normrnd(0, noise_std, 1);
% end
