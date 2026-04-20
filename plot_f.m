% plot_f.m
% Comparação entre o Modelo Identificado (Curva de Reação) e Processo Limpo

%% 1. Definição do Modelo Identificado (Baseado na análise visual do item f)
% Parâmetros estimados visualmente do gráfico de baixa intensidade
K_hat = 3; 
tau_hat = 10;
theta_hat = 5;

% Criação da Função de Transferência Identificada
s = tf('s');
G_ident = (K_hat / (tau_hat*s + 1)) * exp(-theta_hat*s);

%% 2. Simulação do Modelo Identificado
% Usamos o mesmo tempo e entrada do item e (Degrau de 0.1)
t_sim = 0:0.1:60;
u_degrau = 0.1 * (t_sim >= 0); % Degrau em t=0 conforme enunciado [cite: 9]
[y_ident, t_ident] = lsim(G_ident, u_degrau, t_sim);

%% 3. Extração do Processo Real (Sem perturbação)
% Pegamos os dados 'limpos' que você já salvou na estrutura do item e
t_real = out.dados_e_baixa.time;
y_real = out.dados_e_baixa.signals(1).values; 

%% 4. Gráfico de Comparação
fig_f = figure('Name', 'Exercício 1.f - Validação do Modelo');
set(fig_f, 'Color', 'w', 'Position', [100, 100, 800, 500]);

% Plotagem
plot(t_real, y_real, 'b-', 'LineWidth', 2.5); hold on;
plot(t_ident, y_ident, 'r--', 'LineWidth', 1.5);

% Formatação TeX (sem Warning de SceneNode)
title('Validação: Processo Real vs. Modelo Identificado');
xlabel('Tempo (s)');
ylabel('Magnitude');
grid on;
legend('Processo Real (Limpo)', 'Modelo Identificado (\tau=10, \theta=5)', 'Location', 'SouthEast');

% Zoom no transiente para mostrar a precisão
axes('Position',[.4 .4 .3 .3]);
plot(t_real, y_real, 'b-', t_ident, y_ident, 'r--', 'LineWidth', 1.5);
title('Detalhe do Transiente');
axis([0 20 -0.05 0.3]); grid on;

%% 5. Exportação
% exportgraphics(fig_f, 'imgs/validacao_ex1f.png', 'Resolution', 300);
% fprintf('Gráfico de validação da letra f gerado com sucesso!\n');