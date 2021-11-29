clear
wmax=0.9;%惯性权重最大值
wmin=0.4;%惯性权重最小值
n=10000; % 群体大小
A=rand(1,n); % 声音响度 (不变或者减小)
% 频率范围
Qmin=0; % 最低频率
Qmax=1; % 最高频率
d=2;% 搜索变量的维数（即频率和速度）
% 初始矩阵
Q=zeros(n,1); % 频率矩阵初始化
v=zeros(n,d); % 速度矩阵初始化，初始化意义就是产生一个初始矩阵
% x自变量范围
u=-1;
o=1;
%参数m
m=[0.72 0.72 0.576,0.3456];
% 初始化群体/解
for i=1:n
    Sol(i,1)=-1+(1+1)*rand(1,1);%x自变量范围【-1，1】
    %将随机生成的两个自变量带入函数式
    Fitness(i)=Fun(Sol(i,:));%函数值
end
% 寻找当前最优解
[fmax,I]=max(Fitness);
best=Sol(I,:);
T=100;%飞行次数
% 开始飞行
for t=1:T
    for i=1:n,
        Q(i)=Qmin+(Qmin-Qmax)*rand;%rand均匀分布的随机数
        %v(i,:)=v(i,:)+(Sol(i,:)-best)*Q(i);（原速度）
        w=(wmax-wmin)*exp(-2*(t/T)^2)+wmin;%惯性权重因子
        v(i,:)=w*v(i,:)+(Sol(i,:)-best)*A(i)*Q(i);%更改后的速度
        S(i,:)=Sol(i,:)+v(i,:);%位置移动
        %边界问题，如果下次飞行超出自变量范围外了，那么下次飞行的位置为投影在的边界上的位置
        %x轴
        if S(i,1)>o
            S(i,1)=o;
        end
        if S(i,1)<u
            S(i,1)=u;
        end
        %评估该次飞行后产生的新解
        Fnew(i)=Fun(S(i,:));
    end
    [Fmax,Z]=max(Fnew);%找出该次飞行后产生的最大值
    C(t,:)=S(Z,:);
    FFnew(t)=Fmax;
end




