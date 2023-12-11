for i=1:length(particles)
    for j=1:size(observed)
        id = observed(j, 3);
        observed_pos = observed(j, 1:2);
        land_pos = landmark_pos(id, :);
        pose_tmp = particles(i, 1:3);
        z = common.polar_position(land_pos, pose_tmp);
        distance_dev = distance_dev_rate * z(1);
        Sigma = diag([power(distance_dev, 2) power(direction_dev, 2)]);
        L = mvnpdf(z, observed_pos, Sigma);
        particles(i, 4) = particles(i, 4) * L;
    end
end

clear i j id land_pos pose_tmp z distance_dev Sigma L
