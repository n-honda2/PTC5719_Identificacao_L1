%% Script Mestre: Validação Final (Itens G, H, I e J)
clear; clc; close all; init;

% --- Parâmetros de Configuração ---
dt = 0.01;      % Passo de integração do Simulink
u_amp = 0.1;    % Amplitude do degrau de teste

%% 1. Execução das Simulações
% Nota: Certifique-se de que os arquivos .slx estão na mesma pasta
disp('Rodando Simulações...');
try
    out_g = sim('modelo_g', 'StopTime', '90');   % Simulação Pulso
    out_i = sim('modelo_i', 'StopTime', '1000'); % Simulação Correlação
    out_e = sim('modelo_e', 'StopTime', '60');   % Simulação Real (Degrau)
catch ME
    error('Erro ao rodar o Simulink. Verifique se os nomes dos modelos estão corretos.');
end

%% 2. Extração de Dados Reais (Item E)
t_real = out_e.dados_e_alta.time;
y_real_limpo = out_e.dados_e_alta.signals(1).values;
y_real_alta  = out_e.dados_e_alta.signals(2).values;
y_real_baixa = out_e.dados_e_baixa.signals(2).values;

%% 3. Processamento via Correlação (Item I)
disp('Calculando Funções-Peso via Correlação...');
u_noise = out_i.dados_i_alta.signals(1).values; 
y_i_limpo = out_i.dados_i_alta.signals(2).values;
y_i_alta  = out_i.dados_i_alta.signals(3).values;
y_i_baixa = out_i.dados_i_baixa.signals(3).values;

max_lag = 100/dt;
[Ryu_l, lags] = xcorr(y_i_limpo, u_noise, max_lag, 'biased');
[Ryu_a, ~]    = xcorr(y_i_alta,  u_noise, max_lag, 'biased');
[Ryu_b, ~]    = xcorr(y_i_baixa, u_noise, max_lag, 'biased');

% Geração das g(k) normalizadas
g_c_limpa = Ryu_l(lags >= 0) / var(u_noise);
g_c_alta  = Ryu_a(lags >= 0) / var(u_noise);
g_c_baixa = Ryu_b(lags >= 0) / var(u_noise);

%% 4. Convoluções para Predição (Item J)
disp('Calculando Predições via Convolução...');
t_conv = (0:dt:80)';
u_step = u_amp * ones(size(t_conv));

% Predições (Multiplicando por dt para escala correta de 0.3)
y_j_limpa_pred = conv(g_c_limpa, u_step) * dt;
y_j_alta_pred  = conv(g_c_alta,  u_step) * dt;
y_j_baixa_pred = conv(g_c_baixa, u_step) * dt;

%% 5. Plotagem dos Gráficos (Comparação Real vs Predito)
figure('Name', 'Item J - Resultado Final', 'Color', 'w', 'Position', [100 100 900 700]);

% --- Subplot Superior: Alta Intensidade ---
subplot(2,1,1);
plot(t_real, y_real_limpo, 'b', 'LineWidth', 2); hold on;
plot(t_real, y_real_alta, 'r--', 'LineWidth', 1);
plot(t_conv, y_j_limpa_pred(1:length(t_conv)), 'c:', 'LineWidth', 1.5);
plot(t_conv, y_j_alta_pred(1:length(t_conv)), 'm-.', 'LineWidth', 1.5);
title('Item J: Degrau real vs. predito (Alta Intensidade \lambda^2=0,1)');
legend('Limpo real', 'Alta real', 'Limpo predito', 'Alta predito', 'Location', 'SouthEast');
grid on; ylabel('y[k]'); xlim([0 60]); ylim([-0.1 0.4]);

% --- Subplot Inferior: Baixa Intensidade ---
subplot(2,1,2);
plot(t_real, y_real_limpo, 'b', 'LineWidth', 2); hold on;
plot(t_real, y_real_baixa, 'r--', 'LineWidth', 1);
plot(t_conv, y_j_limpa_pred(1:length(t_conv)), 'c:', 'LineWidth', 1.5);
plot(t_conv, y_j_baixa_pred(1:length(t_conv)), 'm-.', 'LineWidth', 1.5);
title('Item J: Degrau real vs. predito (Baixa Intensidade \lambda^2=0,001)');
legend('Limpo real', 'Baixa real', 'Limpo predito', 'Baixa predito', 'Location', 'SouthEast');
grid on; xlabel('Tempo (s)'); ylabel('y[k]'); xlim([0 60]); ylim([-0.05 0.35]);

disp('Sucesso! O gráfico do item J foi gerado com todas as curvas.');