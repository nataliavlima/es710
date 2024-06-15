clear all, close all, clc

% Atibuindo valores das constantes
Ka = 20;
Kb = 0.5;
Ki = 0.5;
Kr = 0.318;

%Tm =

Jm = 0.02;
Jg = 1;
Jl = 1.5;

%Vb = 
%theta_m = 

Bm = 0.01;
Bl = 1;
Ra = 8; 
La = 0.002;

n1 = 1;
n2 = 10;
n3 = 1;
n4 = 1;

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
subplot(2,1,1);
step(G2)
subplot(2,1,2);
margin(G2)
