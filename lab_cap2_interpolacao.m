echo on;
%%
%                               I. Amostragem
% 1. Carregue a imagem ZELDA_S.TIF e a mostre na tela usando 256 níveis de cinza.
img = imread("zelda_s.tif");
% Mostrar a imagem em níveis de cinza
figure
imshow(img, [0 255]);
colormap(gray(256));

colorbar;
pause;
close(gcf);
%%
% 2. Subamostre a imagem de 2 em cada direção (isto é, retenha somente os 
% pixels com índice de linha e coluna ímpares) e a observe na tela. Obs.: 
% Usar sempre o comando truesize para que cada pixel da imagem corresponda 
% a um pixel na tela.
figure
img = imread("zelda_s.tif");
amostra_img = img(1:2:end, 1:2:end);
imshow(amostra_img, [0 255])
truesize

% Nesse caso, os pixels das linhas e colunas ímpares são subamostrados, o 
% que resulta na presença de ruído na imagem devido à perda de resolução. 
% Quando a subamostragem é feita, a imagem também perde seu tamanho 
% original, por isso é necessário ajustar o tamanho da imagem.
pause;
close(gcf);

%%
% 3. Subamostre de 4, 8, 16 e 32 em cada direção, mostrando na tela cada 
% uma das imagens restantes. Comente sobre o espectro de frequências de 
% uma imagem subamostrada.
img = imread("zelda_s.tif");
amostragem = [4, 8, 16, 32];
figure;
for i = 1:length(amostragem)
    amostra = amostragem(i);
    amostra_img = img(1:amostra:end, 1:amostra:end);
    % Mostrar a imagem subamostrada
    subplot(2, 2, i);
    imshow(amostra_img, [0 255]);
    title(['Subamostra por ', num2str(amostra)]);
end
% Ajustar o tamanho da figura para melhor visualização
set(gcf, 'Position', [100, 20, 1000, 500]);

% À medida que o fator de subamostragem aumenta, a imagem perde 
% progressivamente mais detalhes, e o aliasing se tornam mais pronunciados.
% Esto é porque a subamostragem é um processo de redução do número de 
% pixels em uma imagem.
pause;
close(gcf);

%%
% 4. Para cada uma das imagens geradas em I.2 e I.3, crie uma imagem de 
%  tamanho igual ao da original (M × N), repetindo o valor dos pixels. 
% Em outras palavras, no caso da imagem subamostrada por um fator R, 
% que possui dimesões M/R × N/R, substitua cada pixel de valor p por 
% uma matriz R×R com todos os elementos iguais a p, gerando desta forma uma
% imagem M × N. Mostrar as imagens resultantes com 256 níveis de cinza

img = imread("zelda_s.tif");
[M, N] = size(img);
amostragem = [2, 4, 8, 16, 32];
figure;
for i = 1:length(amostragem)
    R = amostragem(i);
    img_amostrada = img(1:R:end, 1:R:end);
    % Converter para double para usar kron corretamente
    img_amostrada = double(img_amostrada);
    % Expandir a imagem de volta ao tamanho original
    img_final = kron(img_amostrada, ones(M/R, M/R));
    % Exibir a imagem resultante
    subplot(3, 2, i);
    imshow(img_final, [0, 255]);
    title(['Imagem com subamostragem R = ', num2str(R)]);
end

% À medida que o fator de subamostragem aumenta, a imagem perde 
% progressivamente mais detalhes, e o aliasing se tornam mais pronunciados.
% A imagem gerada a partir das amostras perde muita resolução devido à 
% perda de informação obtida.
% La reconstrução da imagem também é menor devido às dimensões obtidas a 
% partir da subamostragem
pause;
close(gcf);

%% 
%                               II. Aliasing
% II.1 Geração de zoneplates


%  Gerar uma imagem cujos pixels possuem os seguintes valores 
% (sugestão: usar o comando meshgrid):
% $$I(x,y)= 0.5cos[(βpi)/(2M) (x^2 + y^2) + 0.5]$$
% onde -M/2 + 0.5 <= x, y <= M/2 - 0.5
% Uma imagen assim gerada se chama um "zoneplate", e é bastante usada na
% avaliação de sistemas de processamento de imagens.
% a) Fazer β = 1, M = 256 e dar o display da imagem (não esqueça do comando
% truesize).

betha = 1;
M = 256;
x = linspace(-M/2 + 0.5, M/2 - 0.5, M);
y = linspace(-M/2 + 0.5, M/2 - 0.5, M);
[X, Y] = meshgrid(x, y);
I = 0.5 * cos(betha * pi/(2 * M) * (x.^2 + Y.^2)) + 0.5;
figure
imshow(I)
truesize;
pause;
close(gcf);
%%
% b) Repetir o item anterior para β = 0.5 e β = 2. O que foi observado? O
% que pode ser dito a respeito do conteúdo de freqüência desta imagem? Qual
% e influência de β?

betha = [0.5, 2];
M = 256;
x = linspace(-M/2 + 0.5, M/2 - 0.5, M);
y = linspace(-M/2 + 0.5, M/2 - 0.5, M);
[X, Y] = meshgrid(x, y);
figure;
I1 = 0.5 * cos(betha(1) * pi/(2 * M) * (x.^2 + Y.^2)) + 0.5;
I2 = 0.5 * cos(betha(2) * pi/(2 * M) * (x.^2 + Y.^2)) + 0.5;
subplot(1, 2, 1)
imshow(I1)
title(['Zenoplate com β = ', num2str(betha(1))]);
subplot(1, 2, 2)
imshow(I2)
title(['Zenoplate com β = ', num2str(betha(2))]);
truesize;

% O que se pode observar em relação ao conteúdo com a variação de β é 
% que, à medida que β aumenta, a imagem se torna menor, permitindo 
% observar mais intervalos na frequência do zenoplate. Isso significa que 
% é possível ver as frequências mais altas contidas na imagem. E quando 
% β é pequeno, ocorre um zoom mais evidente no zenoplate, o que faz com
% que se possam observar apenas as frequências baixas da imagem.
pause;
close(gcf);

%%
% II.2 Observação de aliasing
% 1.  Subamostre um zoneplate para M = 256 e β = 1 de um fator 2 em cada 
% direção como no item I.2.
% a) Observe o zenoplate original e o subamostrado lado a lado. Use o
% comando truesize.

betha = 1;
M = 256;
x = linspace(-M/2 + 0.5, M/2 - 0.5, M);
y = linspace(-M/2 + 0.5, M/2 - 0.5, M);
[X, Y] = meshgrid(x, y);
I = 0.5 * cos(betha * pi/(2 * M) * (x.^2 + Y.^2)) + 0.5;
figure;
amostragem_I = I(1:2:end, 1:2:end);
subplot(1, 2, 1);
imshow(I);
title('Zenoplate Originai');
subplot(1, 2, 2);
imshow(amostragem_I);
title('Subamostra por un factor de 2');
truesize;

% Para um β = 1, é possível observar tanto as frequências baixas quanto as 
% altas. No entanto, quando é realizado um subamostragem por um fator de 2, 
% observa-se que, à medida que o zenoplate se eleva para altas frequências, 
% ocorre o aliasing. Isso significa que a reconstrução da imagem a partir 
% da original, com a subamostragem nas frequências mais baixas, não perde 
% muita informação. Contudo, à medida que as frequências são mais altas, 
% vai-se perdendo informação na imagem.
pause;
close(gcf);

%%
% b) A partir do zenoplate subamostrado crie uma imagem de tamanho 256 x 256
% seguindo um prodecimento semelhante ao de I.4. Amostre esta imagem lado a
% lado com o zenoplate original. Como pode ser explicado o observado?

% Definindo parâmetros para a imagem original
beta = 1;
M = 256;
x = linspace(-M/2 + 0.5, M/2 - 0.5, M);
y = linspace(-M/2 + 0.5, M/2 - 0.5, M);
[X, Y] = meshgrid(x, y);
I_original = 0.5 * cos(beta * pi / (2 * M) * (X.^2 + Y.^2)) + 0.5;


% Subamostrando a imagem
R = 2; % Fator de subamostragem
I_subamostrada = I_original(1:R:end, 1:R:end);

% Interpolação para o tamanho original (256x256) usando kron
scaleFactor = R;
repeatMatrix = ones(scaleFactor);
I_reconstruida_kron = kron(I_subamostrada, repeatMatrix);


figure;
subplot(1, 2, 1);
imshow(I_original, []);
title('Imagem Original');

subplot(1, 2, 2);
imshow(I_reconstruida_kron, []);
title('Imagem Reconstruída com kron');

% Quando observamos as imagens, notamos que a reconstrução da imagem a 
% partir da subamostragem perde mais detalhes. A subamostragem por 2 reduz 
% pela metade as linhas e colunas, resultando em uma imagem menor. Ao gerar 
% uma nova imagem com dimensões iguais à original, observamos que novos 
% padrões foram gerados na imagem, ou isso pode ser consequência de 
% amplificar os padrões gerados na imagem subamostrada, o que é observado 
% diretamente quando a frequência na imagem aumenta.
pause;
close(gcf);

%%
% 2. Usando a função remez, crie um filtro separável de tamanho 11 x 11,
% com sua freqüência de corte < pi/2 em cada direção. Sugestão:
%     * H1d = remez(10, F, A), com F = [0, 0.4, 0.5, 1] e A = [1, 1, 0, 0]
%       e faça H2d = H1d' * H1d.
% Filtre o zoneplate original com o filtro e mostre a imagem resultante 
% (sugestão: use a função filter2). Subamostre o resultado de 2, e aumente 
% o seu tamanho como em II.2.1b. Observe as imagens 256 × 256 assim geradas
% simultânemente com as geradas em II.2.1b. O que você conclui?

beta = 1;
M = 256;
x = linspace(-M/2 + 0.5, M/2 - 0.5, M);
y = linspace(-M/2 + 0.5, M/2 - 0.5, M);
[X, Y] = meshgrid(x, y);
I_original = 0.5 * cos(beta * pi / (2 * M) * (X.^2 + Y.^2)) + 0.5;


F = [0, 0.4, 0.5, 1];
A = [1, 1, 0, 0];

H1d = remez(10, F, A);
H2d = H1d' * H1d;

I_Filter = filter2(H2d, I_original);
I_Filter_Amos = I_Filter(1:2:end, 1:2:end);
I_Filter_redi = imresize(I_Filter_Amos, [M, M]);

figure;

subplot(1, 2, 1);
imshow(I_Filter, 'InitialMagnification', 'fit');
title('Zoneplate original com Filtragem');
axis on;

% Imagem filtrada, subamostrada e redimensionada
subplot(1, 2, 2);
imshow(I_Filter_redi, 'InitialMagnification', 'fit');
title('Zoneplate Filtrada, Subamostrada e Redimensionada');

% Após realizar a filtragem na imagem original e subamostrar em um 
% intervalo de 2, podemos observar que o filtro consegue minimizar o 
% aliasing, ou seja, ajuda a suavizar a imagem e reduzir o ruído 
% apresentado pelo processo de subamostragem. Observa-se que em altas 
% frequências não se gera o aliasing observado nos pontos anteriores 
% devido ao processo de amostragem. Observa-se que o filtro é passa-baixas, 
% pois atenua as altas frequências.
pause;
close(gcf);

%%
%                               III. Interpolação
% 1. Carregar a imagem lena_256.tif (Ver o documento Lendo e visualizando
% imagens no MATLAB. Subamostre a imagem de 2 em cada direção e mostre as 2
% imagens simultâneamente.

img = imread('lena_256.tif');
img_amostra = img(1:2:end, 1:2:end);
figure;
subplot(1, 2, 1);
imshow(img);
title('Imagem original');
subplot(1, 2, 2);
imshow(img_amostra);
title('Imagem amostrada');
pause;
close(gcf);
%%
% 2. A partir da imagem subamostrada, crie uma imagem com dimensões iguais
% às da original insirindo uma coluna de zeros à direita de cada coluna e
% uma linha de zeros abaixo de cada linha. Mostre a imagem. O que pode ser
% afirmado a respeito do espectro desta imagem? como ele pode ser
% relacionado com o espectro da imagem subamostrada?
img = imread('lena_256.tif');
img_amostra = img(1:2:end, 1:2:end);

% Interpolaçao pra gerar o tamanho original.
[M, N] = size(img);
I_zeros = zeros(M, N, 'uint8');
I_zeros(1:2:end, 1:2:end) = img_amostra;
% Exibir a imagem com zeros
figure;

subplot(1, 2, 1);
imshow(img);
title('Imagen Original');
subplot(1, 2, 2),
imshow(I_zeros);
title('Imagem com Zeros Inseridos');

% Pode-se observar que, ao adicionar as linhas e colunas de zeros no 
% processo de amostragem, perde-se a resolução nas altas frequências. Não 
% se consegue recuperar as altas frequências que se perdem na amostragem, 
% mas expande a escala do espectro de frequência, replicando as componentes
% de baixa frequência, a inserção de zeros preserve as baixas frequências 
% da imagem subamostrada
pause;
close(gcf);

%%
% 3. Crie 3 filtros bidimensionais de acordo com o siguinte procedimento:
% a) h0 = [0.5 0.5]
%    h1 = conv(h0, h0)
%    h2 = conv(h1, h1)
% b) hh0 = 4*h0'*h0
%    hh1 = 4*h1'*h1
%    hh2 = 4*h2'*h2
% Ao que equivale, na imagem, filtra-la com um filtro dado por expressões
% como as que geram hh0, hh1 e hh2 em III.3b? Porque o fator 4 em III.3b?

h0 = [0.5 0.5];
h1 = conv(h0, h0);
h2 = conv(h1, h1);
hh0 = 4 * (h0' * h0);
hh1 = 4 * (h1' * h1);
hh2 = 4 * (h2' * h2);

disp('Filtro hh0:');
disp(hh0);

disp('Filtro hh1:');
disp(hh1);

disp('Filtro hh2:');
disp(hh2);

pause;
close(gcf);

%%
% 4.  Observe a resposta em freqüência dos filtros unidimensionais gerados 
% em III.3a (sugestão: use freqz e plot). O que pode ser afirmado a 
% respeito delas?
h0 = [0.5 0.5];
h1 = conv(h0, h0);
h2 = conv(h1, h1);
hh0 = 4 * h0' * h0;
hh1 = 4 * h1' * h1;
hh2 = 4 * h2' * h2;

% Calcular a resposta em frequência usando freqz
[H0, W0] = freqz(h0, 1, 1024);
[H1, W1] = freqz(h1, 1, 1024);
[H2, W2] = freqz(h2, 1, 1024);

% Plotar a resposta em frequência
figure;
subplot(3,1,1);
plot(W0/pi, abs(H0));
title('Resposta em Frequência de h0');
xlabel('Frequência Normalizada (\times\pi rad/sample)');
ylabel('Magnitude');

subplot(3,1,2);
plot(W1/pi, abs(H1));
title('Resposta em Frequência de h1');
xlabel('Frequência Normalizada (\times\pi rad/sample)');
ylabel('Magnitude');

subplot(3,1,3);
plot(W2/pi, abs(H2));
title('Resposta em Frequência de h2');
xlabel('Frequência Normalizada (\times\pi rad/sample)');
ylabel('Magnitude');

% Todos os três filtros são do tipo passa-baixa, como evidenciado pela 
% magnitude decrescente em função da frequência crescente.
% Para o filtro h0 indica que o filtro passa mais as componentes de baixa 
% frequência e atenua gradualmente as componentes de frequência mais alta.
% Para o filtro h1 indica uma atenuação mais forte das frequências altas, 
% funcionando como um filtro passa-baixa mais acentuado que h0.
% Para o filtro h2  indica que o filtro h2 é o mais acentuado dos três, 
% atenuando significativamente as frequências altas e passando quase 
% exclusivamente as componentes de baixa frequência.
pause;
close(gcf);

%%
% 5. Observe a resposta em freqüência dos filtros bidimensionais gerados 
% em III.3b, bem como  a do filtro bidimensional gerado em II.2.2. 
% (sugestão: use freqz2).
h0 = [0.5 0.5];
h1 = conv(h0, h0);
h2 = conv(h1, h1);
hh0 = 4 * h0' * h0;
hh1 = 4 * h1' * h1;
hh2 = 4 * h2' * h2;

[Hhh0, Wxx0, Wyy0] = freqz2(hh0, 1024, 1024);
[Hhh1, Wxx1, Wyy1] = freqz2(hh1, 1024, 1024);
[Hhh2, Wxx2, Wyy2] = freqz2(hh2, 1024, 1024);


figure;
subplot(2,2,1);
mesh(Wxx0/pi, Wyy0/pi, abs(Hhh0));
title('Resposta em Frequência de hh0');
xlabel('Frequência Normalizada em X (\times\pi rad/sample)');
ylabel('Frequência Normalizada em Y (\times\pi rad/sample)');
zlabel('Magnitude');

subplot(2,2,2);
mesh(Wxx1/pi, Wyy1/pi, abs(Hhh1));
title('Resposta em Frequência de hh1');
xlabel('Frequência Normalizada em X (\times\pi rad/sample)');
ylabel('Frequência Normalizada em Y (\times\pi rad/sample)');
zlabel('Magnitude');

subplot(2,2,3);
mesh(Wxx2/pi, Wyy2/pi, abs(Hhh2));
title('Resposta em Frequência de hh2');
xlabel('Frequência Normalizada em X (\times\pi rad/sample)');
ylabel('Frequência Normalizada em Y (\times\pi rad/sample)');
zlabel('Magnitude');

% Observa-se em um mapa de cores as frequências que cada um dos filtros 
% deixa passar, concluindo que cada um tem uma atenuação diferente para as 
% altas frequências.
pause;
close(gcf);
%%
% 6. Filtre a imagem gerada em III.2 com cada um dos filtros gerados em 
% III.3b, e também com o filtro gerado em II.2.2. O que voce conclui? 
% Qual é o melhor interpolador? Explique isto no domínio da freqüência.

img = imread('lena_256.tif');
img_amostra = img(1:2:end, 1:2:end);

% Interpolaçao pra gerar o tamanho original.
[M, N] = size(img);
I_zeros = zeros(M, N, 'uint8');
I_zeros(1:2:end, 1:2:end) = img_amostra;

% filtros gerados em III.3b
h0 = [0.5 0.5];
h1 = conv(h0, h0);
h2 = conv(h1, h1);
hh0 = 4 * h0' * h0;
hh1 = 4 * h1' * h1;
hh2 = 4 * h2' * h2;

filteredImage_hh0 = filter2(hh0, I_zeros, 'same');
filteredImage_hh1 = filter2(hh1, I_zeros, 'same');
filteredImage_hh2 = filter2(hh2, I_zeros, 'same');

% filtro gerado em II.2.2

F = [0, 0.4, 0.5, 1];
A = [1, 1, 0, 0];
H1d = remez(10, F, A);
H2d = H1d' * H1d;
I_Filter = filter2(H2d, I_zeros);


% Imagem filtrada, subamostrada e redimensionada
subplot(2,2,1);
imshow(uint8(filteredImage_hh0));
title('Imagem Filtrada com hh0');

subplot(2,2,2);
imshow(uint8(filteredImage_hh1));
title('Imagem Filtrada com hh1');

subplot(2,2,3);
imshow(uint8(filteredImage_hh2));
title('Imagem Filtrada com hh2');

% Imagem filtrada, subamostrada e redimensionada
subplot(2, 2, 4);
imshow(uint8(I_Filter));
title('Imagem Filtrada, filtro gerado em II.2.2');

% Observa-se que os filtros gerados em III.3.b são melhores para suavizar a
% imagem com as linhas inseridas com zeros. O filtro passa-baixa consegue 
% melhorar consideravelmente a nitidez da imagem amostrada. No entanto, a 
% imagem filtrada com II.2.2 faz com que as baixas frequências ou as áreas 
% mais escuras da imagem sejam mais notáveis, o que resulta em uma 
% reconstrução inadequada da imagem. O filtro é mais agressivo ao remover 
% as altas frequências, o que faz com que se perca muito contraste.
pause;
close(gcf);

%%
% 7. Repetir III.6 para um zoneplate com M = 128 e β = 1.

betha = 1;
M = 128;
x = linspace(-M/2 + 0.5, M/2 - 0.5, M);
y = linspace(-M/2 + 0.5, M/2 - 0.5, M);
[X, Y] = meshgrid(x, y);
I = 0.5 * cos(betha * pi/(2 * M) * (x.^2 + Y.^2)) + 0.5;


% filtros gerados em III.3b
h0 = [0.5 0.5];
h1 = conv(h0, h0);
h2 = conv(h1, h1);
hh0 = 4 * h0' * h0;
hh1 = 4 * h1' * h1;
hh2 = 4 * h2' * h2;

filteredImage_hh0 = filter2(hh0, I, 'same');
filteredImage_hh1 = filter2(hh1, I, 'same');
filteredImage_hh2 = filter2(hh2, I, 'same');

% filtro gerado em II.2.2

F = [0, 0.4, 0.5, 1];
A = [1, 1, 0, 0];
H1d = remez(10, F, A);
H2d = H1d' * H1d;
I_Filter = filter2(H2d, I);


% Imagem filtrada, subamostrada e redimensionada
subplot(2,2,1);
imshow(uint8(filteredImage_hh0));
title('Imagem Filtrada com hh0');

subplot(2,2,2);
imshow(uint8(filteredImage_hh1));
title('Imagem Filtrada com hh1');

subplot(2,2,3);
imshow(uint8(filteredImage_hh2));
title('Imagem Filtrada com hh2');

% Imagem filtrada, subamostrada e redimensionada
subplot(2, 2, 4);
imshow(uint8(I_Filter));
title('Imagem Filtrada, filtro gerado em II.2.2');

% Nesse caso, nos filtros HH0, HH1, HH2, observa-se que é gerada uma 
% imagem escura, onde o padrão do zoneplate torna-se cada vez mais 
% irreconhecível, apresentando uma atenuação das altas frequências que 
% gera imagens mais escuras e menos detalhadas. Enquanto isso, o filtro 
% II.2.2. elimina totalmente as altas frequências, resultando em uma 
% imagem completamente preta.
pause;
close(gcf);



%%
echo off;