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

% Item (a)
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Item (b) 
% Fazer mapa de estado (ia, theta_m, theta_m')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Item (c) 
% substituir valores no mapa de estado

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Item (d) 
%Resposta temporal
figure
step(G1)
title('Resposta no tempo - G1')

figure
step(G2)
title('Resposta no tempo - G2')

% Criterio de estabilidade e desempenho - Tempo (G1)
zpk(G1)
pzmap(G1);
title('Polos e zeros de G1'); % todos polos negativos = Estavel 

% Cálculo do tempo de pico (Tp) para G1
step_info_G1 = stepinfo(G1)  % Obtém informações da resposta ao degrau para G1

Tp_G1 = step_info_G1.PeakTime;  % Obtém o tempo de pico de G1

fprintf('Tempo de pico para G1: %.4f segundos\n', Tp_G1);

% Erro estacionario
erro = 1 - 0.1  % 0.1 = valor quanto tempo tende ao infinito


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Item (e) 
%Resposta em frequencia
figure
margin(G1)
title('Diagrama de Bode - G1')

figure
margin(G2)
title('Diagrama de Bode - G2')

% Criterio de estabilidade e desempenho - Frequência (G1)

% Nyquist
zpk(G1)
figure
nyquist(G1) % nao tem voltas em torno de -1 e o ponto vermelho na esta dentro do deseho, logo 0 + 0 = 0 -> Estavel
title('Análise de estabilidade - Critério de Nyquist')

%Análise de Root Locus

figure
title('Análise de estabilidade - Lugar das Raízes')
rlocus(G1)
sisotool(G1)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Item (f) 

%%%% Método Ziegler–Nichols %%%%%
s=tf('s');
P=feedback(G1,1) % Malha fechada

step(P),grid % comportamento temporal malha fechada

%Para calcular os valores de Kp,Kd e Ki devo usar Km e Wm do diagrama de bode 
[Km,Pm,Wm,Wcp] = margin(P) 

kp=0.6*Km
kd=kp*pi/4/Wm
ki=kp*Wm/pi

K=kd*s+kp+ki/s;

pid(K)

LA=K*P;

T=feedback(LA,1); %sistema realimentado de control com PID
damp(T)
% Para mostrar as dois respostas coloco 10 vezes T
figure, step(10*T,10), grid
hold on 
step(P,10),grid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Salvar todas as figuras em arquivos PNG
for i = 1:3
    % Seleciona a figura pelo número
    fig = figure(i);
    
    % Gera o nome do arquivo usando o número da figura
    nome_arquivo = sprintf('Figura_%d.png', i);
    
    % Salva a figura com o nome de arquivo gerado
    saveas(fig, nome_arquivo);
end

disp('Figuras salvas com sucesso!');