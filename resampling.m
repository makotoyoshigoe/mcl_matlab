weight_sum = cumsum(particles(:, 4));
if weight_sum(end) < 1e-100
    weight_sum = weight_sum + 1e-100;
end
step = weight_sum(end) / length(particles);
randam_num = step*rand;
new_particles = zeros(length(particles), 4);
chose_num = 0;
current_pos = 1;
while chose_num < length(particles)
    if randam_num < weight_sum(current_pos)
        chose_num = chose_num + 1;
        for i=1:3
            new_particles(chose_num, i) = particles(current_pos, i);
        end
        randam_num = randam_num + step;
    else
        current_pos = current_pos + 1;
    end
end
for i=1:length(particles)
    particles(i, :) = new_particles(i, :);
    particles(i, 4) = 1 / length(particles);
end

clear weight_sum step randam_num new_particles chose_num current_pos
