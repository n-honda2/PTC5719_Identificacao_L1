% script_h.m

% 1. Definir a entrada degrau (u) para a convolução
% Deve ter o mesmo tamanho e tempo da simulação do item g (90s)
t_conv = out.dados_g_alta.time;
u_degrau = 0.1 * ones(size(t_conv)); 

% 2. Extrair as funções-peso (g) do item g
g_limpa = out.dados_g_alta.signals(1).values;
g_baixa = out.dados_g_baixa.signals(2).values;
g_alta  = out.dados_g_alta.signals(2).values;

% 3. Realizar a Convolução
% Usamos 'prod' para compensar o intervalo de amostragem se necessário, 
% mas como o pulso foi unitário e T=1, a saída já é o g(k).
y_conv_limpa = conv(g_limpa, u_degrau);
y_conv_baixa = conv(g_baixa, u_degrau);
y_conv_alta  = conv(g_alta, u_degrau);

% 4. Truncar os resultados para o tamanho original de t (90s)
y_h_limpa = y_conv_limpa(1:length(t_conv));
y_h_baixa = y_conv_baixa(1:length(t_conv));
y_h_alta  = y_conv_alta(1:length(t_conv));

% 5. Plotagem de Comparação
figure('Name', 'Exercício 1.h - Resposta via Convolução');
plot(t_conv, y_h_limpa, 'k', 'LineWidth', 2); hold on;
plot(t_conv, y_h_baixa, 'b--');
plot(t_conv, y_h_alta, 'r:');
title('Resposta ao Degrau (0.1) obtida via Somatório de Convolução');
legend('Via g limpa', 'Via g baixa intensidade', 'Via g alta intensidade');
grid on; xlabel('Tempo (s)'); ylabel('y(t)');