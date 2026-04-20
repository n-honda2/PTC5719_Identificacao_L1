% 1. Extração dos dados
t = out.dados_e_alta.time;
y_limpo = out.dados_e_alta.signals(1).values; 
y_e_alta = out.dados_e_alta.signals(2).values; 
y_e_baixa = out.dados_e_baixa.signals(2).values; 

% 2. Configuração da Figura (Ajustando a proporção)
fig_e = figure('Name', 'Exercicio 1.e');
set(fig_e, 'Color', 'w');
% Define a posição e tamanho: [esquerda, baixo, largura, altura]
% Aumentamos a largura para o gráfico não parecer "esmagado"
set(fig_e, 'Position', [100, 100, 950, 650]); 

% --- SUBPLOT ALTA INTENSIDADE ---
subplot(2,1,1);
plot(t, y_limpo, 'Color', [1, 0.8, 0], 'LineWidth', 3.5); hold on;
plot(t, y_e_alta, 'r', 'LineWidth', 0.5);
% Usando o interpretador padrão 'tex' para evitar erros de SceneNode
title('Saída y(t) com v_1, v_2 e Ruído - Intensidade Alta (\lambda^2 = 0,1)');
ylabel('Magnitude'); 
grid on; box on;
legend('Ideal', 'Sinal Ruidoso', 'Location', 'SouthEast');
ylim([-0.3 0.45]); % Margem extra para o ruído não cortar

% --- SUBPLOT BAIXA INTENSIDADE ---
subplot(2,1,2);
plot(t, y_limpo, 'Color', [1, 0.8, 0], 'LineWidth', 3.5); hold on;
plot(t, y_e_baixa, 'b', 'LineWidth', 0.5);
title('Saída y(t) com v_1, v_2 e Ruído - Intensidade Baixa (\lambda^2 = 0,001)');
xlabel('Tempo (s)'); ylabel('Magnitude'); 
grid on; box on;
legend('Ideal', 'Sinal Ruidoso', 'Location', 'SouthEast');
ylim([-0.05 0.45]);

% 3. Exportação com resolução alta
% exportgraphics(fig_e, 'imgs/resultado_ex1e_v2.png', 'Resolution', 300);