clear
close all
clc
initialization %初期化
now_time = datetime("now");
pre_time = datetime("now");
sum_time = 0.0;
while sum_time < sim_time
    now_time = datetime("now"); %現在時刻
    sampling_time = now_time.Second - pre_time.Second;
    pre_time = now_time;
    if sampling_time < 0
        now_time = datetime("now"); %現在時刻
        sampling_time = now_time.Second - pre_time.Second;
    end
    sum_time = sum_time+sampling_time;
    agent %速度指令値→ロボットの位置
    motion_update % 移動によるパーティクルの更新
    observe_landmark %ランドマークの観測
    sensor_update % 観測によるパーティクルの更新
    resampling % 系統サンプリング
    draw_robot % ロボットの描画
end