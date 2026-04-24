%% Comparação das Funções-Peso: Método do Pulso (g) vs. Análise de Correlação (i)

% 1. Extração dos dados do Item G (Resposta ao Pulso)
% t_g: tempo (0 a 90s), g_limpa: ideal, g_g_alta/baixa: ruidosas
out = sim("modelo_g");
t_g = out.dados_g_alta.time;
g_limpa = out.dados_g_alta.signals(1).values; 
g_g_alta = out.dados_g_alta.signals(2).values;
g_g_baixa = out.dados_g_baixa.signals(2).values;

% 2. Processamento do Item I (Análise de Correlação - 1000 pontos)
% Extração dos sinais de entrada (u) e saída (y2)
out = sim("modelo_i");
u_i_alta = out.dados_i_alta.signals(1).values;
y_i_alta = out.dados_i_alta.signals(3).values;

u_i_baixa = out.dados_i_baixa.signals(1).values;
y_i_baixa = out.dados_i_baixa.signals(3).values;

% Cálculo da Correlação Cruzada para estimar g(k)
% Limitamos a 100 lags para focar na dinâmica relevante (tau=10, theta=5)
[Ryu_alta, lags] = xcorr(y_i_alta, u_i_alta, 10000, 'biased'); % 100s considerando dt=0.01
[Ryu_baixa, ~]   = xcorr(y_i_baixa, u_i_baixa, 10000, 'biased');

% Seleção apenas de lags positivos e normalização pela variância da entrada
% Nota: g(k) = Ryu(k) / var(u) para entrada branca
indices_pos = lags >= 0;
g_i_alta = Ryu_alta(indices_pos) / var(u_i_alta);
g_i_baixa = Ryu_baixa(indices_pos) / var(u_i_baixa);
t_i = lags(indices_pos) * 0.01; % Ajuste do eixo de tempo baseado no dt=0.01

%% 3. Plotagem Comparativa
fig_comp = figure('Name', 'Comparação de Métodos de Identificação', 'Color', 'w');
set(fig_comp, 'Position', [100, 100, 1000, 700]);

% --- SUBPLOT: ALTA INTENSIDADE ---
subplot(2,1,1);
plot(t_g, g_limpa, 'Color', [1, 0.8, 0], 'LineWidth', 3); hold on;
plot(t_g, g_g_alta, 'r', 'LineWidth', 0.5);
plot(t_i, g_i_alta, 'k--', 'LineWidth', 1.5);
title('Função-Peso (Alta Intensidade: \lambda^2 = 0,1)');
legend('Ideal (Limpa)', 'Método do Pulso (g)', 'Análise de Correlação (i)', 'Location', 'NorthEast');
ylabel('g(t)'); grid on; xlim([0 80]); ylim([-0.3 0.6]);

% --- SUBPLOT: BAIXA INTENSIDADE ---
subplot(2,1,2);
plot(t_g, g_limpa, 'Color', [1, 0.8, 0], 'LineWidth', 3); hold on;
plot(t_g, g_g_baixa, 'b', 'LineWidth', 0.5);
plot(t_i, g_i_baixa, 'k--', 'LineWidth', 1.5);
title('Função-Peso (Baixa Intensidade: \lambda^2 = 0,001)');
legend('Ideal (Limpa)', 'Método do Pulso (g)', 'Análise de Correlação (i)', 'Location', 'NorthEast');
xlabel('Tempo (s)'); ylabel('g(t)'); grid on; xlim([0 80]); ylim([-0.1 0.6]);

% Exportação para o relatório
% exportgraphics(fig_comp, 'imgs/comparacao_identificacao.png', 'Resolution', 300);