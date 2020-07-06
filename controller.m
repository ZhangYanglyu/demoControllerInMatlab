clear;
clc;
close all;

zInit = [1; 0];             % 二阶系统的初值
Ts = 0.001;                 % 采样时间 0.001 s
totalTime = 10;             % 仿真总时间：5 s
num = ceil(totalTime/Ts);   % 总的仿真步长

stateConstant = 2;          % 系统的状态
z = zeros(stateConstant, num);
z(:,1) = zInit;
u = 0;                      % 系统的控制输入

% 控制器的参数
lamda1 = 2;
lamda2 = 2;

% 4阶龙格-库塔算法实现
k = zeros(stateConstant, 4);
for i = 1:num - 1
    % 系统的控制律
    u = - lamda1*z(1,i) - lamda2*z(2,i);
    
    % 系统响应
    k(:,1) = plant(u, z(:,i));
    k(:,2) = plant(u + Ts/2, z(:,i) + Ts*k(:,1)/2);
    k(:,3) = plant(u + Ts/2, z(:,i) + Ts*k(:,2)/2);
    k(:,4) = plant(u + Ts, z(:,i) + Ts*k(:,3));    
    z(:,i+1) = z(:,i) + Ts*(k(:,1) + k(:,2)*2 + k(:,3)*2 + k(:,4))/6; 
end

plot(z(1,:));
hold on;
plot(z(2,:));
grid on
