%% 资料来源
% 官方课程：https://matlabacademy.mathworks.com/cn/
% 本视频主要按照上述内容编排
% 推荐安装matlab2021，因为补全功能非常好用，安装方法见上上个视频


%% 软件界面

% 脚本(.m)
% 
% 命令行基本操作
clear;
clc;
3*5;
2*3;
a=3*5;
a=a+1;
a=a+1
A=a+1;
averageA=(a+A)/2; % 区分大小写
% 历史操作如何查找？

% 工作区
load('durer.mat') % 更多复杂的import功能会在作图的那节讲
save test.mat A
clear
load('test.mat')
filenm='test.mat';
load(filenm)
% 打开excel文件？

% 内置变量、算数函数
pi
sqrt(pi)
abs(-pi)

% 文件夹
dir()
cd .. % change dir...

%% 数值、向量、矩阵
a=1;
row=[1,2,3,4,5,6,7,8,9,10];
row=[1:0.5:10] % 指定公差，构建等距向量
row=[1:10] %构建等距为1的向量

rowr=[10:-1:1]
linspace(1,10,3); % 指定三个数值,其中最后一个是：
columns=[1;2;3;4;5;6;7;8;9;10];
rowt=row';

matrix=[11,12;13,14];
% 矩阵里边可以塞进什么？
matr=[sqrt(10),pi^2;abs(-1),sqrt(100)];
matr=[row;row]; % 向量
matr2=[matr,matr]
matrix(1,2)=NaN
% note: 矩阵与向量的关系

%某些与生成矩阵相关的函数
randperm(12)
rand(5)
randi(5,5,5)
randn(5)
rand(3,5)
zeros(3,5)
eye(5)
ones(3,5)
ones(3,5)*2
rand(size(matrix))

%矩阵的索引
clear
load('durer.mat')
size(map)
t1=map(2,2)

t2=map([1,2,3,4,5,6],2)
t2=map([1:6],2)
idx=(1:6)
t2=map(idx,2) % 都是通过向量对矩阵进行索引

t3=map(:,2)
t4=map(end,2)
t4l2=map(end-1,2)
t5=map(end,:)
t6=map(end/2,:)
t7=map(1:2:end,2)
t8=map(:)

% 逻辑索引
% 1 and 0
isnan([1,2,3,nan,5])
lo=[1,2,3,nan,5];
lo(isnan(lo))=0 % 基于逻辑索引进行赋值

% >、<、== 和 ~=
t2>0
t2(t2>0) %MATLAB 会提取索引为 true 的数组元素
t2(t2==0)=1
% & |
t2(t2>0 & t2<0.06)
t2(t2>0 | t2<0.06)


% 数值更改
map(1,1)=1;
map(1,1)=map(end,end);
map([1:3],[1:3])=map([end-2:end],[end-2:end]);
%what if...check size!!
map([1:3],[1:3])=map([end,end-1],end);
map(end+1,:)=t6; % 这之后怎么处理end？

% 矩阵运算
z1=magic(4);
z2=rand(4);
z3=z1+1
sum=z1+z2;
avarag=(sum)/2
sin(z1)
mx=max(z1)
sq=sqrt(z1)
rd=round(sq) % 四舍五入为整数
% 乘除，乘方？
mt=z1*z2; % 矩阵乘法
dot=z1.*z2 % 按元素乘法
divided=z1/2 % 除以某数值
3^2
power=z1.^2 % 按元素乘方
dotpower=z1^2 % 矩阵乘方


% 捏矩阵
reshape(z1,2,8) % 把函数按照列捏到指定大小，如果想按行捏怎么办？如何确定大小？
% 为什么要捏矩阵？

% 函数，如何使用陌生的函数？如何找到想要的函数？
% doc edit
edit why
[ans1,ans2]=size(map)
doc size % 记得本地化文档
length(map)
[ans3,ans4]=max(z1) % what if we need....
meanz1c=mean(z1) % 按照什么平均？
meanz1r=mean(z1,2) % 如何按行平均？ 还有什么办法？

corrcoef([1 2 3 4 5],[1 2 3 4 5]*2+rand(1,5))

% 下一个视频：数据结构，循环、条件语句及函数的使用
% 下下个视频：作图
