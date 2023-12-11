pose = [0, -5, pi/2]; % 初期姿勢（x, y, theta）
init_pos = [pose(1), pose(2)];
cmd_vel = [0.5, 0.0]; % linear, anguler
sim_time = 20; % simulation time
linsp = linspace(0,2*pi,100);
r = 0.5;           % 半径
% ランドマークの位置
landmark_pos = [
                2, -2;
                -4, -2;
                -4, 2;
                3, 3; 
                -6, 8;
                8, 8;
                ];
% ロボットに加わる外乱用のパラメータ
distance_range = [0.5, 60]; % カメラの観測可能距離
direction_range = [-pi/3, pi/3]; % カメラの観測可能範囲
noise_per_meter = 5.0; % 1[m]あたりの石の数
distance_until_noise = exprnd(1.0/(1e-100+noise_per_meter)); 
noise_std = pi/60; % 石を踏んだことによる向きのばらつき
% 速度に対するバイアス用のパラメータ
bias_rate_stds = [0.1, 0.1]; % バイアスのばらつき
bias_rate_nu = normrnd(1.0, bias_rate_stds(1), 1); % 並進速度のバイアス
bias_rate_omega = normrnd(1.0, bias_rate_stds(2), 1); % 角速度のバイアス
% センサノイズ用のパラメータ
distance_noise_rate = 0.1; % ノイズによる距離のばらつき
direction_noise = pi / 90; % ノイズによる角度のばらつき
% センサに対するバイアス用のパラメータ
distance_bias_rate_stddev = 0.1; % バイアスによる距離のばらつき
direction_bias_stddev = 0.1; % バイアスによる角度のばらつき
% 距離のバイアス
distance_bias_rate_std = normrnd(0, distance_bias_rate_stddev, 1);
% 角度のバイアス
direction_bias = normrnd(0, direction_bias_stddev, 1);
% パーティクルフィルタ用のパラメータ
particle_num = 100; % パーティクルの数
% パーティクルの初期化（初期位置, 重み（1/パーティクル数））
particles = zeros(particle_num, 4);
for i=1:particle_num
    particles(i, :) = [pose, 1/particle_num];
end
% 移動後のパーティクル更新用のパラメータ
values = [0.19, 0.01, 0.13, 0.2]; % ばらつき
motion_Sigma = diag(power(values, 2)); % 共分散行列
% 観測によるパーティクル更新用のパラメータ
distance_dev_rate = 0.14;
direction_dev = 0.05;

clear bias_rate_stds distance_bias_rate_stddev ...
      direction_bias_stddev values particle_num
