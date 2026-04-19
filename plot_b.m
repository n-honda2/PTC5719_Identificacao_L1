% 1. Extração dos dados
t = out.dados_b.time;
y_limpo= out.dados_b.signals(1).values; 
y_ruido= out.dados_b.signals(2).values;

% 2. Criação da figura (Comece limpando a figura atual)
fig = figure('Name', 'Exercicio b');
clf(fig); % Limpa qualquer resquício de tema anterior

% 3. Plotagem dos sinais
% Aumentamos o 'LineWidth' da referência para 3.5 ou 4.0
% Usamos amarelo ('y') ou laranja para o sinal limpo, como no exemplo 
plot(t, y_limpo, 'r-', 'LineWidth', 3.5); 
hold on;

% O ruído deve ser mais fino (0.5 a 1.0) para não "esconder" a referência
plot(t, y_ruido, 'y-', 'LineWidth', 0.6);

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
title('Saída Contínua com Ruído Gaussiano (\sigma^2 = 10^{-6})', 'FontSize', 14, 'Color', 'b');
% Cria a legenda e guarda a referência na variável 'lgd'
lgd = legend('Sinal limpo', 'Sinal com ruído', 'Location', 'SouthEast');

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