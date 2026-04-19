% 1. Extração dos dados
t = out.dados_a.time;
y_continuo = out.dados_a.signals(1).values; 
y_discreto = out.dados_a.signals(2).values;

% 2. Criação da figura (Comece limpando a figura atual)
fig = figure('Name', 'Exercicio a');
clf(fig); % Limpa qualquer resquício de tema anterior

% 3. Plotagem dos sinais (FAÇA ISSO PRIMEIRO)
% Como pede o enunciado: plot para contínuo e stairs para discreto [cite: 11, 12]
plot(t, y_continuo, 'r-', 'LineWidth', 1.5); 
hold on;
stairs(t, y_discreto, 'k--', 'LineWidth', 1.2);

% 4. Formatação do gráfico (AGORA VOCÊ MODIFICA AS CORES)
ax = gca; 

% FORÇANDO O BRANCO (O "pulo do gato")
set(fig, 'Color', 'w');           % Fundo da janela branco
set(ax, 'Color', 'w');            % Fundo do gráfico branco
set(ax, 'XColor', 'k');           % Eixo X preto
set(ax, 'YColor', 'k');           % Eixo Y preto
set(ax, 'GridColor', 'k');        % Linhas da grade pretas
set(ax, 'GridAlpha', 0.15);       % Deixa a grade sutil

% Títulos e Legendas
grid on;
box on;
xlabel('Tempo (s)', 'FontSize', 12);
ylabel('Magnitude (y)', 'FontSize', 12);
title('Comparação: Processo Contínuo vs. Modelo Discreto (T=1s)', 'FontSize', 14, 'Color', 'b');
% Cria a legenda e guarda a referência na variável 'lgd'
lgd = legend('Saída tempo contínuo', 'Saída tempo discreto', 'Location', 'SouthEast');

% Configura o fundo e o texto da legenda para o padrão de relatório
set(lgd, 'Color', 'w');       % Fundo da caixa branco
set(lgd, 'TextColor', 'k');   % Texto preto (k = black)
set(lgd, 'EdgeColor', 'k');   % Borda da caixa preta

% Ajuste dos eixos
xlim([0 20]);
ylim([-0.02 0.35]);

% 5. Comando de exportação "Anti-Dark Mode"
% Use isso para gerar o arquivo do relatório sem erro de cor
% exportgraphics(ax, 'grafico_exercicio_a.png', 'BackgroundColor', 'white', 'Resolution', 300);