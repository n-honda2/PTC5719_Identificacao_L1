% plot_d.m
% Finalização do Exercício 1.d - PTC5719
% Gera a comparação entre o sinal ideal e os 6 cenários de ruído

%% 1. Extração dos Dados
% Dados do Modelo A (Ideal)
t_a = out_a.dados_a.time;
y_ideal = out_a.dados_a.signals(1).values;

% Dados do Modelo D - Intensidade Alta (0.1)
t_alta = out_d.dados_d_alta.time;
y_v_alta  = out_d.dados_d_alta.signals(1).values;
y_v1_alta = out_d.dados_d_alta.signals(2).values;
y_v2_alta = out_d.dados_d_alta.signals(3).values;

% Dados do Modelo D - Intensidade Baixa (0.001)
t_baixa = out_d.dados_d_baixa.time;
y_v_baixa  = out_d.dados_d_baixa.signals(1).values;
y_v1_baixa = out_d.dados_d_baixa.signals(2).values;
y_v2_baixa = out_d.dados_d_baixa.signals(3).values;

%% 2. Configuração da Figura (Padrão Relatório)
fig_d = figure('Name', 'Exercicio 1.d - Resposta com Perturbações');
set(fig_d, 'Color', 'w'); % Fundo branco

%% 3. Subplot Superior: Intensidade Alta
subplot(2,1,1);
plot(t_a, y_ideal, 'Color', [1, 0.8, 0], 'LineWidth', 4); hold on; 
plot(t_alta, y_v_alta, 'k:', 'LineWidth', 0.5);                  
plot(t_alta, y_v1_alta, 'b', 'LineWidth', 1.0);                 
plot(t_alta, y_v2_alta, 'r', 'LineWidth', 1.2);                 

% Título usando o interpretador padrão (TeX), que aceita acentos
title('Saída y(t) com Perturbações - Intensidade Alta (\lambda^2 = 0,1)');
ylabel('Magnitude');
grid on; box on;
xlim([0 60]); ylim([-0.2 0.8]);

% Legenda simplificada (o ^a faz o "primeira" de forma limpa)
lgd1 = legend('Ideal (Limpo)', 'Com v (Direto)', 'Com v_1 (1^a ordem)', ...
              'Com v_2 (2^a ordem)', 'Location', 'SouthEast');
set(lgd1, 'Color', 'w', 'TextColor', 'k');

%% 4. Subplot Inferior: Intensidade Baixa
subplot(2,1,2);
plot(t_a, y_ideal, 'Color', [1, 0.8, 0], 'LineWidth', 4); hold on;
plot(t_baixa, y_v_baixa, 'k:', 'LineWidth', 0.5);
plot(t_baixa, y_v1_baixa, 'b', 'LineWidth', 1.0);
plot(t_baixa, y_v2_baixa, 'r', 'LineWidth', 1.2);

title('Saída y(t) com Perturbações - Intensidade Baixa (\lambda^2 = 0,001)');
xlabel('Tempo (s)'); ylabel('Magnitude');
grid on; box on;
xlim([0 60]); ylim([0 0.4]);

lgd2 = legend('Ideal', 'v', 'v_1', 'v_2', 'Location', 'SouthEast');
set(lgd2, 'Color', 'w', 'TextColor', 'k');
%% 5. Exportação Final
% exportgraphics(fig_d, 'imgs/resultado_ex1d.png', 'BackgroundColor', 'white', 'Resolution', 300);
% fprintf('Gráfico do Exercício 1.d gerado com sucesso em /imgs!\n');