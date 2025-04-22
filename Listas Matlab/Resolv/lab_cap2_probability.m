echo on;
% Processamento digital de imagens
% Lista 3: Autocorrelação, densidade espectral e potência 

%%
% 1. Visualizar as imagens ZELDA S, BUILDING, TEXT e XRAY. Todas estão no 
% formato “TIF”. Ver o documento Lendo e visualizando imagens no MATLAB.

zelda_s = imread("images\zelda_s.tif");
building = imread("images\building.tif");
text = imread("images\text.tif");
xray = imread("images\xray.tif");

% Visualização de imagens

figure;
subplot(2, 2, 1);
imshow(zelda_s);
subplot(2, 2, 2);
imshow(building);
subplot(2, 2, 3);
imshow(text);
subplot(2, 2, 4);
imshow(xray);

pause;
close(gcf);

%%

% 2. Plotar a função de autocovariância separável da eq. 2.84, pp. 36 para 
% ρ1 = ρ2 tomando os valores 0.95, 0.7, 0.5, 0.1 e -0.5, supondo que o 
% conjunto de imagens ao qual ela se refere possui dimensões é 128× 128. 
% Plotar também a sua transformada de Fourier bi-dimensional.

% Dimensões da imagem
M = 128;
N = 128;

% Valores de rho1 e rho2
rho = [0.95, 0.7, 0.5, 0.1, -0.5];

acov = zeros(M,N);
% Aqui vamos a generar una matriz de tamanho 128 x 128 de zeros, lo que
% indica que todos los valores ingresado en la matriz son bajos, esto nos
% sirve para simular una imagen con esas dimensiones para el desarrollo del
% calculo de autocovarianza separable.

sigma = 1;
echo off;
figure;
for i = 1: length(rho)
    valor_rho = rho(i);
    for m = 1: M
        for n=1:N
            acov(m,n) = sigma * valor_rho^(abs(m)) * valor_rho^(abs(n));     
        end
    end
    
    subplot(3, 2 ,i);
    colormap('jet');
    imagesc(acov);
    colorbar;
    title(["Função autocovariância separável para ρ1 = ρ2 =", num2str(valor_rho)]);
end
echo on;
% Neste caso, podemos observar nas imagens apresentadas a covariância 
% em suas sequências unidimensionais, ou seja, nas linhas verticais e 
% horizontais. Analisaremos uma imagem composta por zeros e como cada pixel 
% se relaciona em cada direção.

% Se os pixels da imagem estão altamente correlacionados, podemos 
% observar texturas mais uniformes e padrões mais regulares, indicando 
% uma estrutura repetitiva na imagem.

% Dependendo dos valores obtidos para os parâmetros de autocorrelação 
% ρ_1 e ρ_2, podemos determinar quão forte é a correlação de um pixel 
% com seus vizinhos nas direções horizontal e vertical, como visto nos 
% resultados. Isso pode ser visualizado em um colormap, onde podemos 
% diferenciar visualmente a correlação entre os pixels da imagem. 
% Um padrão mais forte indica uma alta correlação, enquanto um padrão mais 
% fraco sugere uma baixa correlação. Ou seja, os padrões visíveis na imagem 
% refletem como a covariância varia ao longo da matriz gerada.

% Para um valor de ρ_1 = ρ_2 = 0,95, isso indica uma alta correlação entre 
% os pixels da imagem. No canto superior, podemos observar um decaimento 
% lento nos valores de cor, que muda gradualmente. Como estamos lidando 
% com uma imagem de valores baixos ou uma matriz de zeros, isso sugere uma 
% alta correlação devido aos padrões repetitivos. A função de covariância 
% é estacionária, ou seja, depende apenas da distância entre os pixels, 
% mantendo propriedades estatísticas constantes.

% À medida que ρ_1 e ρ_2 diminuem, o decaimento é mais rápido, ainda 
% indicando correlação, mas com menor intensidade. No caso de 
% ρ_1 = ρ_2 = 0,5 e ρ_1 = ρ_2 = -0,5, observamos que quando ρ_1 e ρ_2 < 0, 
% forma-se uma correlação negativa, onde um pixel com valor baixo terá 
% vizinhos com valores altos. Se aplicarmos zoom, podemos observar que 
% a correlação se alterna entre os pixels, ou seja, para valores negativos, 
% os pixels terão valores opostos.​

pause;
close(gcf);
figure;
echo off;
for i = 1: length(rho)
    valor_rho = rho(i);
    for m = 1: M
        for n=1:N
            acov(m,n) = sigma * valor_rho^(abs(m)) * valor_rho^(abs(n));     
        end
    end
    % Calcular e plotar a Transformada de Fourier Bidimensional
    R_fft = fftshift(fft2(acov));
    magnitude_fft = abs(R_fft);
    subplot(3, 2 ,i);
    colormap('jet');
    imagesc(log(1 + magnitude_fft));
    colorbar;
    title(["Transformada de Fourier Bidimensional (Log Magnitude) para ρ1 = ρ2 =", num2str(valor_rho)]);
end
echo on;
% Agora, aplicando a transformada de Fourier para a autocovariância 
% separável, com diferentes valores de ρ, vamos analisar o comportamento 
% das frequências na imagem. Vamos observar a distribuição das altas e 
% baixas frequências. Inicialmente, como geramos uma imagem a partir de uma 
% matriz de zeros, a transformada de Fourier terá componentes concentrados 
% em baixas frequências. Para valores de ρ com alta correlação, como ρ = 0,95, 
% observamos uma alta concentração em baixas frequências, evidenciada por 
% duas linhas, uma vertical e outra horizontal. À medida que os valores de ρ 
% diminuem, a energia do sistema se distribui para as altas frequências da 
% transformada de Fourier. Para valores próximos de zero, aparece uma forma 
% semelhante a um "óvulo", indicando que o espectro da imagem está se 
% deslocando para frequências mais altas, o que reflete uma maior variabilidade 
% espacial devido à menor correlação.

% Quando tratamos de valores negativos, como no caso de ρ = -0,5, observamos 
% que o espectro da transformada de Fourier se desloca para frequências mais 
% altas. Isso sugere, como mencionado anteriormente sobre a correlação negativa, 
% que os padrões se alternam, onde pixels com valores baixos têm seus vizinhos 
% com valores altos.

pause;
close(gcf);

%% 
% 3. Idem para a função de autocovariância isotrópica, da eq. 2.86, pp. 36, 
% para ρ tomando os valores 0.95, 0.7, 0.5, 0.1 e -0.5.
% Dimensões da imagem
M = 128;
N = 128;


% Valores de rho
rho = [0.95, 0.7, 0.5, 0.1, -0.5];

acov = zeros(M,N);
sigma = 1;
figure;
echo off;
for i = 1: length(rho)
    valor_rho = rho(i);
    for m = 1: M
        for n=1:N
            acov(m,n) = real(sigma^2 * valor_rho.^(sqrt(m^2 + n^2)));      
        end
    end
    
    subplot(3, 2 ,i);
    colormap('jet');
    imagesc(acov);
    colorbar;
    title(["Função autocovariância separável para ρ =", num2str(valor_rho)]);
end
pause;
close(gcf);

figure;
for i = 1: length(rho)
    valor_rho = rho(i);
    for m = 1: M
        for n=1:N
            acov(m,n) = real(sigma^2 * valor_rho^(sqrt(m^2 + n^2)));     
        end
    end
    % Calcular e plotar a Transformada de Fourier Bidimensional
    R_fft = fftshift(fft2(acov));
    magnitude_fft = abs(R_fft);
    subplot(3, 2 ,i);
    colormap('jet');
    imagesc(log(1 + magnitude_fft));
    colorbar;
    title(["Transformada de Fourier Bidimensional (Log Magnitude) para ρ =", num2str(valor_rho)]);
end
echo on;
% Devido ao fato de estarmos calculando a autocovariância isotrópica da 
% matriz gerada com zeros, observamos que, neste caso, a autocovariância 
% depende apenas da distância euclidiana entre dois pontos m e n. Portanto, 
% observa-se uma covariância uniforme em todas as direções, similar ao caso 
% anterior de autocovariância separável, que dependia de dois valores de rho, 
% onde as texturas da imagem variavam de acordo com a direção.

% Visualmente, podemos notar que a autocovariância isotrópica gera texturas 
% uniformes, pois não há uma direção preferencial devido à dependência de 
% m^2 + n^2. A variação da covariância é mais uniforme em todas as direções. 
% Como a imagem gerada é uma matriz de zeros, não há variação nos valores dos 
% pixels. Para valores negativos, a função reflete essencialmente a ausência 
% de correlação significativa, resultando em uma distribuição uniforme com 
% valores próximos de zero.

% No entanto, para valores positivos, uma função de autocovariância 
% isotrópica produzirá texturas uniformes em todas as direções. Não haverá 
% uma direção preferencial, e a textura parecerá a mesma independentemente 
% da orientação. Em uma imagem, isso pode resultar em padrões circulares ou 
% texturas igualmente suaves ou ásperas em todas as direções, como pode ser 
% observado para valores de rho próximos a 1, como no caso de rho = 0,95.

% Ao observar a transformada de Fourier, podemos analisar em mais detalhes 
% a distribuição mais simétrica em todas as direções. Isso pode ser observado 
% mais claramente ao comparar o espectro para um valor de rho = -0,95, onde 
% a autocovariância isotrópica mostra um padrão elíptico em contraste com a 
% autocovariância separável.

% A simetria e a forma elíptica das bandas sugerem que a função de 
% autocovariância isotrópica mantém uma uniformidade de comportamento em 
% todas as direções, mesmo com correlação negativa. Para valores de rho > 0, 
% pode-se observar que, quando próximo de 1, a correlação se concentra mais 
% em baixas frequências, onde é mais forte. À medida que rho se afasta de 1, 
% o espectro começa a se expandir para frequências mais altas, resultando em 
% padrões elípticos ou circulares, com menor concentração no centro e maior 
% contribuição das frequências mais altas.


pause;
close(gcf);




%%
% 4.  Calcular a função de autocovariância separável das imagens ZELDA S, 
% BUILDING, TEXT e XRAY, plotando-as. Calcule primeiro a matriz de 
% autocovariância das linhas da imagem, supondo que as suas linhas são as 
% amostras do processo estocástico. Depois, calcule a matriz de 
% autocovariância das colunas da imagem, supondo desta vez que as suas 
% colunas são as amostras do processo estocástico (use a função cov). 
% Os processos são estacionários? Comente. De posse da matriz de 
% autocovariância, extraia a função de autocovariância (notar que a funçãao 
% de autocovariância pressupõe um processo estacionário - no caso da imagem
% não ser estacionária, calcule a média dos elementos de cada diagonal 
% para extrair uma aproximaçãao da função de autocovariância). Façaa o 
% produto das funções da autocovariância nas duas direções para gerar a 
% função de autocovariáncia bidimensional.

%----------Leitura de imagems---------------------------------------------
zelda_s = imread("images\zelda_s.tif");
building = imread("images\building.tif");
text = imread("images\text.tif");
xray = imread("images\xray.tif");

% Seleção de imagens
img = {zelda_s, building, text, xray};
img_names = {'Zelda', 'Building', 'Text', 'Xray'};
% ------------------------------------------------------------------------

%----------------- Matriz de atocovariância das linhas--------------------
echo off;
figure;
% Calcular a matriz de autocovariância das linhas
for ima = 1:length(img)
    % Obter o número de linhas e colunas
    [num_filas, ~] = size(img{ima});
    % Inicialização da matriz de autocovariância
    R_para_linhas = zeros(num_filas, num_filas);
    % Calcular a matriz de autocovariância para as linhas
    for i = 1:num_filas
        for j = 1:num_filas
            cov_matrix_linhas = cov(double(img{ima}(i, :)), double(img{ima}(j, :)));
            R_para_linhas(i, j) = cov_matrix_linhas(1, 2);
        end
    end
    % Normalizar a matriz de autocovariância para o intervalo [-1, 1]
    min_val = min(R_para_linhas(:));
    max_val = max(R_para_linhas(:));
    R_para_linhas_normalized = 2 * ((R_para_linhas - min_val) / (max_val - min_val)) - 1;
    subplot(2, 2, ima);
    imagesc(R_para_linhas_normalized);
    % Ajustar a escala de cores para o intervalo [-1, 1]
    clim([-1 1]);
    colorbar;
    % Ajustar o colormap para destacar a variação
    colormap('jet');
    title(['Matriz de Autocovariância das Linhas para ', img_names{ima}]);
end

echo on;
% Para analisar melhor a correlação entre as linhas de cada uma das
% imagens, realizamos uma normalização da matriz de autocovariância 
% para observar o fenômeno em intervalos entre [-1, 1]. Esse intervalo 
% é indicado para avaliar a correlação ou covariância entre os pixels da 
% imagem. Observamos que, para valores iguais ou próximos a 1, existe uma 
% forte correlação entre os dados; valores em torno de 0 indicam ausência 
% de correlação; e valores negativos sinalizam uma correlação negativa, 
% como visto nos casos anteriores.

% Para Zelda_s, observamos uma forte correlação na diagonal principal, 
% onde os valores variam entre 1 e próximos a 1. Nos arredores, 
% identificam-se correlações negativas, indicadas por tons azulados, 
% além de zonas com correlação muito baixa. Isso indica algumas 
% semelhanças nas linhas da imagem.

% Para Building, a diagonal principal se aproxima de 0, o que sugere 
% pouca correlação entre as linhas da imagem, refletindo variações 
% significativas na intensidade dos pixels. No entanto, na parte inferior 
% direita, há uma área com forte correlação entre as linhas. Ao redor da 
% imagem, observam-se valores próximos de -1, indicando uma forte 
% correlação negativa. Isso sugere que em algumas regiões da imagem, como 
% nas zonas escuras ou sombreadas do edifício (os orifícios circulares), 
% o aumento da intensidade dos pixels em uma linha corresponde à diminuição 
% nas linhas adjacentes, resultando em diferenças de luminosidade.

% Para Text, na diagonal principal há pequenos fragmentos com forte 
% correlação positiva entre as linhas. Nos arredores da matriz de 
% autocovariância, há um quadrado indicando forte correlação nos cantos, 
% possivelmente devido às intensidades das letras na imagem e às zonas 
% brancas nas partes superior e inferior. Em contraste, a imagem também 
% exibe uma forte correlação negativa, indicando que a covariância entre 
% as linhas revela intensidades de pixels diferentes entre as linhas 
% adjacentes.

% Para Xray, observamos uma maior correlação positiva, o que significa 
% que a covariância calculada entre as linhas da imagem mostra alta 
% correlação, especialmente em regiões homogêneas. A imagem contém uma 
% grande quantidade de pixels com intensidades semelhantes, representando 
% o esqueleto humano. No entanto, em algumas partes dos ossos, a 
% intensidade é menor, resultando em uma diminuição no heatmap, aproximando-se 
% de zero. Ainda assim, existe correlação negativa, onde as linhas podem 
% ter adjacências com intensidades de pixels menores.

% De acordo com as matrizes de autocovariância, para determinar se há um 
% processo estocástico, analisamos a simetria na matriz, ou seja, os 
% componentes acima e abaixo da diagonal. Levando isso em conta, as 
% imagens que apresentam simetria mais clara são 'Text' e 'Xray', onde é 
% possível identificar padrões simétricos ao redor da diagonal. No entanto, 
% em 'Zelda_s' e 'Building', observam-se pequenos detalhes que indicam 
% a ausência de processos estocásticos, como a falta de simetria.
pause;
close(gcf);


% Calcular a matriz de autocovariância das columnas
echo off;
figure;
for ima = 1:length(img)
    [~, num_columnas] = size(img{ima});
    R_para_columnas = zeros(num_columnas, num_columnas);
    for i = 1:num_columnas
        for j = 1:num_columnas
            cov_matrix_colunas = cov(double(img{ima}(:, i)), double(img{ima}(:, j)));
            R_para_columnas(i, j) = cov_matrix_colunas(1, 2);
        end
    end
    min_val = min(R_para_columnas(:));
    max_val = max(R_para_columnas(:));
    R_para_columnas_normalized = 2 * ((R_para_columnas - min_val) / (max_val - min_val)) - 1;
    subplot(2, 2, ima);
    imagesc(R_para_columnas_normalized);
    clim([-1 1]);
    colorbar;
    colormap('jet');
    title(['Matriz de Autocovariância das Colunas para ', img_names{ima}]);
end
echo on;
% Para Zelma_S, observamos que nas colunas da imagem há mais zonas com 
% baixa intensidade de pixels, especialmente nas partes verticais, onde 
% aparecem o cabelo, parte da roupa e sombras. Ao analisar as colunas, 
% obtém-se uma estatística com intensidades mais baixas em comparação com 
% as linhas, resultando em uma área maior onde há maior correlação entre 
% os pixels. Esse comportamento é evidente na mancha escura atrás da 
% mulher, onde a autocovariância tende a 1 devido à quantidade de zonas 
% escuras nas colunas. Também há fortes correlações negativas, onde 
% pixels adjacentes de altas frequências têm baixas frequências, gerando 
% tons azulados em um intervalo entre -0,5 e -1. Contudo, há padrões na 
% imagem onde a correlação é baixa, com valores próximos a 0, o que pode 
% ser observado no rosto da mulher, onde a intensidade dos pixels varia 
% significativamente, alterando a escala de cinza. Essa variabilidade na 
% intensidade dos pixels sugere que o processo pode não ser estacionário, 
% já que as propriedades estatísticas não são constantes.

% Para Building, observamos uma baixa correlação entre os pixels na 
% imagem. A diagonal indica a força da correlação entre as colunas. 
% Existem padrões na matriz de autocovariância que refletem a diversidade 
% de intensidades na escala de cinza. Há uma correlação negativa entre 
% as colunas adjacentes nas zonas escuras e claras. A variação estatística 
% entre as colunas sugere que a correlação não é suficientemente alta para 
% padrões repetitivos, mas também não é tão baixa para indicar uma completa 
% ausência de correlação. Existe uma pequena simetria entre os padrões 
% acima e abaixo da diagonal, o que pode sugerir um processo estacionário, 
% embora sejam necessárias mais informações para confirmar essa hipótese.

% Para Text, observamos alguns padrões onde há baixa correlação. A 
% diagonal mostra a correlação entre as colunas, indicando valores altos 
% muito concentrados dentro da diagonal, que estão altamente correlacionados 
% consigo mesmos, mas essa correlação se dissipa rapidamente para os 
% elementos adjacentes. No entanto, há pontos onde a correlação é maior, 
% o que pode ser observado em áreas de alta intensidade. Isso pode ocorrer 
% devido à semelhança entre as letras e números na imagem, que geram uma 
% boa correlação. Existe uma pequena simetria entre os padrões acima e 
% abaixo da diagonal, sugerindo um processo estacionário, mas são 
% necessárias mais informações para garantir essa conclusão.

% Para Xray, observamos zonas onde a autocovariância está próxima de 1, 
% especialmente nas áreas dos ossos, que são mais homogêneas nas colunas. 
% A presença de zonas azuis indica que colunas com aumento de intensidade 
% de pixels têm colunas adjacentes com diminuição de intensidade. Zonas com 
% áreas verdes e amarelas representam baixa correlação ou ausência de uma 
% correlação clara. Isso se deve à variabilidade significativa nos detalhes 
% da imagem, onde não há um padrão evidente. A presença de zonas com valores 
% próximos de zero sugere que a imagem tem grande variabilidade, sem um 
% padrão de correlação uniforme em todas as partes. Isso é comum em imagens 
% médicas, onde diferentes partes podem ter propriedades distintas refletidas 
% na intensidade dos pixels. Não há simetria entre os padrões acima e abaixo 
% da diagonal, o que pode sugerir um processo não estacionário.

pause;
close(gcf);

%----------------- Matriz de atocovariância das colunas--------------------
echo off;
figure;
for ima = 1:length(img)
    [num_filas, num_colunas] = size(img{ima});
    autocov_func_linhas = zeros(1, num_filas);
    for d = 0:num_filas-1
        autocov_func_linhas(d+1) = mean(diag(cov(double(img{ima}')), d));
    end
    autocov_func_colunas = zeros(1, num_colunas);
    for d = 0:num_colunas-1
        autocov_func_colunas(d+1) = mean(diag(cov(double(img{ima})), d));
    end
    [X, Y] = meshgrid(autocov_func_colunas, autocov_func_linhas);
    autocov_bidimensional_separavel = X .* Y;
    min_val = min(autocov_bidimensional_separavel(:));
    max_val = max(autocov_bidimensional_separavel(:));
    autocov_bidimensional_separavel_normalized = 2 * ((autocov_bidimensional_separavel - min_val) / (max_val - min_val)) - 1;
    subplot(2, 2, ima);
    colormap('jet');
    imagesc(autocov_bidimensional_separavel_normalized);
    clim([-1 1]); 
    colorbar;
    title(['Função de Autocovariância Bidimensional - ', img_names{ima}]);
end
sgtitle('Função de Autocovariância Bidimensional Separável Normalizada para Todas as Imagens');

echo on;
% Para esta parte, foi calculada a função de autocovariância bidimensional
% separável, que é o produto das funções de autocovariância unidimensionais
% nas direções horizontal e vertical. Esta função resulta no produto das 
% funções de covariância em unidimensional.

% A função de autocovariância bidimensional para a imagem "Zelda S" 
% apresenta um padrão relativamente uniforme, com cores que variam 
% principalmente entre azul e vermelho em alguns pontos específicos.
% Isso sugere que as estruturas da imagem são homogêneas ao longo de 
% diferentes blocos, indicando que a imagem pode ser considerada um 
% processo estocástico estacionário, uma vez que suas propriedades 
% estatísticas permanecem consistentes ao longo do espaço.

% A função de autocovariância para a imagem "Building" apresenta um 
% comportamento um pouco mais variado, mas ainda relativamente uniforme. 
% Existem algumas áreas com maior variação em comparação com "Zelda S". 
% Similar à "Zelda S", "Building" parece ter uma estrutura aproximadamente 
% estacionária, com variações moderadas. Isso sugere que "Building" 
% também pode ser modelada como um processo estocástico estacionário, 
% com propriedades estatísticas que não mudam significativamente em 
% diferentes regiões da imagem.

% A imagem "Text" mostra variações mais notáveis na função de autocovariância 
% bidimensional, com regiões de diferentes intensidades de cor, sugerindo 
% a presença de padrões ou texturas mais complexas. A função de autocovariância 
% indica que a imagem "Text" é menos estacionária em comparação com "Zelda S" 
% e "Building", sugerindo que há diferentes texturas e variações dentro 
% da imagem. Portanto, "Text" pode ser considerada um processo estocástico, 
% mas com características de não estacionariedade devido às variações 
% em suas propriedades estatísticas.

% A imagem "Xray" apresenta uma função de autocovariância bidimensional 
% com variações significativas, especialmente nas bordas da imagem. As áreas 
% vermelhas e azuis intensas indicam mudanças acentuadas nas propriedades 
% estatísticas dos blocos. A imagem "Xray" parece ser a menos estacionária 
% das quatro, com mudanças significativas na função de autocovariância 
% indicando estruturas complexas e não homogêneas. Isso sugere que "Xray" 
% é um processo estocástico não estacionário, refletindo as variações de 
% contraste comuns em imagens de raio-X, onde diferentes densidades de 
% materiais criam variações distintas na imagem.

pause;
close(gcf);


%%
% 5. No exercício anterior, para as mesmas 4 imagens:

% a. De posse da função de autocovariância das colunas de cada imagem, 
% calculada no item anterior, modelar cada função de autocovariância com 
% um modelo do tipo r(n) = σ^2ρ^n.

zelda_s = imread("images\zelda_s.tif");
building = imread("images\building.tif");
text = imread("images\text.tif");
xray = imread("images\xray.tif");

img = {zelda_s, building, text, xray};
img_names = {'Zelda', 'Building', 'Text', 'Xray'};
echo off;
figure;
for ima = 1:length(img)
    [linhas, colunas] = size(img{ima});
    autocov_func_colunas = zeros(1, colunas);
    for d = 0:colunas-1
        autocov_func_colunas(d+1) = mean(diag(cov(double(img{ima})), d));
    end
    % Modelo r(n) = sigma^2 * rho^n
    d = 0:colunas-1;
    rho = autocov_func_colunas(2) / autocov_func_colunas(1);  
    sigma2 = autocov_func_colunas(1);  
    modelo = sigma2 * rho.^d; 

    subplot(2, 2, ima); 
    plot(d, autocov_func_colunas, 'b-', 'LineWidth', 1, 'DisplayName', 'Estimado'); 
    hold on; 
    plot(d, modelo, 'r-', 'LineWidth', 1, 'DisplayName', 'Modelo'); 
    title(['Funcao Autocov das colunas ', img_names{ima}]);
    xlabel('Distancia (d)');
    ylabel('Autocovariancia');
    legend('show');
    hold off;
end
sgtitle('Comparação entre Autocovariância Estimada e Modelo');
echo on;
% Na imagem "Zelda S", o modelo captura as principais características de 
% curto alcance, mas não é suficiente para modelar completamente a 
% autocovariância em longas distâncias. A imagem pode ser considerada 
% um processo estocástico, com o comportamento de curto alcance bem 
% representado pelo modelo. A função de autocovariância estimada 
% (linha azul), realizada com a função 'cov' do MATLAB, decai rapidamente. 
% Após um certo ponto, a autocovariância se aproxima de zero e oscila em 
% torno desse valor. O modelo ajustado r(n) = σ^2ρ^n (linha 
% vermelha) segue bem o decaimento inicial da autocovariância, mas não 
% captura as oscilações e os valores próximos a zero. Isso indica que o 
% modelo é adequado para capturar o decaimento inicial, mas não consegue 
% modelar bem as flutuações em longas distâncias.

% Na imagem "Building", o comportamento é similar ao de "Zelda S", 
% sugerindo que o modelo captura bem as principais tendências de curto 
% alcance, mas não modela completamente as oscilações de longo alcance. 
% A autocovariância estimada para "Building" com 'cov' também apresenta 
% um decaimento rápido, seguido por pequenas oscilações em torno de zero. 
% A imagem pode ser considerada um processo estocástico com um comportamento 
% inicial bem modelado, mas com características adicionais que não são 
% capturadas pelo modelo simples.

% A complexidade da imagem "Text", provavelmente devido à presença de padrões 
% de texto e transições de contraste, faz com que o modelo r(n) = σ^2ρ^n 
% seja insuficiente para capturar a estrutura de autocovariância da imagem. 
% A autocovariância estimada para "Text" é mais complexa, com várias oscilações 
% significativas que se estendem a distâncias maiores. No entanto, o modelo ajustado 
% falha em capturar essas oscilações, resultando em uma discrepância maior entre o 
% modelo e a autocovariância estimada.

% A imagem "Xray" possui características que não são bem modeladas por um processo 
% simples, sugerindo a presença de estruturas complexas e heterogêneas na imagem. 
% Isso indica que "Xray" pode ser um processo estocástico com características não 
% estacionárias e que um modelo mais sofisticado seria necessário para capturar sua 
% estrutura de autocovariância. A imagem "Xray" apresenta uma autocovariância que, 
% ao contrário das outras imagens, não só decai como também mostra uma tendência 
% clara a valores negativos a longas distâncias. O modelo ajustado não é capaz de 
% capturar essa inversão e as oscilações subsequentes, indicando uma inadequação 
% significativa do modelo para essa imagem.


pause;
close(gcf);

% b. Plotar os modelos juntamente com as autocovariâncias calculadas, nos 
% domínios do tempo de da frequência (usar fftshift para o domínio da 
% frequência). O que você conclui? (Discutir com o Professor - item importante!).

zelda_s = imread("images\zelda_s.tif");
building = imread("images\building.tif");
text = imread("images\text.tif");
xray = imread("images\xray.tif");

img = {zelda_s, building, text, xray};
img_names = {'Zelda', 'Building', 'Text', 'Xray'};
echo off;
figure;
for ima = 1:length(img)
    [linhas, colunas] = size(img{ima});
    autocov_func_colunas = zeros(1, colunas);
    for d = 0:colunas-1
        autocov_func_colunas(d+1) = mean(diag(cov(double(img{ima})), d));
    end

    % r(n) = sigma^2 * rho^n
    d = 0:colunas-1;
    rho = autocov_func_colunas(2) / autocov_func_colunas(1);  
    sigma2 = autocov_func_colunas(1);  
    modelo = sigma2 * rho.^d;  

    % Domínio da Frequência (FFT)
    fft_autocov = fftshift(abs(fft(autocov_func_colunas)));
    fft_modelo = fftshift(abs(fft(modelo)));

    % Plotagem no Domínio do Tempo
    subplot(2, 2, ima); 
    plot(d, autocov_func_colunas, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Autocov Estimada'); 
    hold on; 
    plot(d, modelo, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Modelo'); 
    title(['Domínio do Tempo - ', img_names{ima}]);
    xlabel('Distância (d)');
    ylabel('Autocovariância');
    xlim([-1, 1]);
    legend('show');
    hold off;
    
    % Plotagem no Domínio da Frequência
    subplot(2, 2, ima); 
    freq = -pi:2*pi/colunas:pi-(2*pi/colunas);
    plot(freq, fft_autocov, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Autocov Estimada'); 
    hold on; 
    plot(freq, fft_modelo, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Modelo'); 
    title(['Domínio da Frequência - ', img_names{ima}]);
    xlabel('Frequência Normalizada');
    ylabel('Magnitude');
    xlim([-1, 1]);
    legend('show');
    hold off;
end

% Ajustar o layout
sgtitle('Comparação entre Autocovariância Estimada e Modelo nos Domínios do Tempo e da Frequência');
echo on;
% Com os resultados obtidos, podemos determinar como o modelo gerado pela 
% função 'cov' do MATLAB consegue captar as frequências das imagens. No 
% caso da imagem "Zelda S", observamos que a linha azul apresenta alguns 
% picos, o que indica a presença de componentes com frequências específicas 
% na imagem, como detalhes ou texturas em frequências mais altas. 
% No entanto, o modelo r(n) = σ^2ρ^n  captura bem as componentes 
% de baixa frequência, mas falha em modelar adequadamente as características 
% mais complexas observadas nas componentes de alta frequência. Isso sugere 
% que "Zelda S" pode ser modelada parcialmente por processos estocásticos, 
% mas um modelo mais complexo seria necessário para uma descrição completa.

% Para a imagem "Building", no domínio da frequência, a FFT da autocovariância 
% real apresenta múltiplos picos, enquanto o modelo r(n) = σ^2ρ^n  
% captura apenas a estrutura básica, subestimando a magnitude das oscilações 
% em frequências mais altas. Embora o modelo consiga capturar a tendência geral 
% no domínio do tempo, ele não é suficientemente robusto para captar as 
% características complexas no domínio da frequência. A imagem "Building" 
% apresenta uma complexidade que sugere a necessidade de um modelo mais 
% avançado para descrever completamente seu comportamento estocástico.

% Na imagem "Text", observamos variações significativas nas frequências ou 
% intensidades dos pixels, mais fortes do que nas imagens anteriores. Isso 
% sugere que o modelo realizado com 'cov' gera picos mais pronunciados, 
% indicando componentes com maior frequência. No entanto, o modelo r(n) = σ^2ρ^n, 
% por outro lado, suaviza esses picos e não consegue reproduzir as características 
% específicas das frequências mais altas, falhando em capturar a complexidade da imagem.

% Na imagem "Xray", temos componentes mais pronunciados tanto em baixas 
% quanto em altas frequências, o que pode ser observado a olho nu na imagem. 
% Isso sugere a presença de estruturas mais complexas, e o modelo simplificado 
% falha em capturar as características chave da imagem. Isso sugere que "Xray" 
% é um processo estocástico não estacionário que requer uma modelagem mais 
% elaborada para uma representação precisa.
pause;
close(gcf);

%%
% 6. Repetir os itens 4 e 5 acima, só que agora para os blocos 8 × 8 das 
% mesmas imagens.Sugestão: agora, o processo estocástico será constituído 
% pelos blocos das imagens; assim, será necessária a criação de uma 
% matriz em que as linhas serão as colunas de todos os blocos 8 × 8, na 
% qual será aplicada a função cov. Comente sobre a estacionaridade do 
% processo estocástico resultante, analisando a sua matriz de 
% autocovariância. Compare com os resultados do item 4 acima.

zelda_s = imread("images\zelda_s.tif");
building = imread("images\building.tif");
text = imread("images\text.tif");
xray = imread("images\xray.tif");
img = {zelda_s, building, text, xray};
img_names = {'Zelda', 'Building', 'Text', 'Xray'};
tamanho_blocos = 8;
% -------------- Autocovariância das linhas para blocos 8x8----------------
echo off;
for ima=1:length(img)
    [linhas, colunas] = size(img{ima});
    num_blocos_linhas = floor(linhas/tamanho_blocos);
    num_blocos_colunas = floor(colunas/tamanho_blocos);
    caracteristicas = tamanho_blocos^2;
    A = zeros(num_blocos_linhas*num_blocos_colunas, caracteristicas);
    index = 1;
    for i=1:tamanho_blocos:linhas-tamanho_blocos+1
        for j=1:tamanho_blocos:colunas-tamanho_blocos+1
            bloco = img{ima}(i:i+tamanho_blocos-1, j:j+tamanho_blocos-1);
            A(index,:) = bloco(:);
            index = index + 1;
        end
    end
    autocov_blocos = cov(A);
    min_val = min(autocov_blocos(:));
    max_val = max(autocov_blocos(:));
    autocov_blocos_normalized = 2 * ((autocov_blocos - min_val) / (max_val - min_val)) - 1;
    subplot(2, 2, ima);
    imagesc(autocov_blocos_normalized);
    clim([-1 1]);
    colorbar;
    colormap('jet');
    title(['Matriz de Autocovariância dos Blocos para ', img_names{ima}]);
end
echo on;

% Nesta parte, podemos observar que, ao dividir toda a imagem em blocos de 
% 8x8 pixels, surgem padrões mais definidos nas estruturas das imagens. 
% Para a imagem "Zelda S", observamos que sua matriz de autocovariância 
% nos blocos apresenta padrões repetitivos na diagonal e fora dela, 
% sugerindo que uma estrutura diferente da imagem original está se formando. 
% Lembrando que a variação de cores representa a correlação entre os blocos 
% próximos, podemos ver que a imagem possui uma estrutura mais consistente 
% ao longo de toda a imagem. Portanto, podemos considerar que a imagem com 
% blocos de 8x8 pixels é um processo estocástico, onde as correlações entre 
% os blocos decaem lentamente à medida que a distância aumenta.

% Para a imagem "Building", observamos o mesmo padrão simétrico ao longo 
% de sua diagonal, mas também notamos uma maior variedade de intensidades 
% na correlação dos blocos. Isso reflete as variações na imagem original, 
% como sombras e áreas mais iluminadas. Encontramos padrões repetitivos, 
% embora também existam detalhes ou texturas que indicam uma alteração na 
% consistência da imagem. Podemos considerá-la um processo estocástico; 
% no entanto, apresenta características não estacionárias.

% A imagem "Text" apresenta padrões mais complexos, que também podem ser 
% facilmente observados na imagem original. Devido à mudança de intensidade 
% dos pixels entre as letras e áreas mais escuras, encontramos padrões 
% repetitivos que podem ser devidos às letras. As altas correlações entre 
% blocos não adjacentes indicam a presença de padrões regulares, mas que 
% não seguem uma distribuição uniforme, sugerindo um processo estocástico 
% não estacionário, com frequências específicas dominando a estrutura da 
% imagem.

% Na imagem "Xray", observamos uma variação nas intensidades um pouco mais 
% estruturada. Devido à estrutura da imagem, ao dividi-la em blocos, 
% obtemos uma zona onde há uma forte correlação entre eles. No entanto, 
% poderíamos implementar modelos mais complexos para captar melhor as 
% características da imagem. Ao dividir a imagem em pequenos blocos, 
% estamos focando na análise de pequenas regiões da imagem, que muitas 
% vezes têm menos variabilidade interna do que a imagem como um todo. 
% Isso significa que podemos dividir a imagem em subestruturas que podem 
% parecer mais uniformes, o que pode resultar em uma maior homogeneidade.
pause;
close(gcf);
%%
% -------------- ---------------
zelda_s = imread("images\zelda_s.tif");
building = imread("images\building.tif");
text = imread("images\text.tif");
xray = imread("images\xray.tif");
img = {zelda_s, building, text, xray};
img_names = {'Zelda', 'Building', 'Text', 'Xray'};
tamanho_blocos = 8;
echo off;
figure;
for ima = 1:length(img)
    [linhas, colunas] = size(img{ima});
    num_blocos_linhas = floor(linhas/tamanho_blocos);
    num_blocos_colunas = floor(colunas/tamanho_blocos);
    caracteristicas = tamanho_blocos^2;
    A = zeros(num_blocos_linhas*num_blocos_colunas, caracteristicas);
    index = 1;

    for i = 1:tamanho_blocos:linhas-tamanho_blocos+1
        for j = 1:tamanho_blocos:colunas-tamanho_blocos+1
            bloco = img{ima}(i:i+tamanho_blocos-1, j:j+tamanho_blocos-1);
            A(index, :) = bloco(:);
            index = index + 1;
        end
    end
    autocov_blocos = cov(A);
    min_val = min(autocov_blocos(:));
    max_val = max(autocov_blocos(:));
    autocov_blocos_normalized = 2 * ((autocov_blocos - min_val) / (max_val - min_val)) - 1;
    autocov_func_blocos = zeros(1, caracteristicas);
    for d = 0:caracteristicas-1
        autocov_func_blocos(d+1) = mean(diag(autocov_blocos, d));
    end
    % Modelo r(n) = sigma^2 * rho^n
    d = 0:caracteristicas-1;
    rho = autocov_func_blocos(2) / autocov_func_blocos(1);
    sigma2 = autocov_func_blocos(1);
    modelo = sigma2 * rho.^d; 
    subplot(2, 2, ima); 
    plot(d, autocov_func_blocos, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Autocov Estimada'); 
    hold on; 
    plot(d, modelo, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Modelo'); 
    title(['Autocovariância das Colunas dos Blocos - ', img_names{ima}]);
    xlabel('Distância (d)');
    ylabel('Autocovariância');
    legend('show');
    hold off;
end
sgtitle('Autocovariância das Colunas dos Blocos 8x8 e Modelo para Todas as Imagens');
echo on;

% Nesta parte, podemos observar, utilizando o modelo 'cov' do MATLAB e o 
% modelo gerado por r(n) = σ^2ρ^n, que as linhas azuis (função cov) 
% em cada uma das imagens revelam, através de suas funções de autocovariância 
% unidimensionais, padrões repetitivos que se manifestam nas oscilações 
% significativas ao longo da distância. 

% Podemos perceber que, para cada uma das imagens, esses padrões repetitivos 
% sugerem a existência de estruturas persistentes. No entanto, as amplitudes 
% pronunciadas das oscilações indicam a presença de padrões repetitivos nas 
% intensidades das imagens, evidenciando semelhanças entre "Zelda" e "Building". 

% Por outro lado, a imagem "Text" apresenta uma autocovariância estimada com 
% oscilações muito pronunciadas, refletindo as mudanças de intensidade dos 
% pixels entre letras e espaços em branco. Essas oscilações indicam a presença 
% de padrões muito específicos, provavelmente associados ao texto. 

% A imagem "Xray" apresenta uma autocovariância estimada que decai lentamente, 
% com oscilações menores ao longo da distância. Isso indica uma forte correlação 
% entre os blocos próximos, resultando em uma estrutura mais homogênea do que 
% nas outras imagens analisadas.

% Por outro lado, o modelo r(n) = σ^2ρ^n é insuficiente para capturar 
% completamente as complexidades observadas nas autocovariâncias, especialmente 
% em imagens com padrões repetitivos ou estruturas complexas. Para cada uma das 
% imagens, o modelo segue uma tendência de decaimento, similar à observada na 
% função cov, mas falha em reproduzir as oscilações e detalhes específicos dos 
% padrões presentes nas imagens.
pause;
close(gcf);
%%
zelda_s = imread("images\zelda_s.tif");
building = imread("images\building.tif");
text = imread("images\text.tif");
xray = imread("images\xray.tif");
img = {zelda_s, building, text, xray};
img_names = {'Zelda', 'Building', 'Text', 'Xray'};
tamanho_blocos = 8;
echo off;
figure;
for ima = 1:length(img)
    [linhas, colunas] = size(img{ima});
    num_blocos_linhas = floor(linhas/tamanho_blocos);
    num_blocos_colunas = floor(colunas/tamanho_blocos);
    caracteristicas = tamanho_blocos^2;
    A = zeros(num_blocos_linhas * num_blocos_colunas, caracteristicas);
    index = 1;

    for i = 1:tamanho_blocos:linhas-tamanho_blocos+1
        for j = 1:tamanho_blocos:colunas-tamanho_blocos+1
            bloco = img{ima}(i:i+tamanho_blocos-1, j:j+tamanho_blocos-1);
            A(index, :) = bloco(:);
            index = index + 1;
        end
    end
    autocov_blocos = cov(A);
    autocov_func_blocos = zeros(1, caracteristicas);
    for d = 0:caracteristicas-1
        autocov_func_blocos(d+1) = mean(diag(autocov_blocos, d));
    end
    
    d = 0:caracteristicas-1;
    rho = autocov_func_blocos(2) / autocov_func_blocos(1); 
    sigma2 = autocov_func_blocos(1); 
    modelo = sigma2 * rho.^d;  
    fft_autocov = fftshift(abs(fft(autocov_func_blocos)));
    fft_modelo = fftshift(abs(fft(modelo)));

    subplot(2, 2, ima);
    freq = linspace(-pi, pi, caracteristicas);
    plot(freq, fft_autocov, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Autocov Estimada (FFT)'); 
    hold on; 
    plot(freq, fft_modelo, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Modelo (FFT)'); 
    title(['Domínio da Frequência - ', img_names{ima}]);
    xlabel('Frequência Normalizada');
    ylabel('Magnitude');
    xlim([-1, 1]);
    legend('show');
    hold off;
end
sgtitle('Autocovariância dos Blocos 8x8 e Modelo nos Domínios do Tempo e da Frequência');
echo on;
% Vamos observar o comportamento do modelo 'cov' (linha azul) do MATLAB e do 
% modelo r(n) = σ^2ρ^n (linha vermelha). Inicialmente, observamos que 
% há uma grande presença de componentes de baixa frequência nas imagens, 
% resultando em uma aproximação em torno de 0. Em algumas imagens, como "Text" 
% e "Building", são observadas algumas oscilações que indicam a presença de 
% frequências mais dominantes em certas partes da imagem.

% No caso da imagem "Text", devido aos seus padrões e variações de frequências 
% associadas às letras, observamos pequenas oscilações. Por outro lado, o modelo 
% r(n) = σ^2ρ^n, nas três primeiras imagens (Zelda, Building e Text), 
% captura adequadamente as baixas frequências, mas não consegue replicar a 
% magnitude dos picos observados.

% No entanto, para a imagem "Xray", o modelo r(n) = σ^2ρ^n consegue 
% capturar com maior precisão os picos das frequências mais altas, sugerindo que, 
% ao dividir a imagem em blocos de 8x8, há uma maior homogeneidade na imagem, 
% tornando o modelo mais adequado para representá-la. No entanto, ainda há 
% uma pequena discrepância em frequências mais altas, indicando que existem 
% detalhes que o modelo simples não captura completamente.

% Conclui-se, portanto, que o modelo r(n) = σ^2ρ^n consegue capturar bem os 
% componentes  de baixa frequência, mas tem dificuldade em replicar a 
% magnitude e a dispersão das frequências mais altas observadas nas 
% autocovariâncias estimadas.
pause;
close(gcf);
%%
% 7. Neste item, se calculará a covariância não separável dos blocos 8×8 de 
% cada uma das imagens ZELDA S, BUILDING, TEXT e XRAY. A partir de cada 
% bloco 8×8 da imagem, criar um vetor empilhando as colunas dos mesmos. 
% A partir dele, criar uma matriz cujas linhas serão estes vetores 
% correspondentes a cada bloco, e aplicar a função cov. Comentar a 
% estacionariedade. Em seguida, supondo estacionariedade, calcular a partir 
% da matriz resultante a função de autocovariância bidimensional dos 
% blocos da imagem. Sugestão: notar que o elemento m × n de um bloco vai 
% ser mapeado no elemento m + 8n do vetor criado empilhando as suas colunas. 
% Compare os resultados obtidos no item 6.

zelda_s = imread("images\zelda_s.tif");
building = imread("images\building.tif");
text = imread("images\text.tif");
xray = imread("images\xray.tif");
img = {zelda_s, building, text, xray};
img_names = {'Zelda', 'Building', 'Text', 'Xray'};
tamanho_blocos = 8;  
echo off;
figure;
for ima = 1:length(img)
    [linhas, colunas] = size(img{ima});
    num_blocos_linhas = floor(linhas / tamanho_blocos);
    num_blocos_colunas = floor(colunas / tamanho_blocos);
    num_blocos = num_blocos_linhas * num_blocos_colunas;
    caracteristicas = tamanho_blocos^2;
    A = zeros(num_blocos, caracteristicas);
    index = 1;
    % Dividir a imagem em blocos 8x8 e criar a matriz A empilhando as colunas
    for i = 1:tamanho_blocos:linhas-tamanho_blocos+1
        for j = 1:tamanho_blocos:colunas-tamanho_blocos+1
            bloco = img{ima}(i:i+tamanho_blocos-1, j:j+tamanho_blocos-1);
            A(index, :) = bloco(:); 
            index = index + 1;
        end
    end
    % Calcular a matriz de covariância não separável dos blocos
    cov_blocos = cov(A);
    % Calcular a função de autocovariância bidimensional
    autocov_bidimensional = zeros(tamanho_blocos, tamanho_blocos);
    for m = 1:tamanho_blocos
        for n = 1:tamanho_blocos
            % Mapeamento m + 8n
            idx = m + tamanho_blocos * (n - 1);
            autocov_bidimensional(m, n) = mean(cov_blocos(:, idx));
        end
    end
    min_val = min(autocov_bidimensional(:));
    max_val = max(autocov_bidimensional(:));
    autocov_bidimensional_normalized = 2 * ((autocov_bidimensional - min_val) / (max_val - min_val)) - 1;
    subplot(2, 2, ima);
    imagesc(autocov_bidimensional_normalized);
    colormap('jet');
    colorbar;
    title(['Autocovariância Bidimensional - ', img_names{ima}]);
end
sgtitle('Função de Autocovariância Bidimensional dos Blocos 8x8 para Todas as Imagens');
echo on;

% Ahora se genera la función de autocovarianza no separable para cada una 
% de las imágenes en bloques de 8x8, creando un vector donde se anexan los 
% valores de las columnas. Observamos que cuando se realiza un mapeo m + 8n,
% hay diferencias en las características espaciales de los bloques, donde a
% partir de esto observamos zonas más amplias con una fuerte correlación 
% entre los bloques de píxeles de la imagen. Esto permite capturar
% mejores patrones en las imágenes. 

% En comparación con los resultados anteriores, que pueden haber utilizado 
% funciones de autocovarianza unidimensionales o separables, el uso de 
% covarianza no separable y el mapeo m + 8n proporciona un análisis más 
% rico y detallado de las correlaciones bidimensionales. Esto es 
% especialmente importante para imágenes con patrones más variados o 
% complejos, como "Text" o "Xray". Todas las imágenes analizadas muestran un
% patrón centralizado de autocovarianza bidimensional, lo que indica una 
% fuerte correlación entre bloques adyacentes.

% Podemos observar, em comparação com o ponto 6, que houve uma redução 
% significativa no tamanho da imagem ao gerar uma nova matriz a partir de 
% blocos. Isso proporciona uma representação mais detalhada ao analisar 
% imagens com maior complexidade, como "Text" e "Xray". No entanto, nos 
% resultados do ponto 6, podemos observar diretamente propriedades 
% específicas de cada uma das imagens, como padrões homogêneos e zonas onde 
% há forte correlação entre os blocos gerados a partir de cada imagem.

% O que o ponto 7 sugere é um análise mais profunda, onde se pode encontrar 
% uma maior correlação entre as estruturas internas da imagem, mostrando 
% zonas circulares com maior correlação e uma diminuição mais suave da 
% autocovariância. Isso pode ser especialmente útil ao realizar uma análise 
% de imagens com maior variação nas intensidades de pixels ou com estruturas 
% mais complexas, como no caso de "Text" e "Xray". Em resumo, a redução do 
% tamanho da imagem por meio de blocos facilita a identificação de padrões
% específicos em imagens complexas, enquanto uma análise não separável 
% captura melhor as correlações internas, proporcionando uma visão mais 
% detalhada da estrutura da imagem.
pause;
close(gcf);
%%
echo off;