%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      Conferindo parte 2 Analitica
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% 0 - Boas práticas 


clear all;
clc;
close all;

%% 1 - sinais a serem analisados 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%% sinal de base g(t)

 To = 8;                  % período 
 gp = @(w) 16/w^2*j*exp(-4*j*w)*sin(w)^3*cos(w);           
 
 ti = 0;                 % t inicial
 tf = 8;                 % t final
  
%%% Valores calculados para o primeio pulso

 fo = inv(To);            % frequência em Hz --> fo  = 0.01Hz
 wo = 2*pi*fo;            % frequência angular
 N  = 1000;               % Número de harmônicas da análise
 n  =[-N:1:N];            % índice de cada harmônica
 f  = n*fo;               % vetor de frequências da análise de Fourier

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 M = 1000;
 Ts = To/M;
 tempo = [-To:Ts:To];  % Tempo de simulação de um período do sinal g(t)
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 - Fourier 
%%% sinal de base g(t) 
%% Determinando o termo Dn simbolicamente

syms n t

Dn = gp(pi/4*n)/To;

%Pg = inv(To)*(int(g2p,t,ti,0) + int(g2n,t,0,tf));


%% Determinando o termo Dn numericamente

n=[-N:1:N];
 
Dn = eval(Dn);
D_o = 0;     % Area da onda -- valor médio
Dn(N+1) = D_o ;      % Subistituindo no vetor de respostas


%% Exibir o Dn ex 1 

display("1-3)Dn analitico da função ∆(t) intervalo de -3,3")

display(abs(Dn(N-2:N +4)))



%% Visualizando o espector de Amplitude
 
figure(1) 

subplot(2,1,2);plot(f,abs(Dn),'ko');
title('Serie de Fourier do sinal g(t) -- To = 100s');
xlabel('Frequencia em Hz');
ylabel('Amplitude em  volts')
hold


%% Sintetizando o sinal

n=[-N:1:N];

aux  = 0;              

for k = 0 : 2*N     
  
  aux = aux + Dn(k+1)*exp(j*n(k+1)*wo*tempo);
  
end

gs = aux;


subplot(2,1,1);plot(tempo,gs,'linewidth',3); 
title('Serie de Fourier do sinal g(t) To = 100s');
xlabel('Tempo em segundos');
ylabel('Amplitude em  volts');

