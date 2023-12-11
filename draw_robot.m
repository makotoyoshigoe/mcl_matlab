% ロボットの描画
x = r*sin(linsp)+pose(1);
y = r*cos(linsp)+pose(2);
figure(1);
plot(x, y, 'Color', 'blue');
hold on
line([pose(1) pose(1)+r*cos(pose(3))], ...
     [pose(2) pose(2)+r*sin(pose(3))], ...
     'Color', 'blue')
% 時間の記述
txt = ['time = ' num2str(sum_time) ' [s]'];
text(5.1,5,txt)
% ランドマークの描画
for i=1:length(landmark_pos)
    plot(landmark_pos(i,1), landmark_pos(i,2), ...
        "pentagram", 'MarkerSize', 10);
    txt = ['id' num2str(i)];
    text(landmark_pos(i,1), landmark_pos(i,2)-0.1,txt)
end
% 観測結果の描画
s = size(observed);
if s ~= 0
    for i=1:s(1)
        x_l = observed(i, 1)*cos(observed(i, 2)+pose(3));
        y_l = observed(i, 1)*sin(observed(i, 2)+pose(3));
        plot([pose(1) pose(1)+x_l], [pose(2) pose(2)+y_l], 'Color', 'red')
    end
end
% パーティクルの描画
for i=1:length(particles)
    x_l = particles(i, 1) + particles(i, 4)*cos(particles(i, 3))*length(particles);
    y_l = particles(i, 2) + particles(i, 4)*sin(particles(i, 3))*length(particles);
    plot([particles(i, 1) x_l], [particles(i, 2) y_l], 'Color', 'green')
end
% scatter(particles(:, 1), particles(:, 2), 10, [0 particles(:, 4) 0], 'filled') % 描画
axis equal;
axis([-10,10,-6,10])
xlabel('X [m]');
ylabel('Y [m]');
hold off
grid on;
% ----
clear x y x_l y_l txt i s