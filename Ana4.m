%%%%%%%%%%%%%%%%%%%%%%%%%%  Ana Helena Marcacini RA: 20.01305-0   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 0 - Boas práticas clear all;clc;close all;                                                     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 - sinais a serem analisados %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% sinal de base g(t) To = 4;                  % período  gp = @(t) 2+t;            gn = @(t) 2-t;   g2p = @(t) t^2+4-4*t ; g2n= @(t) t^2+4-4*t ; ti = -2;                 % t inicial tf = +2;                 % t final  %%% Valores calculados para o primeio pulso fo = inv(To);            % frequência em Hz --> fo  = 0.01Hz wo = 2*pi*fo;            % frequência angular N  = 1000;               % Número de harmônicas da análise n  =[-N:1:N];            % índice de cada harmônica f  = n*fo;               % vetor de frequências da análise de Fourier%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% M = 1000; Ts = To/M; tempo = [-To/10:Ts:To/10];  % Tempo de simulação de um período do sinal g(t) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2 - Fourier %%% sinal de base g(t) %% Determinando o termo Dn simbolicamentesyms n tDn = inv(To)*int(gp*exp(-j*n*wo*t),t,ti,0) + inv(To)*int(gn*exp(-j*n*wo*t),t,0,tf);D_o = inv(To)*int(gp,t,ti,0) + inv(To)*int(gn,t,0,tf);%Pg = inv(To)*(int(g2p,t,ti,0) + int(g2n,t,0,tf));%% Determinando o termo Dn numericamenten=[-N:1:N]; Dn = eval(Dn);D_o = eval(D_o);     % Corrigindo o valor médio (NaN devido a indeterminação)Dn(N+1) = D_o ;      % Subistituindo no vetor de respostas%Pg = eval(Pg)%% Exibir o Dn ex 1 display("1-3)Dn da função ∆(t) intervalo de -3,3")display(abs(Dn(N-2:N +4)))%% Visualizando o espector de Amplitude figure(1) subplot(2,1,2);plot(f,abs(Dn),'ko');title('Serie de Fourier do sinal g(t) -- To = 100s');xlabel('Frequencia em Hz');ylabel('Amplitude em  volts')hold%% Sintetizando o sinaln=[-N:1:N];aux  = 0;              for k = 0 : 2*N         aux = aux + Dn(k+1)*exp(j*n(k+1)*wo*tempo);  endgs = aux;subplot(2,1,1);plot(tempo,gs,'linewidth',3); title('Serie de Fourier do sinal g(t) To = 100s');xlabel('Tempo em segundos');ylabel('Amplitude em  volts');%% Letra D ex 1P = @(z, ti, tf) 1/To * int(abs(z)^2, t, ti, tf);pt = eval(P(t+2, -2, 0))+eval(P(-t+2, 0 , 2)); % 95% da potência do sinalPg = 0.95*(eval(P(t+2, -2, 0))+eval(P(-t+2, 0 , 2))); % 95% da potência do sinalPg = Pg -D_o;   % retira a cteNp = N+1;         %termo Nsomador = 0;while (somador <= Pg)    Np = Np+1;    somador = somador + 2*(Dn(Np))^2;enddisplay("1-4) A banda é de Hz")display((Np-1-N)*fo)%display(Np-N-1)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Parte 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 - sinais a serem analisados %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% sinal de base g(t)display("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Questão 2   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%") To = 8;                  % período  %gp = @(t) 2+(t-2)-(2+(t-6));            %gn = @(t) 2-(t-2)-(2-(t-6));  gp = @(t) t;            gn = @(t) 4-t; gp2 = @(t) t-8; ti = 0;                 % t inicial tmeio1 = 2; tmeio2 = 6; tf = +8;                 % t final  %%% Valores calculados para o primeio pulso fo = inv(To);            % frequência em Hz wo = 2*pi*fo;            % frequência angular N  = 1000;               % Número de harmônicas da análise ----> aproximação para 1000 termos n  =[-N:1:N];            % índice de cada harmônica f  = n*fo;               % vetor de frequências da análise de Fourier%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% M = 1000; Ts = To/M; tempo1 = [0:Ts:To];  % Tempo de simulação de um período do sinal g(t) %alteração tempo1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2 - Fourier %%% sinal de base g(t) %% Determinando o termo Dn simbolicamente% n simbólicosyms n t%Notas%gp = @(t) 2+t;           %gn = @(t) 2-t; % ti = 0;                 % t inicial% tmeio1 = 2;% tmeio2 = 6;% tf = +8;                 % t final  Dn1 = inv(To)*int(gp*exp(-j*n*wo*t),t,ti,tmeio1) + inv(To)*int(gn*exp(-j*n*wo*t),t,tmeio1,tmeio2)+inv(To)*int(gp2*exp(-j*n*wo*t),t,tmeio2,tf);D1_o = inv(To)*int(gp,t,ti,tmeio1) + inv(To)*int(gn,t,tmeio1,tmeio2) + inv(To)*int(gp2,t,tmeio2,tf);%% Determinando o termo Dn numericamenten=[-N:1:N]; Dn1 = eval(Dn1);D1_o = eval(D1_o);     % Corrigindo o valor médio (NaN devido a indeterminação)Dn1(N+1) = D1_o ;      % Subistituindo no vetor de respostas%%questão 1 Exibir o Dn ex 1display("2-3)Dn da função ∆(t-2)-∆(t-6) intervalo de -2,2")display(Dn1(N-1:N +3))display("2-3) Dn da função g(t) = ∆(t − 2) − ∆(t − 6) intervalo -3,3 em modulo")display(abs(Dn1(N-2:N +4)))%% Visualizando o espector de Amplitude figure(2) subplot(2,1,2);plot(f,abs(Dn1),'ko');title('Serie de Fourier do sinal g(t) -- To = 100s');xlabel('Frequencia em Hz');ylabel('Amplitude em  volts')hold%% Sintetizando o sinaln=[-N:1:N];aux  = 0;              for k = 0 : 2*N         aux = aux + Dn1(k+1)*exp(j*n(k+1)*wo*tempo1);  endgs = aux;subplot(2,1,1);plot(tempo1,gs,'linewidth',3); title('Serie de Fourier do sinal g(t) To = 100s');xlabel('Tempo em segundos');ylabel('Amplitude em  volts');%% Letra D ex 2%Notas%gp = @(t) t;           % gn = @(t) 4-t;% gp2 = @(t) t-8;% ti = 0;                 % t inicial% tmeio1 = 2;% tmeio2 = 6;% tf = +8;                 % t final  P1 = @(z, ti, tf) 1/To * int(abs(z)^2, t, ti, tf);pt1 = eval(P1(t, 0, 2))+eval(P1(4-t, 2 , 6))+eval(P1(t-8, 6 , 8)); % potência do sinalPg1 = 0.95*pt1; % 95% da potência do sinal                                            %Pg1 = Pg1*0.95;   %95%Pg1 = Pg1 -D1_o;   % retira a cteNp = N+1;         %termo Nsomador1 = 0;while (abs(somador1) <= Pg1)    Np = Np+1;    somador1 = somador1 + 2*(Dn1(Np)^2);enddisplay("2-4) A banda é de Hz")display((Np-1-N)*fo)%display(Np-N-1)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      Conferindo parte 2 Analitica%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% g_analitico = @(w) 16/w^2*j*exp(-4*j*w)*sin(w)^3*cos(w); To = 8;                  % período  M = 1000; Ts = To/M; tempo2 = [-To:Ts:To];  % Tempo de simulação de um período do sinal g(t) w = [-100:Ts:100]; syms n tDn_analitico = g_analitico(pi/4*n)/To;n=[-N:1:N]; Dn_analitico = eval(Dn_analitico);D_o = 0;     % Area da onda -- valor médioDn_analitico(N+1) = D_o ;      % Subistituindo no vetor de respostasdisplay("1-3)Dn analitico da função g(t) = ∆(t − 2) − ∆(t − 6) intervalo de -3,3 -- calculado no arquivo de texto")display(abs(Dn_analitico(N-2:N +4)))figure(3) subplot(3,1,2);plot(f,abs(Dn_analitico),'ko');title('Serie de Fourier -- Analitico');xlabel('Frequencia em Hz');ylabel('Amplitude em  volts')hold%% Sintetizando o sinaln=[-N:1:N];aux  = 0;              for k = 0 : 2*N         aux = aux + Dn_analitico(k+1)*exp(j*n(k+1)*wo*tempo2);  endgs = aux;subplot(3,1,2);plot(f,abs(Dn1),'ko');title('Serie de Fourier -- Analitico');xlabel('Frequencia em Hz');ylabel('Amplitude em  volts')hold%hold on%subplot(3,1,3);plot(w,g_analitico,'linewidth',3); %title('Analitico');%xlabel('Tempo em segundos');%ylabel('Amplitude em  volts');subplot(3,1,1);plot(tempo2,gs,'linewidth',3); title('Analitico');xlabel('Tempo em segundos');ylabel('Amplitude em  volts');%% Caderno%m = [2 6 1; 17 19 18];%sumOfElements = sum(sum(m))%lalalalala =%%     1     2     3%%sum(lalalalala)%%ans =%%     6%a%% Letra D Antigo%Soma = sum(Dn);%porcentagem = soma*0,95;%95%contador = 0;%i=0;%Np = 0;%while (contador <= porcentagem/2)%    NP +=1;%    contador += Dn(Np);%end