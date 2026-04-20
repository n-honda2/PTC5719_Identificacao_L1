% d_run_simulations.m

% 1. Carrega as constantes (K, tau, etc)
init; 

% 2. Roda a letra A forçando 60 segundos
% Isso resolve o erro de dimensões diferentes no plot
fprintf('Simulando modelo A (Ideal) para 60s...\n');
out_a = sim('modelo_a', 'StopTime', '60', 'ReturnWorkspaceOutputs', 'on');

% 3. Roda a letra D (já configurada para 60s no modelo, mas garantimos aqui)
fprintf('Simulando modelo D (Perturbações) para 60s...\n');
out_d = sim('modelo_d', 'StopTime', '60', 'ReturnWorkspaceOutputs', 'on');

% 4. Chama o plot
plot_d;