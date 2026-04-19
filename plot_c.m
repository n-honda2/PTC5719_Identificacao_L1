% 1. Configuração da Figura
fig_c = figure('Name', 'Exercicio c - Perturbações');
set(fig_c, 'Color', 'w');

% --- INTENSIDADE ALTA ---
subplot(2,1,1);
t_alta = out.dados_c_alta.time;
v_dir_alta = out.dados_c_alta.signals(1).values;
v1_alta = out.dados_c_alta.signals(2).values;
v2_alta = out.dados_c_alta.signals(3).values;

stairs(t_alta, v_dir_alta, 'k', 'LineWidth', 0.5); hold on;
plot(t_alta, v1_alta, 'b', 'LineWidth', 1.2);
plot(t_alta, v2_alta, 'r', 'LineWidth', 1.2);
title('Perturbações - Intensidade Alta (\lambda^2 = 0,1)');
legend('V direta', 'v_1 (1ª ordem)', 'v_2 (2ª ordem)');
grid on; ylabel('Magnitude');

% --- INTENSIDADE BAIXA ---
subplot(2,1,2);
t_baixa = out.dados_c_baixa.time;
v_dir_baixa = out.dados_c_baixa.signals(1).values;
v1_baixa = out.dados_c_baixa.signals(2).values;
v2_baixa = out.dados_c_baixa.signals(3).values;

stairs(t_baixa, v_dir_baixa, 'k', 'LineWidth', 0.5); hold on;
plot(t_baixa, v1_baixa, 'b', 'LineWidth', 1.2);
plot(t_baixa, v2_baixa, 'r', 'LineWidth', 1.2);
title('Perturbações - Intensidade Baixa (\lambda^2 = 0,001)');
xlabel('Tempo (s)'); ylabel('Magnitude');
grid on;

% Exportação a prova de falhas
exportgraphics(fig_c, 'resultado_ex1c.png', 'BackgroundColor', 'white');