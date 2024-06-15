clear all, close all, clc

%%%% Método Ziegler–Nichols %%%%%
s=tf('s');

P=400/(s*(s^2+30*s+200)); %Planta 2 pólos complexos e polo em zero 

figure, margin(P), grid %Critério de estabilidade no dominio da frequência

figure, step(P,10), grid %comportamento temporal malha aberta

P=feedback(P,1) % Malha fechada

step(P),grid % comportamento temporal malha fechada



%Para calcular os valores de Kp,Kd e Ki devo usar Km e Wm do diagrama de bode 
[Km,Pm,Wm,Wcp] = margin(P) 
%k1=14.905
%P1=k1*P
% P1=feedback(P1,1)
%step(P1),grid

kp=0.6*Km
kd=kp*pi/4/Wm
ki=kp*Wm/pi

% ki=5;
% kp=4;
% kd=0.8;

K=kd*s+kp+ki/s;

pid(K)

LA=K*P;

T=feedback(LA,1); %sistema realimentado de control com PID
damp(T)
% Para mostrar as dois respostas coloco 10 vezes T
figure, step(10*T,10), grid
hold on 
step(P,10),grid

%% Método com Lugar da raizes %%%%
s=tf('s');

P=400/(s*(s^2+30*s+200)); %Planta 2 pólos complexos e polo em zero 
figure, step(P), grid
figure, rlocus(P), grid

sisotool(P)
%Para ser marginalmente estavel só levar os polos no eixo y 0 sem parte
%real com kp=15 novo sistema T=kp*P com controlador


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Determine o tempo integral (T) do PID Gc=kp+kd*s+ki/sT
%%% Planta G=1/(0.01s^2+0.11s+0.1)

T=0.16
s=zpk(0,[],1)

Gc=5+0.3*s+5/(T*s)
pid(Gc) %PID Gc=kp+kd*s+ki/sT


G=tf(1,[0.01 0.11 0.1]) %Planta
G0=feedback(G,1) % Malha fechada

%Mostra no sisotool
G1=feedback(G*Gc,1) % Malha fechada G*Gc

figure, pzmap(G1)

figure, rlocus(G0), grid

figure, rlocus(G1), grid

figure, step(G1), grid

hold all

SG=zpk([],[-7.55-7.55i,-7.55+7.55i],114)

step(SG)


%%%%%%%%%%%%%%%%%Sistema Massa-Mola%%%%%%%%%%%%%%%%%%%%%%%%%%
m=1;
%for b=1:10
b=100; %0 - 1000  b=0 sem fator de amortecimento
k=1.5
%k=0.9; % 0.9-1.1ohm  fixa k=1.5
FT=1/(s^2+b*s+k)
rlocus(FT)
p=pole(FT)
damp(FT)
%pzmap(FT)
%hold on
%end
rlocus(FT)
sisotool(FT)







