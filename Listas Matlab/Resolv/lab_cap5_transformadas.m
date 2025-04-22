echo on;
% Processamento digital de imagens
% Lista 6: Image Transforms

%%
%                           I imagens base
%
% Dar o display das funções base das seguintes transformadas (usar o 
% comando subplot(8,8,8*(i-1)+j), ... para a função base (i,j)):
%   a) Cosseno 8×8 (use a função idct2);
figure;
for i=1:8
    for j=1:8
        base = zeros(8,8);
        base(i,j) = 1;
        % Gerar funções usando DCT inversa
        func = idct2(base);
        subplot(8,8,8*(i-1)+j);
        imshow(base, []);
    end
end
%%
%   b) Seno 8×8;
figure;
for i=1:8
    for j=1:8
        base = zeros(8,8);
        base(i,j) = 1;
        % Gerar funções usando DCT inversa
        func = sin(2*pi*(i-1)*(0:7)'/8)*sin(2*pi*(j-1)*(0:7)/8);
        subplot(8,8,8*(i-1)+j);
        imshow(base, []);
    end
end
%%
%   c) Hadamard 8×8 (use a função hadamard, mas re-ordene as linhas da 
%      matriz resultante em order de “sequência”);
H = hadamard(8);

H = H([1,2,3,4,5,6,7,8], :);
for i = 1:8
    for j = 1:8
        % Criar uma matriz 8x8 com uma única função base Hadamard (i,j)
        hadamard_base = H(:,i) * H(j,:);
        
        % Exibir a função base
        subplot(8,8,8*(i-1)+j);
        imshow(hadamard_base, []);
        title(['Hadamard(', num2str(i), ',', num2str(j), ')']);
    end
end
%%
%   d) Haar 8×8;

haar_matrix = zeros(8,8,8,8);
for i = 1:8
    for j = 1:8
        haar_matrix(:,:,i,j) = haar_wavelet(i-1,j-1,8); 
        subplot(8,8,8*(i-1)+j);
        imshow(haar_matrix(:,:,i,j), []);
        title(['Haar(', num2str(i), ',', num2str(j), ')']);
    end
end

% Função personalizada para gerar Haar wavelet
function h = haar_wavelet(p, q, N)
    x = zeros(1,N);
    y = zeros(1,N);
    
    % Valores de p e q determinam a posição e a largura da onda Haar
    if p == 0
        x(:) = 1/sqrt(N);
    else
        k = N / 2^p;
        x(1:k) = 1/sqrt(k);
        x(k+1:2*k) = -1/sqrt(k);
    end
    
    if q == 0
        y(:) = 1/sqrt(N);
    else
        k = N / 2^q;
        y(1:k) = 1/sqrt(k);
        y(k+1:2*k) = -1/sqrt(k);
    end
    
    h = x' * y;
end

%%
%         II Transformadas, reconstrução de imagens e compactação
%
% 1. Calcule a DCT bi-dimensional da imagem LENA (a DCT possui o mesmo 
%    tamanho da imagem). Observar os coeficientes (sugestão: use os comandos 
%    colormap jet(64), imagesc(...), colorbar, e mostre o logaritmo do módulo 
%    da imagem + 1).
lena = imread("images\lena256.tif");
dct_lena = dct2(lena);

figure;
imagesc(log(abs(dct_lena))+1);
colormap jet(64);
colorbar;

%%

% 2. Retenha somente os coeficientes da DCT mostrados na figura 2, tire a 
%    DCT inversa e mostre as imagens resultantes. j deve ser 1,2,4,8,16,32,
%    64 e 128. Com base no resultado, comente sobre como a DCT pode ser 
%    usada para comprimir imagens. Sugest˜ao: Multiplique elemento a elemento 
%    a DCT da imagem por uma m´ascara com 1’s à esquerda e acima da 
%    diagonal j. Tal máscara pode ser gerada com os comandos:
%                   A = zeros(size);
%                   A(1:j,1:j) = fliplr(triu(ones(j)));

lena = imread("images\lena256.tif");
dct_lena = dct2(lena);
j_values = [1, 2, 4, 8, 16, 32, 64, 128];
num_j = length(j_values);
figure;

for k = 1:num_j
    j = j_values(k);

    % Criar máscara
    mask = zeros(size(lena));
    mask(1:j, 1:j) = rot90(triu(ones(j)),2);
    
    % Aplicar máscara à DCT da imagem
    dct_masked = dct_lena .* mask;
    
    % Calcular a DCT inversa para obter a imagem reconstruída
    lena_reconstructed = idct2(dct_masked);
    
    % Visualizar a imagem reconstruída
    subplot(2, ceil(num_j / 2), k);
    imshow(uint8(lena_reconstructed));
    title(['j = ', num2str(j)]);
end
%%
%               III Transformada Discreta de Fourier (DFT)
%
% 1. Carregar a imagem ZELDA S.
zelda_s = imread("images\zelda_s.tif");

%   a) Calcular a sua FFT bi-dimensional.
fft_zelda_s = fft2(double(zelda_s));

%   b) A partir da DFT, gerar 2 matrizes: a matriz MAG com o seu módulo e 
%      uma matriz ANGLE com módulo igual a 1 e fase igual à da DFT.
MAG = abs(fft_zelda_s);  
ANGLE = exp(1i * angle(fft_zelda_s));

%   c) Recupere a imagem (com ifft2) somente a partir da matriz MAG. 
%      Visualize o resultado.

reconstructed_mag = ifft2(MAG);
figure;
imshow(uint8(reconstructed_mag));
title('Imagem reconstruída a partir da matriz MAG');

%   d) Recupere a imagem somente a partir da matriz ANGLE. Visualize o 
%      resultado (use colormap(gray) e imagesc).

reconstructed_angle = ifft2(ANGLE);
figure;
imagesc(real(reconstructed_angle)); 
colormap(gray);
colorbar;
title('Imagem reconstruída a partir da matriz ANGLE');

%   e) O que você conclui comparando os items 1c e 1d?

%%
% 2. Repetir o item 1 para a imagem BUILDING.
building = imread("images\building.tif");

%   a) Calcular a sua FFT bi-dimensional.

fft_building = fft2(double(building));

%   b) A partir da DFT, gerar 2 matrizes: a matriz MAG com o seu módulo e 
%      uma matriz ANGLE com módulo igual a 1 e fase igual à da DFT.

MAG = abs(fft_building); 
ANGLE = exp(1i * angle(fft_building));

%   c) Recupere a imagem (com ifft2) somente a partir da matriz MAG. 
%      Visualize o resultado.
reconstructed_mag = ifft2(MAG);
figure;
imshow(uint8(reconstructed_mag));
title('Imagem reconstruída a partir da matriz MAG');

%   d) Recupere a imagem somente a partir da matriz ANGLE. Visualize o 
%      resultado (use colormap(gray) e imagesc).
reconstructed_angle = ifft2(ANGLE);
figure;
imagesc(real(reconstructed_angle)); 
colormap(gray);
colorbar;
title('Imagem reconstruída a partir da matriz ANGLE');
%   e) O que você conclui comparando os items 1c e 1d?

%%
% Observação: Nos itens IV e V, a seguir, para calcular tranformadas em 
% blocos e aconselhável usar a função blkproc


%%
%                       IV Transformadas ótimas
%
% 1. Calcular as funções base da transformada de Karhunen Loève (KLT) 8×8 
%    separavel para as imagems ZELDA_S e TEXT. Armazenar os resultados para uso 
%    posterior. Visualise as funções base como em I. Sugestão: para achar a 
%    KLT das linhas de uma imagem M × N, crie uma matriz empilhando os 
%    blocos 8×8 um em cima do outro, e use a função cov seguida da função 
%    eig. Para achar a KLT das colunas, fa¸ca o mesmo com a matriz transposta.



zelda = imread('images\zelda_s.tif'); 
text = imread('images\text.tif');    

blocos = 8;  

X_zelda = im2col(zelda, [blocos, blocos], 'distinct');
X_text = im2col(text, [blocos, blocos], 'distinct');



%%
% 2. Calcular a KLT 8×8 separavel das imagens acima. Calcule a matriz de 
%    autocovariância dos blocos 8×8 do resultado (coeficientes). Explique o 
%    obtido.


zelda = imread('images\zelda_s.tif'); 
text = imread('images\text.tif');    


blocos = 8;  

X_zelda = im2col(zelda, [blocos, blocos], 'distinct');
X_text = im2col(text, [blocos, blocos], 'distinct');



%%
% 3. Calcular a DCT 8×8 das imagens acima. Calcule a matriz de 
%    autocovariância dos blocos 8×8 do resultado (coeficientes). Compare 
%    com o obtido no item 2 e explique o comportamento.



%%
% 4. Idem para a DST 8×8 das imagens acima.
% Função para DST


%%
% 5. Supondo que os coeficientes retidos são os mostrados na figura 2, 
%    plotar o erro de restrição de base (equação da página 173 do livro texto)
%    versus j para a KLT, DCT e DST da imagem ZELDA S. Visualizar as imagens 
%    correspondentes para a DCT e a DST para j = 8, 4, 2 e 1.
%%
% 6. Repetir os items 1 e 2 só que agora calculando a KLT não separável dos 
%    blocos 8×8. O que você conclui do observado? Sugestão: mapeie cada 
%    bloco 8×8 para um vetor coluna de tamanho 64×64.




%%
%              V Quantização dos coeficientes das transformadas
%
% 1. Carregar a imagem BARB S e visualizá-la.
barb = imread("images\barb_s.tif");
imshow(barb);

%%
% 2. Calcule a sua DCT 8×8.

% Definir o tamanho dos blocos
blocos = 8;  

% Extrair blocos 8x8 da imagem
X_barb = im2col(barb, [blocos, blocos], 'distinct');

% Calcular a DCT para cada bloco
dct_blocks = dct2(X_barb);



%%
% 3. Observe os pixels da imagem original e da transformada para os dois 
%    blocos cujos elementos mais acima e mais à esquerda são (57,241) e 
%    (121,233). Faça a observação visualizando os pixels com imshow (só 
%    para a imagem original) e também observando os valores numéricos dos 
%    pixels. Identifique a que áreas da imagem original estes blocos 
%    correspondem e interprete o resultado.


% Identificar os blocos de interesse
% Coordenadas do primeiro bloco: (57, 241)
% Coordenadas do segundo bloco: (121, 233)

bloco1 = barb(57:64, 241:248); % Bloco 8x8 a partir de (57, 241)
bloco2 = barb(121:128, 233:240); % Bloco 8x8 a partir de (121, 233)

% Aplicar DCT aos blocos de interesse
dct_bloco1 = dct2(bloco1);
dct_bloco2 = dct2(bloco2);

% Visualizar os blocos originais e suas DCTs
figure;
subplot(2, 2, 1), imshow(bloco1, []), title('Bloco (57, 241) - Original');
subplot(2, 2, 2), imshow(dct_bloco1, []), title('Bloco (57, 241) - DCT');
subplot(2, 2, 3), imshow(bloco2, []), title('Bloco (121, 233) - Original');
subplot(2, 2, 4), imshow(dct_bloco2, []), title('Bloco (121, 233) - DCT');

% Mostrar valores numéricos dos pixels
disp('Valores dos pixels no Bloco (57, 241) - Original:');
disp(bloco1);

disp('Valores dos pixels no Bloco (57, 241) - DCT:');
disp(dct_bloco1);

disp('Valores dos pixels no Bloco (121, 233) - Original:');
disp(bloco2);

disp('Valores dos pixels no Bloco (121, 233) - DCT:');
disp(dct_bloco2);

%%
% 4. Zerar os coeficientes da DCT da imagem com valor absoluto menor que α. 
%    Para cada α ∈ {1/32, 1/16, 1/8, 1/4}:
%       a) Observar a DCT dos blocos definidos em 3.
%       b) Observar as imagens reconstruídas.



%%
% 5. Quantizar a DCT gerada em 2 usando o passo de quantização igual a β 
%    (sugestão: use fix(X/β)*β). Faça isto para β ∈ {1/32, 1/16, 1/8, 1/4}.
%       a) Observar a DCT dos blocos definidos em 3 para cada valor de β e 
%          comparar com o resultado de 4a.
%       b) Reconstruir a imagem para cada valor de β e comparar com o 
%          resultado de 4b.
%       c) O que você conclui do obtido em 5a e 5b?

