clear all, close all, clc

% Atibuindo valores das constantes
Ka = 2;
Kb = 4;
Ki = 8;
Kr = 12;

%Tm =

Jm = 5;
Jg = 10;
Jl = 15;

%Vb = 
%theta_m = 

Bm = 10;
Bl = 20;
Ra = 50; 
La = 0.2;

n1 = 5;
n2 = 10;
n3 = 4;
n4 = 8;

% Equacionamento
n = (n1*n3)/(n2*n4);

Jeq = Jm + Jg + n^2*Jl
Beq = Bm + n^2*Bl

% Funcao transferencia
a = Kr*Ka*Ki*n;
b = La*Jeq;
c = La*Beq + 2*Ra*Jeq;
d = 2*Ra*Beq + Ki*Kb;
e = Kr*Ka*Ki;

f = n*Ki;
g = La*Jeq;
h = La*Beq + 2*Ra*Jeq;
i = 2*Ra*Beq;
j = Ki*Kb;

num=[a]
d1=[b c d e]
G1=tf(num,d1)

num2=[f]
d2=[g h i j]
G2 = tf(num2,d2)

%printando graficos de resposta temporal e em frequencia
figure
subplot(2,1,1);
step(G1)
subplot(2,1,2);
margin(G1)
figure
subplot(2,1,1);
step(G2)
subplot(2,1,2);
margin(G2)
