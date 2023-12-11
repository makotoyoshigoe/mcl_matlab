observed = zeros(0, 3);
index = 1;
for i=1:length(landmark_pos)
    z = common.polar_position(landmark_pos(i, :), pose);
    l = z(1);
    phi = z(2);
    while phi >= pi
        phi = phi - 2*pi;
    end
    while phi < -pi
        phi = phi + 2*pi;
    end
    distance_condition = distance_range(1) <= l && l <= distance_range(2);
    direction_condition = direction_range(1) <= phi && phi <= direction_range(2);
    if (distance_condition && direction_condition) ~= 0
        % バイアスの適用
        l = l + distance_bias_rate_std*l;
        phi = phi + direction_bias;
        % 雑音の適用
        l = normrnd(l, l*distance_noise_rate, 1); 
        phi = normrnd(phi, direction_noise, 1);
        % ---------
        observed(index, :) = [l, phi, i];
        index = index + 1;
    end
end
clear diff_x diff_y phi i l index distance_condition direction_condition z
