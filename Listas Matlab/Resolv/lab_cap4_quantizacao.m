echo on;
% Processamento digital de imagens
% Lista 5: Image Quantization

%%
%                              I. Quantização
%
% 1. Mostrar cada umas das imagens Zelda_S, Barb_S e Lena256 usando de
% 8bits/pixel a 1bit/pixel. Usar imshow(X). O você que observa? Porque?
% Para 1 bit, usar antes de visualizar a função im2bw.

zelda_s = imread("images\zelda_s.tif");
barb_s = imread("images\barb_s.tif");
lena256 = imread("images\lena256.tif");

bits = [8, 7, 6, 5, 4, 3, 2, 1];
num_plots = 4;
images_per_plot = length(bits) / num_plots;

for p=1:num_plots
    figure;
    for i=1:images_per_plot
        idx = (p-1)*images_per_plot + i;
        q = bits(idx);

        if q == 8
            zelda_q = zelda_s;
            barb_q = barb_s;
            lena256_q = lena256;
        else
            zelda_q = uint8(floor(double(zelda_s) / (256/2^q)) * (256/2^q));
            barb_q = uint8(floor(double(barb_s) / (256/2^q)) * (256/2^q));
            lena256_q = uint8(floor(double(lena256) / (256/2^q)) * (256/2^q));
        end

        if q == 1
            zelda_q = im2bw(zelda_q);
            barb_q = im2bw(barb_q);
            lena_q = im2bw(lena256_q);
        end

        % Mostrar imágenes en una figura
        subplot(images_per_plot, 3, (i-1)*3 + 1);
        imshow(zelda_q);
        title(['Zelda\_S - ', num2str(q), ' bits/pixel']);

        subplot(images_per_plot, 3, (i-1)*3 + 2);
        imshow(barb_q);
        title(['Barb\_S - ', num2str(q), ' bits/pixel']);

        subplot(images_per_plot, 3, (i-1)*3 + 3);
        imshow(lena256_q);
        title(['Lena256 - ', num2str(q), ' bits/pixel']);
    end
end


%%
% 2. Quantize a imagem LENA256 com 16 níveis de cinza, seguindo o seguinte 
% procedimento: X = fix(16*X)/16
%
lena256 = imread("images\lena256.tif");
X = double(lena256) / 255;
X = fix(16*X)/16;
X = uint8(X*255);
%   a) Mostre a imagem com 256 níveis de cinza.
figure;
imshow(X);

%%

%   b) Plote o gráfico de entrada × saída do quantizador, bem como o 
%      gráfico do erro de quantização × entrada.
% Gráfico de entrada × saída do quantizador
figure;
plot(X(:), lena256(:), '.');
xlabel('Valor de entrada');
ylabel('Valor de saída (quantizado)');
title('Gráfico de Entrada × Saída do Quantizador');

% Gráfico de erro de quantização × entrada
erro_quantizacao = double(lena256) - double(X);
figure;
plot(lena256(:), erro_quantizacao(:), '.');
xlabel('Valor de entrada');
ylabel('Erro de quantização');
title('Erro de Quantização × Entrada');

%%
%   c) Calcule o erro médio quadrático entre a imagem original e a
%      quantizada em 2.
% Calcular o erro médio quadrático (MSE)
erro = double(lena256) - double(X);
MSE = mean(erro(:).^2);

fprintf('Erro Médio Quadrático (MSE) entre a imagem original e a quantizada: %f\n', MSE);


%%
% 3. Quantize a imagem LENA256 com um outro quantizador cujos níveis de 
% reconstrução são obtidos somado-se metade do passo de quantização (1/32) 
% aos níveis de reconstrução do quantizador usado em 2.
%
%   a) Mostre a imagem quantizada com 256 níveis de cinza.
lena256 = imread("images\lena256.tif");
X = double(lena256) / 255;

% Quantização do passo 2
X_quantized = fix(16 * X) / 16;

% Novo quantizador somando 1/32 ao valor quantizado anterior
X_quantized_adjusted = X_quantized + (1 / 32);

% Ajuste para manter os valores dentro do intervalo [0, 1]
X_quantized_adjusted = min(max(X_quantized_adjusted, 0), 1);

% Converter de volta para 256 níveis de cinza
X_quantized_adjusted_256 = uint8(X_quantized_adjusted * 255);
% Mostrar a nova imagem quantizada
figure;
imshow(X_quantized_adjusted_256);
title('Imagem quantizada com novo quantizador (256 níveis de cinza)');
%%

%   b) Plote o gráfico de entrada × saída do quantizador, bem como o gráfico 
%      do erro de quantização × entrada
% Gráfico de entrada × saída do novo quantizador
figure;
plot(X(:), X_quantized_adjusted(:), '.');
xlabel('Valor de entrada');
ylabel('Valor de saída (quantizado ajustado)');
title('Gráfico de Entrada × Saída do Novo Quantizador');

% Gráfico de erro de quantização × entrada
erro_quantizacao_novo = double(lena256) / 255 - X_quantized_adjusted;
figure;
plot(X(:), erro_quantizacao_novo(:), '.');
xlabel('Valor de entrada');
ylabel('Erro de quantização (novo)');
title('Erro de Quantização × Entrada (Novo Quantizador)');

%%
%   c) Compare os gráficos dos erros de quantização obtidos em 2 e 3. O que 
%      você observa?
% Gráfico de erro de quantização do quantizador anterior (Passo 2)
erro_quantizacao_anterior = double(lena256) / 255 - X_quantized;
figure;
plot(X(:), erro_quantizacao_anterior(:), '.', 'DisplayName', 'Quantizador Anterior');
hold on;
plot(X(:), erro_quantizacao_novo(:), '.', 'DisplayName', 'Novo Quantizador');
xlabel('Valor de entrada');
ylabel('Erro de quantização');
title('Comparação dos Erros de Quantização');
legend;
hold off;
%%
%   d) Calcule o erro médio quadrático entre a imagem original e a 
%      quantizada em 3. Compare com o obtido em 2. Explique o resultado.
% Calcular o erro médio quadrático (MSE) do novo quantizador
erro_novo = double(lena256) - double(X_quantized_adjusted_256);
MSE_novo = mean(erro_novo(:).^2);

% Calcular o MSE do quantizador anterior
erro_anterior = double(lena256) - double(X);
MSE_anterior = mean(erro_anterior(:).^2);

fprintf('Erro Médio Quadrático (MSE) - Quantizador Anterior: %f\n', MSE_anterior);
fprintf('Erro Médio Quadrático (MSE) - Novo Quantizador: %f\n', MSE_novo);

%%
%   e) Compare lado a lado as imagens obtidas em 2 e 3. Há diferença 
%      visível? Explique levando em conta os valores dos dois erros médios 
%      quadráticos obtidos
% Mostrar as imagens lado a lado
figure;
subplot(1, 2, 1);
imshow(X);
title('Imagem Quantizada (Passo 2)');
subplot(1, 2, 2);
imshow(X_quantized_adjusted_256);
title('Imagem Quantizada (Novo Quantizador)');


%%
%                       II. Quantizadores ótimos
% a) Carregue a imagem ZELDA_S.
% b) Quantize-a com 16 níveis de cinza usando o método em I3.
% c) Transforme a imagem original (sem quantização) representada pela 
% matriz X = [X1 X2 · · · XN ], onde Xj é a coluna j da matriz, em uma 
% matriz Z da seguinte forma:
%   (i) Mantenha o valor da 1a. coluna, X1;
%   (ii) Substitua cada coluna Xj , j = 2, . . . N, por Xj − Xj−1, gerando 
%        a matriz Z = [X1 X2 − X1 · · · XN − XN−1]

% d) Quantize Z com nlevels (nlevels=16) níveis usando um método semelhante 
%    ao usado em I.3, só que com quatro diferenças:
%   (i) Não quantize a 1a. coluna de Z.
%   (ii) Como Z assume valores negativos, faça a parte para entradas 
%        negativas da função de transferência a reflexão da positiva com 
%        relação à origem.
%   (iii) Se |x| > ασZ, então quantizar x com o valor quantizado de ±ασZ. 
%         σZ é o desvio padrão de Z. Faça neste caso α = 2.
%   (iv) Sendo x a entrada ao quantizador, se kxk < ασZ /nlevels, o nível 
%        de reconstrução deve ser 0, e não ±1/nlevels.
% e) Recupere, a partir da matriz Z quantizada, uma imagem quantizada 
%    (matriz X), e a mostre lado a lado com a imagem quantizada obtida em 
%    (b). Explique o observado. Sugira maneiras para resolver o problema 
%    (se necessário, observe também resultados para quantização com 8, 32 e 
%    64 níveis).
% f) Gere matrizes Y , Yq e Xq de acordo com o procedimento da figura abaixo 
%    (considere Xq(:, 1) = X(:, 1) e use o quantizador do item d, com 16 
%    níveis). Visualize a imagem Xq.

% g) Calcule os histogramas de X e Y, e plote-os lado a lado (use 
%    hist(Y(:),nbins)). Qual a diferença entre os dois?
% h) Qual a distribuição de probabilidade que melhor se aproxima da 
%    distribuição de Y , uma Gaussiana ou uma Laplaciana? Determine os seus 
%    parâmetros (o modelo deverá ter a mesma média e variância da matriz Y).
% i) Explique o observado, e como o valor de α influencia o desempenho do 
%    quantizador, ressaltando também o compromisso entre a qualidade da 
%    imagem reconstruÃŋda e a entropia de Yq.
% j) Repita todo o procedimento a partir do item d) também para nlevels 
%    igual a 32, 16, 4 e 2. Trace um gráfico com a entropia do quantizador 
%    ótimo (α ótimo para cada caso) versus o erro médio quadrático entre X 
%    e Xq obtido.
% k) Substitua o quantizador pelo quantizador ótimo de 16 níveis para a 
%    distribuição determinada em (h) (use as tabelas das pags. 104 a 111 
%    do livro texto). Recalcule Xq e a mostre juntamente com a obtida em 
%    (e). O que você observa?
% l) Plote o gráfico entrada × saída do quantizador ótimo usado em (k) 
%    juntamente com do quantizador usado em (d). Explique o resultado obtido 
%    em (k) com base neste gráfico e na densidade de probabilidade de Y .


%%                      III Quantização visual
% (i) Quantize a imagem LENA256 com 16 níveis como na seção I.3 e observe o 
%     resultado.
lena256 = imread("images\lena256.tif");
lena = im2double(lena256);  

% (i) Quantização da imagem com 16 níveis
num_niveis = 16;
quant_step = 1 / num_niveis;  % Passo de quantização
lena_quantizada = floor(lena / quant_step) * quant_step;

% Mostrar a imagem original e a quantizada
figure;
subplot(1, 2, 1);
imshow(lena, []);
title('Imagem Original');

subplot(1, 2, 2);
imshow(lena_quantizada, []);
title(['Imagem Quantizada com ', num2str(num_niveis), ' Níveis']);
%%
% (ii) Gere uma matriz com as mesmas dimensões da gerada no item anterior 
%      contendo ruído uniformemente distribuído no intervalo [−α, α]. (use 
%      a função rand). Faça α = 0.05.
alpha = 0.05;
ruido = alpha * (2 * rand(size(lena)) - 1);  

% Adicionar o ruído à imagem quantizada
lena_ruido = lena_quantizada + ruido;

figure;
imshow(lena_ruido, []);
title('Imagem Quantizada com Ruído Adicionado');
%%
% (iii) Some a matriz de ruído gerada em (ii) com a imagem LENA256 (matriz 
%       com valores entre 0 e 1), quantize-a como em (i), e depois:
lena_com_ruido = lena + ruido;  % Somar o ruído à imagem original
lena_com_ruido_quantizada = floor(lena_com_ruido / quant_step) * quant_step;
%       a) Mostre a imagem gerada juntamente com a gerada em (i) .
subplot(1, 2, 1);
imshow(lena_quantizada, []);
title('Imagem Quantizada (16 Níveis)');

subplot(1, 2, 2);
imshow(lena_com_ruido_quantizada, []);
title('Imagem com Ruído Quantizada (16 Níveis)');
%       b) Subtraia a matriz de ruído do resultado. Mostre a imagem 
%          resultante juntamente com a gerada em (i) e com a gerada em a).
%          O que você observa? Explique.

lena_restaurada = lena_com_ruido_quantizada - ruido;

% Mostrar as imagens: original quantizada, com ruído quantizada e restaurada
figure;
subplot(1, 3, 1);
imshow(lena_quantizada, []);
title('Imagem Quantizada (16 Níveis)');

subplot(1, 3, 2);
imshow(lena_com_ruido_quantizada, []);
title('Imagem com Ruído Quantizada (16 Níveis)');

subplot(1, 3, 3);
imshow(lena_restaurada, []);
title('Imagem Restaurada (Ruído Subtraído)');
%%

% (iv) Varie o valor de α em (ii) e repita o item (iii). Tente achar um 
%      valor de α ótimo.

%%
% (v) Para a imagem ZELDA (a grande, que possui tamanho 720×576) use um 
%     quantizador de dois níveis (1 bit) e α = 0.2, e repita o procedimento 
%     em (iii).a. Visualise a imagem com o monitor a várias distâncias. O 
%     que você observa? Explique.



%%
echo off;