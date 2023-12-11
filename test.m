filename='mcl'; %ファイル名（拡張子なし）
open(filename);      %Simulinkファイルを開く
sim(filename);       %Simulinkを実行
%Simulinkの実行結果を描く
out.simout.Data(1)
