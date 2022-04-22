%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;
clc;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 1 - sinais a serem analisados 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% sinal de base g(t)

 To = 8;                  % período 
 %gp = @(t) 2+(t-2)-(2+(t-6));           
 %gn = @(t) 2-(t-2)-(2-(t-6)); 
 gp = @(t) t;           
 gn = @(t) 4-t;
 gp2 = @(t) t-8;

 ti = 0;                 % t inicial
 tmeio1 = 2;
 tmeio2 = 6;
 tf = +8;                 % t final
  
%%% Valores calculados para o primeio pulso

 fo = inv(To);            % frequência em Hz
 wo = 2*pi*fo;            % frequência angular
 N  = 1000;               % Número de harmônicas da análise ----> aproximação para 1000 termos
 n  =[-N:1:N];            % índice de cada harmônica
 f  = n*fo;               % vetor de frequências da análise de Fourier

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 M = 1000;
 Ts = To/M;
 tempo1 = [0:Ts:To];  % Tempo de simulação de um período do sinal g(t)
 %alteração tempo1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 - Fourier 
%%% sinal de base g(t) 
%% Determinando o termo Dn simbolicamente
% n simbólico

syms n t

%Notas
%gp = @(t) 2+t;           
%gn = @(t) 2-t; 
% ti = 0;                 % t inicial
% tmeio1 = 2;
% tmeio2 = 6;
% tf = +8;                 % t final
  

Dn1 = inv(To)*int(gp*exp(-j*n*wo*t),t,ti,tmeio1) + inv(To)*int(gn*exp(-j*n*wo*t),t,tmeio1,tmeio2)+inv(To)*int(gp2*exp(-j*n*wo*t),t,tmeio2,tf);
D1_o = inv(To)*int(gp,t,ti,tmeio1) + inv(To)*int(gn,t,tmeio1,tmeio2) + inv(To)*int(gp2,t,tmeio2,tf);

%% Determinando o termo Dn numericamente

n=[-N:1:N];
 
Dn1 = eval(Dn1);
D1_o = eval(D1_o);     % Corrigindo o valor médio (NaN devido a indeterminação)
Dn1(N+1) = D1_o ;      % Subistituindo no vetor de respostas

%%questão 1 Exibir o Dn ex 1

display("2-3)Dn da função ∆(t-2)-∆(t-6) intervalo de -2,2")

display(Dn1(N-1:N +3))


display("2-3) Dn da função g(t) = ∆(t − 2) − ∆(t − 6) intervalo -3,3 em modulo")

display(abs(Dn1(N-2:N +4)))

%% Visualizando o espector de Amplitude
 
figure(2) 

subplot(2,1,2);plot(f,abs(Dn1),'ko');
title('Serie de Fourier do sinal g(t) -- To = 100s');
xlabel('Frequencia em Hz');
ylabel('Amplitude em  volts')
hold


%% Sintetizando o sinal

n=[-N:1:N];

aux  = 0;              

for k = 0 : 2*N     
  
  aux = aux + Dn1(k+1)*exp(j*n(k+1)*wo*tempo1);
  
end

gs = aux;

subplot(2,1,1);plot(tempo1,gs,'linewidth',3); 
title('Serie de Fourier do sinal g(t) To = 100s');
xlabel('Tempo em segundos');
ylabel('Amplitude em  volts');




%% Letra D ex 2

%Notas
%gp = @(t) t;           
% gn = @(t) 4-t;
% gp2 = @(t) t-8;
% ti = 0;                 % t inicial
% tmeio1 = 2;
% tmeio2 = 6;
% tf = +8;                 % t final
  

P1 = @(z, ti, tf) 1/To * int(abs(z)^2, t, ti, tf);
pt1 = eval(P1(t, 0, 2))+eval(P1(4-t, 2 , 6))+eval(P1(t-8, 6 , 8)); % potência do sinal
Pg1 = 0.95*pt1; % 95% da potência do sinal

                                            %Pg1 = Pg1*0.95;   %95%
Pg1 = Pg1 -D1_o;   % retira a cte
Np = N+1;         %termo N
somador1 = 0;
%%
while (abs(somador1) <= Pg1)
    Np = Np+1;
    somador1 = somador1 + 2*(Dn1(Np)^2);

end

display("1-4) A banda é de Hz")

display((Np-1-N)*fo)
display(Np-N-1)
