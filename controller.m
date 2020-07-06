clear;
clc;
close all;

zInit = [1; 0];             % ����ϵͳ�ĳ�ֵ
Ts = 0.001;                 % ����ʱ�� 0.001 s
totalTime = 10;             % ������ʱ�䣺5 s
num = ceil(totalTime/Ts);   % �ܵķ��沽��

stateConstant = 2;          % ϵͳ��״̬
z = zeros(stateConstant, num);
z(:,1) = zInit;
u = 0;                      % ϵͳ�Ŀ�������

% �������Ĳ���
lamda1 = 2;
lamda2 = 2;

% 4������-�����㷨ʵ��
k = zeros(stateConstant, 4);
for i = 1:num - 1
    % ϵͳ�Ŀ�����
    u = - lamda1*z(1,i) - lamda2*z(2,i);
    
    % ϵͳ��Ӧ
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
