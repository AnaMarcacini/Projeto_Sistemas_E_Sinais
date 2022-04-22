
 To = 8;                  % período 

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      Conferindo parte 2 Analitica
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 g_analitico = @(w) 16/w^2*j*exp(-4*j*w)*sin(w)^3*cos(w);
 To = 8;                  % período 
 M = 1000;
 Ts = To/M;
tempo = [-To:Ts:To];  % Tempo de simulação de um período do sinal g(t)

 syms n t

Dn_analitico = g_analitico(pi/4*n)/To;
n=[-N:1:N];
 
Dn_analitico = eval(Dn_analitico);
D_o = 0;     % Area da onda -- valor médio
Dn_analitico(N+1) = D_o ;      % Subistituindo no vetor de respostas
display("1-3)Dn analitico da função ∆(t) intervalo de -3,3")

display(abs(Dn(N-2:N +4)))

%%conferir
figure(3) 

subplot(3,1,2);plot(f,abs(Dn_analitico),'ko');
title('Serie de Fourier -- Analitico');
xlabel('Frequencia em Hz');
ylabel('Amplitude em  volts')
hold


%% Sintetizando o sinal

n=[-N:1:N];

aux  = 0;              

for k = 0 : 2*N     
  
  aux = aux + Dn_analitico(k+1)*exp(j*n(k+1)*wo*tempo);
  
end

gs = aux;


subplot(3,1,2);plot(f,abs(Dn_analitico),'ko');
title('Serie de Fourier -- Analitico');
xlabel('Frequencia em Hz');
ylabel('Amplitude em  volts')
hold



subplot(3,1,1);plot(tempo2,gs,'linewidth',3); 
title('Analitico');
xlabel('Tempo em segundos');
ylabel('Amplitude em  volts');










