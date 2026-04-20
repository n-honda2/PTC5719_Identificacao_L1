% plot_g.m
t = out.dados_g_alta.time;
y_limpo = out.dados_g_alta.signals(1).values;
y2_alta = out.dados_g_alta.signals(2).values;
y2_baixa = out.dados_g_baixa.signals(2).values;

figure('Name', 'Exercício g - Resposta ao Pulso');
subplot(2,1,1);
plot(t, y_limpo, 'k', 'LineWidth', 2); hold on;
plot(t, y2_alta, 'r');
title('Resposta ao Pulso (Intensidade Alta)');
legend('Função-Peso Real', 'Saída Ruidosa');

subplot(2,1,2);
plot(t, y_limpo, 'k', 'LineWidth', 2); hold on;
plot(t, y2_baixa, 'b');
title('Resposta ao Pulso (Intensidade Baixa)');
legend('Função-Peso Real', 'Saída Ruidosa');
xlabel('Tempo (s)');