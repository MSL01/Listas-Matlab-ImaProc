
echo on;
% Processamento digital de imagens
% Lista 4: Image Perception

%%
%                  I. Luz, luminância, brilho e contraste
% 1. Contraste simultâneo: Observe lado a lado as imagens geradas pelas
% siguintes matrizes:

X = [0 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 .5 .5 0 0;
     0 0 .5 .5 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0];

Y = [1 1 1 1 1 1;
     1 1 1 1 1 1;
     1 1 .5 .5 1 1;
     1 1 .5 .5 1 1;
     1 1 1 1 1 1;
     1 1 1 1 1 1];

% (usar o comando subplot). O que você observa? 

figure;
subplot(1, 2, 1);
imshow(X)
title('imshow para matriz X');
subplot(1, 2, 2);
imshow(Y)
title('imshow para matriz Y');

% Podemos observar que nas duas matrizes, embora tenham os mesmos
% valores em intensidade em relação à escala de cinzas, sob nossa
% percepção subjetiva do brilho que chega aos nossos olhos, observamos
% uma diferença na intensidade ou luminância do centro. Ao observar esta
% cor sob um contorno mais escuro, nossa resposta visual resultará em
% um centro que parece mais claro; efeito contrário ocorre quando
% observamos o centro sob níveis mais altos, ou seja, níveis de 1.
% Assim, ao fazer essa comparação visual com uma separação
% considerável entre os quadros, podemos observar uma diferença no
% brilho de cada centro, onde, se os valores estiverem mais próximos de 1,
% o contraste ou intensidade será mais escuro.

pause;
close(gcf);

%%
% Ajuste a valor dos 4 termos centrais da matriz Y de modo que os brilhos 
% dos 2 quadrados centrais pareçam iguais. Qual o novo valor dos termos 
% centrais? 

X = [0 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 .5 .5 0 0;
     0 0 .5 .5 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0];

Y = [1 1 1 1 1 1;
     1 1 1 1 1 1;
     1 1 .5 .5 1 1;
     1 1 .5 .5 1 1;
     1 1 1 1 1 1;
     1 1 1 1 1 1];
Y(3:4, 3:4) = 0.59;
figure;
subplot(1, 2, 1);
imshow(X)
title('imshow para matriz X');
subplot(1, 2, 2);
imshow(Y)
title('imshow para matriz Y (Ajustada)');

% Podemos observar na variação de contrastes nos brilhos que, sob uma 
% perspectiva visual, e embora inicialmente os valores dos dois quadros 
% centrais estejam sob o mesmo valor, o que indicaria que deveriam ser 
% iguais, a percepção visual mostra que o quadro central da matriz X 
% parece mais claro e o da matriz Y mais oscuro. Portanto, se aumentarmos 
% o valor do quadro central na matriz Y, vamos observar um aumento no 
% brilho. Dessa forma, observa-se que ao aumentar gradualmente os níveis 
% centrais de Y, podemos obter uma perspectiva visual em que ambos os 
% quadros parecem iguais. Aproximadamente, um valor de 0.58 ou até 0.60 
% pode dar a impressão de semelhança visual entre os dois quadros centrais 
% de ambas as matrizes.
% A razão é que nossa percepção é sensível ao contraste de luminância, e 
% não aos próprios valores absolutos de luminância.
pause;
close(gcf);

%%
% Executem também as funções 'checkershadow' e 'cont_sim2', disponíveis em 
% ftp://ftp.lps.ufrj.br/pub/profs/eduardo/matlabimages, verificando
% os valores dos pixels. Comente

% Checkershadow
X = imread('images\checkershadow.jpg'); 
imshow(X); 
impixelinfo; 
imtool(X);

% Na imagem mostrada, podemos observar um efeito de ilusão causado pela
% sombra na imagem, onde notamos dois pontos, A e B, e um cilindro que
% gera a perspectiva de sombra no ponto B. Se analisarmos
% detalhadamente os dados dos pixels na imagem, observamos que tanto o
% quadro do ponto A quanto o do ponto B contêm os mesmos valores. Ou seja,
% ambos os quadros são idênticos, embora a olho nu pareçam diferentes. Isso
% se deve à perspectiva que temos ao observar o mesmo quadro sob
% diferentes tipos de brilho ou intensidade luminosa, onde, se o observarmos
% sob uma gama mais escura, perceberemos que o quadro é muito mais claro,
% e sob a perspectiva de uma área com maior luminância, notamos que o
% quadro é muito mais escuro. O mesmo efeito ocorre no ponto anterior,
% e se conseguirmos juntar os quadros do ponto A e do ponto B, vamos
% observar diretamente que ambos têm a mesma intensidade.

pause;
close(gcf);
%%
% Cont_sim2
function cont_sim2
    % Exibe uma ilusão de contraste simultâneo.
    
    % Carrega as imagens
    X1 = imread('images\img1.bmp'); 
    X2 = imread('images\img2.bmp'); 
    X3 = imread('images\img3.bmp'); 
    
    % Ajusta a terceira imagem
    X3(:,151) = X3(:,150); 
    
    % Cria uma matriz de preenchimento
    A = uint8(255 * ones(252, 8)); 
    
    % Combina X2, A e X3
    X4 = [X2, A, X3]; 
    
    % Cria uma matriz de fundo branca
    X5 = uint8(255 * ones(303, 302)); 
    X5(1:252, 1:151) = X2; 
    X5(52:303, 152:302) = X3; 
    
    % Centraliza e exibe a primeira imagem
    Y1 = centra(X1, 352, 352, 355); 
    imshow(Y1); 
    impixelinfo; 
    disp('Pressione qualquer tecla para continuar...'); 
    pause; 
    
    % Exibe a segunda imagem combinada
    figure; 
    Y4 = centra(X4, 352, 352, 355); 
    imshow(Y4); 
    impixelinfo; 
    disp('Pressione qualquer tecla para continuar...'); 
    pause; 
    
    % Exibe a terceira imagem combinada
    figure; 
    Y5 = centra(X5, 352, 352, 355); 
    imshow(Y5); 
    impixelinfo; 
    disp('FIM');
end

function Y = centra(X, m, n, level)
    % Cria uma imagem Y que corresponde à imagem X centralizada em uma
    % imagem m x n com nível de cinza "level".
    % X deve ser do tipo uint8.
    
    % Verifica se X é uint8, caso contrário, converte
    if ~isa(X, 'uint8')
        X = uint8(X);
    end
    
    % Cria a nova imagem Y preenchida com o nível de cinza especificado
    Y = uint8(level * ones(m, n));
    
    % Obtém o tamanho da imagem original X
    [mm, nn] = size(X);
    
    % Verifica se a nova matriz é grande o suficiente para conter a imagem original
    if m < mm || n < nn
        error('A nova matriz deve ser maior ou igual à imagem original.');
    end
    
    % Calcula os deslocamentos necessários para centralizar X em Y
    deltam = floor((m - mm) / 2);
    deltan = floor((n - nn) / 2);
    
    % Insere a imagem X centralizada na nova imagem Y
    Y(1 + deltam : deltam + mm, 1 + deltan : deltan + nn) = X;
end
cont_sim2;

% Nesta imagem, podemos observar duas figuras compostas por duas formas
% sobrepostas em tons de cinza. A primeira figura que aparece nos
% mostra uma composição de dois semicírculos, nos quais, para cada
% semicírculo, seu 'background' tem diferentes tipos de tom. A união dos
% semicírculos nos dá a perspectiva visual de que ambos têm as mesmas
% características e, analisando os valores de intensidade para cada um,
% observa-se que cada semicírculo é composto pelos mesmos tons de cinza.
% Embora se obtenha uma fusão entre duas tonalidades diferentes
% (uma clara e outra mais escura), é possível determinar a olho nu a
% intensidade do aro.

% Na segunda imagem, podemos observar uma separação vertical, onde, sob
% nossa perspectiva visual, observamos uma pequena variação na
% intensidade do semi-aro, o mesmo fenômeno que ocorre no ponto anterior
% com as matrizes X e Y. Nesse caso, observamos na parte clara uma
% tonalidade mais escura na metade do aro, enquanto na outra metade se
% pode observar um tom mais claro.

% Na última figura, observamos uma consistência entre o 'background' de
% cada um dos semicírculos ou semi-aros, formando uma figura como
% resultado da união do aro com a forma circular em seu centro. Isso
% cria uma interação nos contrastes com as áreas mais claras e escuras,
% formando uma sobreposição das formas e criando uma transição suave
% nas tonalidades, o que faz com que a perspectiva visual entre os tons
% resulte em uma semelhança significativa nessa união.

pause;
close(gcf);
%%
% 2. Bandas de Mach:
%   a) Gerar uma matriz de X, de dimenções 256x256, composta de 7 barras
%      verticais de nível de cinza constante. Este nível de cinza aumenta com
%      passo constante à medida que nos deslocamos da esquerda para a dereita na
%      imagem. A barra mais da esquerda possui valor 0 e a mais da dereita
%      possui 1. Mostrar a imagem correspondente com 256 níveis de cinza. O que
%      você observa? Explique.
linhas = 256;
colunas = 256;
barras = 7;
dimen_barras = colunas / barras;

X = zeros(linhas, colunas);

for i=1:barras
    valor_cinza = (i-1) / (barras - 1);
    col_inicio = round((i - 1) * dimen_barras) + 1;
    col_fim = round(i * dimen_barras);
    X(:, col_inicio:col_fim) = valor_cinza;
end
figure;
imshow(X);

title('Imagem com 7 Barras Verticais de Nível de Cinza Constante');

% Na imagem, observamos o efeito das bandas de Mach, onde estamos
% percebendo uma variação ou uma interação espacial com o brilho da
% imagem. Embora a luminância seja constante, esse fenômeno faz com que
% nossa percepção visual note algumas variações na mudança de nível
% na imagem, de modo que se pode observar uma transição de uma parte mais escura
% para uma linha mais clara. Assim, observamos que quando uma barra está mais
% próxima de uma barra mais escura, notamos uma tonalidade mais clara, e 
% quando está mais próxima de uma barra mais clara, vamos perceber uma tonalidade mais
% escura, o que gera um brilho aparentemente não uniforme. Isso produz o
% que é conhecido como inibição lateral, onde sensores como cones e 
% bastonetes reduzem a resposta em partes vizinhas a um estímulo. Ou seja, 
% quando detectamos altos níveis de brilho, os sensores em nossos olhos que detectam 
% essas altas frequências inibem aqueles que detectam baixas frequências e 
% vice-versa, o que é modulado pela forma como nosso cérebro processa a 
% informação visual, buscando realçar os contrastes e bordas para destacar 
% objetos e detalhes em nosso ambiente.

pause;
close(gcf);

%%
%   b) Gere uma umagem I, de tamanho 128x128, cujas colunas possuem um valor
%      constante que decresce uniformemente de 164 até 141 à medida que se vai
%      da esquerda para a dereita da imagem. Gere uma outra imagem colocando a
%      imagem I ao lado dela mesma, e dê o display. O que você observa? Comente.
%      Sugestão: use o comando meshgrid.
M = 128;
[X, ~] = meshgrid(linspace(164, 141, M), 1:M);
I = X;
I_duplicated = [I, I];
figure;
imshow(I_duplicated, []);

% Nesta imagem, podemos observar dois retângulos com gradientes suaves de 
% brilho, indo do branco no extremo esquerdo ao preto no extremo direito. 
% Embora ambas as imagens apresentem gradientes similares e estejam lado a 
% lado, pode surgir uma ilusão óptica que faz com que os níveis de brilho 
% nos bordos internos pareçam diferentes. Esse fenômeno é causado pela forma
% como nosso sistema visual percebe os contrastes adjacentes.

% Na imagem, a figura da direita parece mais clara do que a da esquerda 
% devido ao contraste com suas áreas vizinhas. Esse fenômeno é conhecido 
% como bandas de Mach, e ocorre quando há uma transição suave de tons. Onde 
% há um limite entre áreas mais escuras e claras, o cérebro tende a exagerar 
% essa diferença, fazendo com que a área próxima à escuridão pareça mais 
% clara, e a área próxima à luz pareça mais escura.

% Portanto, no caso presente, a transição da esquerda tem um fundo mais 
% escuro em comparação à direita, causando a percepção de que a figura à 
% direita é mais clara, mesmo que os gradientes sejam os mesmos. Isso 
% demonstra como a inibição lateral e a percepção de contraste nas bordas 
% afetam nossa interpretação visual. A inibição lateral ocorre quando cones 
% e bastonetes nos olhos reduzem a resposta em áreas vizinhas a um estímulo 
% de brilho, resultando em uma modulação que realça contrastes e bordas.

% Esse efeito é modulado pela forma como nosso cérebro processa a informação 
% visual, buscando realçar os contrastes e bordas para destacar objetos e 
% detalhes no ambiente. Mesmo que as duas imagens sejam efetivamente iguais 
% em relação ao seu gradiente de brilho, o posicionamento lado a lado pode 
% levar o cérebro a interpretar incorretamente diferenças em brilho ou sombra, 
% ilustrando um fenômeno comum na percepção visual.

pause;
close(gcf);

%%
%   c) Gere uma imagem formada por uma seqüencia de quadrados, cada um de
%      nivel de cinza constante, um dentro do outro. À medida que seu tamanho
%      decresce, o seu nivel de cinza cresce. Os níveis de cinza deverão variar
%      de zero a 255, com passo 16. O comprimento do lado dos quadrados decresce
%      com passo 16. O que você observa? Interprete. Sugestão: use o comando
%      meshgrid.

tamanho = 255; 
pasos = 16; 
img = zeros(tamanho);
[X, Y] = meshgrid(1:tamanho, 1:tamanho);

for i = 1:pasos
    nivel_cinza = (i) * pasos; 
    inicio = 1 + (i) * pasos / 2;
    final = tamanho - (i) * pasos / 2;
    mask = (X >= inicio & X <= final) & (Y >= inicio & Y <= final);
    img(mask) = nivel_cinza;
end

figure;
imshow(uint8(img));
title('Sequência de Quadrados Concêntricos com Níveis de Cinza Crescentes');

% En este punto, observamos las siguientes caracteristicas en la imagen 
% generada:
%
%   i) La imagen es observada a través de dos monitores diferentes, en el
%   cual uno consigue detectar con mayor presición la profundidad entre la
%   gana de colores o niveles muy bajos de luminancia, esto permite
%   observar diferentes tonos oscuros, por lo cual, al tener una imagen de
%   tamanho 255 dividida en pasos de 16, nos da un aproximado de 16 cuadros
%   pero dada la transcición de colores, observamos 16 variaciones de tonos.
%   Sin embargo, al observar la figura en un monitor donde la gamma de
%   grises es más limitada, se va a observar una combinación entre los
%   tonos más oscuros formando un solo tono de negro, lo que hace que se
%   pierdan detalles o las sombas en la imagen no sean visibles, esto se
%   debe a la no linealidad de nuestros ojos y que cada monitor presenta su
%   propina no linealidad lo que genera que la perspectiva visual varie
%   dependiendo de las caracteristicas del monitor.
%
%   ii) Dependiendo de la perspectiva, el angulo o distancia de visualización 
%   de la imagen, podemos observar el mismo efecto en el cual las gamas de tonos
%   más oscuras se combinan, por lo cual observamos un area oscura mucho
%   más grande.
%
%   iii) La transición de tonos y el contraste visual, forman un efecto de
%   profundidad, en el que la parte más clara emerge de la parte más oscura
%   lo que se puede ver como una 'piramide' observada desde la parte de
%   arriba. Por lo cual, cuando se disminuye significativamente el tamano
%   de la imagen, podemos observar mejor este efecto, por lo que también
%   podemos observar mayores zonas de transición en las escalas de colores,
%   observando así más de los 16 cuadrados observados con la imagen tamano
%   normal. Esto genera una perspetiva visual de luz y sombra, donde las
%   diagonales de la 'piramide' formada también se pueden observar como en
%   un efecto de iluminación.
pause;
close(gcf);

%%
% 3. Função de transferência do sistema visual:
%   a) Gerar uma matriz X, M x M com o elemento x_{mn} da seguinte forma:
%      x_{mn} = 256^(-(M-m)/(M-1))cos[(M-1)βπ*((49β)^(-(M-n)/(M-1)))/(log(49β))]

% Se o monitor do seu computador for 800×600, faça M = 400. Se a resolução 
% do seu terminal for menor, faça M = 256. β é e um fator entre 0 e 1. 
% Faça-o igual a 0.6. Importante: certifique-se de que cada pixel da imagem 
% corresponde a um pixel da tela.

M = 400;
beta = 0.6;

X = zeros(M,M);
echo off;
for m=1:M
    for n=1:M
        a = (M-1);
        b = log(49*beta);
        c = -(M-m)/(M-1);
        d = -(M-n)/(M-1);
        X(m, n) = 256 ^ c * cos(a*beta*pi*((49*beta)^d)/(b)); 
    end
end
figure;
imshow(X);
echo on;
% A imagem gerada ilustra como atua a resposta em frequência dos nossos olhos.
% Observamos uma série de linhas aparentemente com a mesma amplitude e diferentes
% frequências, pelas quais, à medida que a frequência aumenta, começamos a perder
% a capacidade de distinguir as linhas e observamos uma variação em relação à
% amplitude delas. Nesse caso, a informação visual que chega ao nosso cérebro
% permite interpretar de maneira totalmente diferente as baixas e altas frequências
% na imagem. Portanto, podemos interpretar melhor as áreas onde as frequências são
% mais baixas, enquanto nas áreas com frequências mais altas, observamos uma perda
% nos detalhes. Isso evidencia a existência de um filtro passa-baixas em nossos
% olhos, devido à capacidade de perceber melhor as baixas frequências.

pause;
close(gcf);

%%
%   b) Olhe a imagem correspondente a uma distância de 2 metros do monitor. 
%      O que você observa? Varie a distância e faça outras observações.
%
% Quando observamos a imagem a diferentes distâncias, neste caso, a uma 
% distância aproximada de 2 metros, notamos que na zona onde se encontram 
% as frequências mais altas, a amplitude das linhas diminui consideravelmente, 
% resultando em uma área mais escura do que quando observamos a imagem de perto. 
% Isso indica que a capacidade de resposta dos nossos olhos permite a passagem 
% de apenas um intervalo específico de frequências, enquanto atenua as demais, 
% gerando uma perspectiva de tons de cinza mais uniforme e dificultando o 
% reconhecimento das barras. O olho humano, ao atuar como um filtro passa-banda, 
% está otimizado para perceber melhor um intervalo específico de frequências 
% espaciais. Fora desse intervalo, tanto as frequências muito baixas quanto as 
% muito altas são menos perceptíveis, o que afeta como vemos detalhes em uma imagem.

pause;
%%
%   c) Calcule a frequência horizontal instantânea (entre 0 e π) para n = 1 e
%      n = M. Quais os correspondentes em ciclos/grau para uma distância de 
%      observação igual a 20 vezes a altura da imagem?

M = 400;
beta = 0.6;
syms n;
phi_n = (M-1) * beta * pi * (49 * beta)^(-(M-n)/(M-1)) / log(49 * beta);

freq_instantanea = diff(phi_n, n);
freq_n1 = double(subs(freq_instantanea, n, 1));
freq_nM = double(subs(freq_instantanea, n, M));

H_img = M;
dist_obs = H_img * 20;
ciclos_por_grau_1 = freq_n1 * (180 / pi) / distancia_observacao;
ciclos_por_grau_M = freq_nM * (180 / pi) / distancia_observacao;
fprintf('Frequência instantânea em radianos para n = 1: %.4f rad\n', freq_n1);
fprintf('Frequência instantânea em radianos para n = M: %.4f rad\n', freq_nM);
fprintf('Frequência para n = 1 em ciclos/grau: %.4f ciclos/grau\n', ciclos_por_grau_1);
fprintf('Frequência para n = M em ciclos/grau: %.4f ciclos/grau\n', ciclos_por_grau_M);

%%
%   d) Com base no item anterior, explique o que você observou no item 3b.

%%
%   e) Faça β = 1 e repita o item 3b. Idem para β = 2. Explique o 
%      comportamento anômalo.

% Para β = 1 e β = 2 
M = 400;
beta = [1, 2];
X = zeros(M, M);
figure;
echo off;
for i=1:2
    for m=1:M
        for n=1:M
            a = (M-1);
            b = log(49*beta(i));
            c = -(M-m)/(M-1);
            d = -(M-n)/(M-1);
            X(m, n) = 256 ^ c * cos(a*beta(i)*pi*((49*beta(i))^d)/(b)); 
        end
    end
    subplot(1, 2, i)
    imshow(X);
    title(['Grafico para β = ', num2str(beta(i))]);
end
echo on
for i = 1:2
    syms n;
    phi_n = (M-1) * beta(i) * pi * (49 * beta(i))^(-(M-n)/(M-1)) / log(49 * beta(i));
    
    freq_instantanea = diff(phi_n, n);
    
    freq_n1 = double(subs(freq_instantanea, n, 1));
    freq_nM = double(subs(freq_instantanea, n, M));
    
    altura_imagem = M;
    distancia_observacao = 20 * altura_imagem;
    ciclos_por_grau_1 = freq_n1 * (180 / pi) / distancia_observacao;
    ciclos_por_grau_M = freq_nM * (180 / pi) / distancia_observacao;
    
    fprintf('Para β = %.1f:\n', beta(i));
    fprintf('Frequência instantânea em radianos para n = 1: %.4f rad\n', freq_n1);
    fprintf('Frequência instantânea em radianos para n = M: %.4f rad\n', freq_nM);
    fprintf('Frequência para n = 1 em ciclos/grau: %.4f ciclos/grau\n', ciclos_por_grau_1);
    fprintf('Frequência para n = M em ciclos/grau: %.4f ciclos/grau\n', ciclos_por_grau_M);
end


%%
% 4. Mascaramento: Gere uma matriz Z de acordo com o seguinte procedimento:

msize = 14;
fsize = 2*msize*msize;
A = ones(fsize, 1);
b0 = zeros(1, msize);
b1 = ones(1, msize);
B = kron(b1, [b0, b1]);
X = A*B/2;
c = zeros(1, fsize);
for i=1:msize
    c(2*msize*(i-1)+i) = 1;
end
y = 1:fsize;
z = exp(-(log(256)/(2.5*fsize))*(fsize-y));
Y = z'*c;
Z = X+Y;

% Mostre a matriz Z resultante com 256 níveis de cinza. Observe a imagem de
% diversas distâncias. O que você pode concluir do observado?

figure;
imshow(Z);

% Na matriz Z resultante, observamos uma imagem com um padrão de linhas 
% pretas e cinzas. No meio das linhas de cor cinza, podemos observar uma 
% linha branca; cada uma delas tem a mesma amplitude, ou seja, o tamanho de 
% cada linha é igual. Observa-se que, na parte inferior, a linha é de cor 
% branca e vai escurecendo em direção à parte superior. Nesse padrão, podemos 
% observar como as linhas mais próximas do cinza geram um efeito óptico em que 
% parece que sua amplitude ou tamanho diminui, de modo que, à medida que sua 
% intensidade diminui, elas se combinam com sua parte cinza adjacente, enquanto 
% as linhas mais centrais conseguem manter sua amplitude ou tamanho normal.

% Devido à pequena diferença entre os contrastes, à medida que observamos a 
% imagem a diferentes distâncias, podemos ver como os tamanhos ou amplitudes das 
% linhas brancas ou de frequência mais alta diminuem, resultando em um padrão 
% inicial mais baixo que cresce até o centro (esquerda - centro) e diminui do 
% centro até o fim da imagem (centro - direita). Isso se deve à mínima 
% diferença que podemos perceber entre as frequências de cada linha. Esse 
% estímulo e percepção geram uma diferença entre os padrões que é pouco 
% perceptível, criando esse efeito de redução no tamanho das linhas.

pause;
close(gcf);
%%                      II Imagens coloridas
% 1. Sistemas de Cor.
%   a) Gere uma imagem, de dimensões 401 × 401, representando as cores geradas 
%      por pares (B − Y, R − Y ), para um dado valor fixo de luminância Y. 
%      O par (0, 0) corresponde ao centro da imagem e a R = G = B = Y; a 1a
%      coluna da imagem corresponde a cores com B = Bmin, isto é, com o menor 
%      valor da componente azul B; a última coluna da imagem corresponde a cores 
%      com B = Bmax, isto é, com o maior valor de B; a 1a linha da imagem 
%      corresponde a cores com R = Rmin, isto é, com o menor valor da componente
%      vermelha R; a última linha da imagem corresponde a cores com R = Rmax, 
%      isto é, com o maior valor de R. Note que os valores de B−Y e R−Y devem 
%      ser proporcionais às suas coordenadas, e, desta forma, 
%      (Bmin − Y ) = −(Bmax − Y ) e (Rmin − Y ) = −(Rmax − Y ).
%      Observe a imagem para vários valores de luminância, isto é, para o pixel 
%      do centro da imagem sendo desde branco até cinza escuro. Note que, para 
%      cada valor de luminância, os valores de Bmin, Bmax, Rmin e Rmax devem ser 
%      ajustados para que os valores de R, G e B estejam sempre entre zero e um.
%      Dica: Y = 0.299R + 0.587G + 0.114B


dim = 401; 
Y_values = [1, 0.5, 0.25, 0.1]; 

figure;
echo off;
for idx = 1:length(Y_values)
    Y = Y_values(idx);
    
    img = zeros(dim, dim, 3);
    Bmin = -1 + Y;
    Bmax = 1 + Y;
    Rmin = -1 + Y;
    Rmax = 1 + Y;
    
    for i = 1:dim
        for j = 1:dim
            B = Bmin + (Bmax - Bmin) * (j - 1) / (dim - 1);
            R = Rmin + (Rmax - Rmin) * (i - 1) / (dim - 1);
            % Cálculo de G a partir de Y = 0.299R + 0.587G + 0.114B
            G = (Y - 0.299 * R - 0.114 * B) / 0.587;
            R = max(0, min(1, R));
            G = max(0, min(1, G));
            B = max(0, min(1, B));
            img(i, j, :) = [R, G, B];
        end
    end
    subplot(2, 2, idx);
    imshow(img);
    title(['Imagem para Y = ', num2str(Y)]);
end
echo on;
% Vamos realizar uma comparação para 4 valores diferentes de luminância
% Y = [1, 0.5, 0.25, 0.1]. Para o primeiro caso, com um valor de luminância
% igual a 1, observamos no centro da imagem a cor branca, e também se observa
% uma saturação nas cores formadas, tornando-as muito mais vivas. Para valores
% de luminância de 0 a 1, no caso máximo, observamos que há uma grande quantidade
% de luz presente na imagem, resultando em cores mais brilhantes e saturadas. 
% No entanto, a presença do branco indica uma perda na pureza da cor.
% Portanto, cores mais afastadas do branco podem apresentar uma saturação 
% mais moderada.

% À medida que há uma diminuição na luminância, o branco começa a se combinar 
% com a gama de cores, o que gera uma menor saturação devido à presença do branco.
% Em áreas mais próximas ao branco, a pureza da cor começa a se perder, tornando 
% as cores mais apagadas. Para valores de Y = [0.25, 0.1], observamos que 
% as cores se tornam mais apagadas e tendem ao preto.

pause;
close(gcf);
%%
% 2. Resposta do sistema visual à informação de cor: Para a imagem MANDRILL 
%    fazer o seguinte:

%       a) Carregá-la e visualizá-la
mandrill = imread('images\mandrill.tif');
figure;
imshow(mandrill);


%%
%       b) Transformá-la, ou de RGB para YIQ (usando o comando rgb2ntsc), 
%          ou para YCbCr (usando o comando rgb2ycbcr).

mandrillYQI = rgb2ntsc(mandrill);
mandrillYCbCr = rgb2ycbcr(mandrill);
figure;
subplot(1,2,1);
imshow(mandrillYQI);
title('RGB para YIQ');
subplot(1,2,2);
imshow(mandrillYCbCr);
title('RGB para YCbCr');
% YIQ:
% Para esta transformação, observamos uma forte presença das cores vermelha
% e verde. Considerando que há muitos cores na imagem original que apresentam 
% uma grande saturação, o espaço de cor YIQ lida com a informação de luminância 
% e crominância. O predomínio do vermelho pode ser devido à forma como o canal 
% I (in-phase) e Q (quadrature) codificam a informação de cor em YIQ, onde 
% certos tons são mais realçados do que outros.

% YCbCr:
% Para este tipo de formato, Y refere-se à luminância da imagem, enquanto 
% Cb e Cr são as diferenças de crominância das cores azul e vermelho. No caso 
% desta transformação, observamos uma maior variação nas cores da imagem, e 
% ela parece mais natural em comparação com a conversão YIQ. A distribuição 
% de cores em YCbCr tende a manter um melhor equilíbrio, refletindo como 
% percebemos o brilho e as cores, mantendo mais detalhes e uma melhor 
% percepção.
pause;
close(gcf);
%%
%       c) Gerar o filtro gaussiano com a seguinte resposta ao impulso:
%               h(m,n) = α*exp(-(m^2 + n^2)/2σ^2), -N ≤ m,n ≤ N
%          onde α é tal que h(m, n) não altera a média da imagem filtrada. 
%          Repita os passos a seguir para N = 9 e para σ^2 = 1, 10 e 100.
%           i) Filtre apenas a luminância da imagem (use a função filter2 
%              com a opção ’same’) e visualize o resultado (use imshow(RGB), 
%              onde RGB é um array tridimensional contendo R, G e B, isto é 
%              RGB(:,:,1)=R; RGB(:,:,2)=G; RGB(:,:,3)=B).
%           ii) Filtre apenas as crominâncias (ou I e Q ou Cb e Cr) e 
%               visualize o resultado (usando as funções ntsc2rgb ou ycbcr2rgb).
%    
%    Explique o fenômeno observado. Discuta também de que forma ele influencia 
%    o projeto de sistemas de visualização de imagens, como, por exemplo, a 
%    televisão.

N = 9;
sigma2_values = [1, 10, 100];

% Criar um plot com subplots
figure;
echo off;
for i = 1:length(sigma2_values)
    sigma2 = sigma2_values(i);
    sigma = sqrt(sigma2);
    [X, Y] = meshgrid(-N:N, -N:N);
    h = exp(-(X.^2 + Y.^2) / (2 * sigma^2));
    h = h / sum(h(:));  % Normalizar para não alterar a média da imagem
    
    % Filtrar a luminância (Y)
    mandrill_luminance = mandrillYCbCr(:,:,1);
    filtered_luminance = filter2(h, mandrill_luminance, 'same');
    
    % Reconstruir a imagem com luminância filtrada
    mandrillYCbCr_filtered = cat(3, filtered_luminance, mandrillYCbCr(:,:,2), mandrillYCbCr(:,:,3));
    mandrillYCbCr_filtered_rgb = ycbcr2rgb(mandrillYCbCr_filtered);
    
    % Mostrar a imagem com a luminância filtrada
    subplot(2, 3, i);
    imshow(mandrillYCbCr_filtered_rgb);
    title(['Luminância \sigma^2 = ', num2str(sigma2)]);
    
    % Filtrar as crominâncias (Cb e Cr)
    filtered_Cb = filter2(h, mandrillYCbCr(:,:,2), 'same');
    filtered_Cr = filter2(h, mandrillYCbCr(:,:,3), 'same');
    
    % Reconstruir a imagem com crominâncias filtradas
    mandrillYCbCr_filtered_chrom = cat(3, mandrillYCbCr(:,:,1), filtered_Cb, filtered_Cr);
    mandrillYCbCr_filtered_chrom_rgb = ycbcr2rgb(mandrillYCbCr_filtered_chrom);
    
    % Mostrar a imagem com as crominâncias filtradas
    subplot(2, 3, i + 3);
    imshow(mandrillYCbCr_filtered_chrom_rgb);
    title(['Crominâncias \sigma^2 = ', num2str(sigma2)]);
end
echo on;

% Análise dos Efeitos do Aumento da Luminância nas Imagens:
%
% 1. Luminância σ^2 = 1: Nesta imagem, todos os detalhes são claramente
%    visíveis. O brilho é moderado, permitindo uma boa percepção das cores 
%    e das texturas, mantendo a qualidade da imagem alta.
%
% 2. Luminância σ^2 = 10: Ao aumentar a luminância para este nível, há um 
%    aumento perceptível no brilho. Isso resulta em uma perda de qualidade, 
%    onde os detalhes da imagem começam a se desvanecer. Embora a resolução
%    aparente possa parecer maior devido ao aumento do brilho, a imagem 
%    perde nitidez e precisão.
%
% 3. Luminância σ^2 = 100: Com um valor tão alto de luminância, a imagem se 
%    torna ainda mais borrada e perde detalhes significativos. O brilho 
%    elevado causa uma saturação perceptível, o que resulta em uma menor 
%    qualidade visual. Este aumento de brilho também pode levar a um maior 
%    cansaço visual, uma vez que os olhos precisam se adaptar constantemente
%    aos contrastes exagerados e à falta de definição clara na imagem.
%
% O aumento da luminância em uma imagem, representado pelos valores crescentes 
% de σ^2, leva a um aumento no brilho, mas a um custo significativo de qualidade 
% visual. Detalhes importantes são perdidos e a imagem torna-se mais saturada 
% e borrada. Além disso, níveis muito altos de luminância podem causar desconforto 
% visual, pois os olhos precisam se adaptar aos altos contrastes, o que pode 
% ser cansativo e prejudicar a clareza de percepção. Portanto, é essencial 
% um equilíbrio adequado na luminância para preservar a qualidade da imagem 
% e o conforto visual.

% Análise dos Efeitos do Aumento da Crominância nas Imagens:
%
% 1. Crominância σ^2 = 1: Nesta imagem, as cores são bem equilibradas e os 
%    detalhes são claramente visíveis. A saturação é moderada, resultando 
%    em uma aparência natural, onde a percepção das cores e das texturas é 
%    mantida de forma clara.
%
% 2. Crominância σ^2 = 10: Com um aumento da crominância, há uma intensificação 
%    nas cores. As áreas coloridas da imagem, como o rosto do mandril, 
%    tornam-se mais saturadas. Isso aumenta a vivacidade, mas pode começar 
%    a reduzir a naturalidade, tornando a imagem visualmente mais intensa 
%    e, em alguns casos, exagerada.
%
% 3. Crominância σ^2 = 100: Neste nível de crominância, as cores estão 
%    extremamente saturadas. A imagem exibe cores muito vívidas, que podem 
%    parecer artificialmente exageradas. Essa super saturação pode levar à 
%    perda de detalhes finos e criar áreas onde as cores parecem se fundir, 
%    reduzindo a nitidez geral e aumentando o cansaço visual ao observar a 
%    imagem por longos períodos.
%
% Aumentar a crominância em uma imagem intensifica a saturação das cores, 
% tornando-as mais vívidas e, potencialmente, mais atraentes visualmente em 
% doses moderadas. No entanto, níveis excessivos de crominância, como visto 
% com σ^2 = 100, podem resultar em uma aparência artificial e perda de 
% qualidade visual devido à super saturação. Portanto, é importante encontrar 
% um equilíbrio para preservar a naturalidade das cores e a qualidade dos 
% detalhes na imagem, garantindo ao mesmo tempo uma experiência visual 
% confortável.

%%
% 3. Para cada uma das imagens CAPE, MANDRILL, CLOWN e TREES, com o auxílio 
%    dos comandos subplot e rgb2ycbcr, mostrar as matrizes de R, G e B 
%    juntamente com as de Y, Cb e Cr, como se cada uma fosse uma imagem em 
%    níveis de cinza (notar que os elementos de Cb e Cr podem assumir valores 
%    negativos). O que você conclui? Discuta as vantagens e desvantagens de 
%    cada representação. Faça o mesmo para as componentes Y, I e Q (use a 
%    função rgb2ntsc).

CAPE = imread('images\cape.tif');
MANDRILL = imread('images\mandrill.tif');
CLOWN = imread('images\clown.tif');
TREES = imread('images\trees.tif');

figure;
subplot(2, 2, 1);
imshow(CAPE);
subplot(2, 2, 2);
imshow(MANDRILL);
subplot(2, 2, 3);
imshow(CLOWN);
subplot(2, 2, 4);
imshow(TREES);
%------------------------ Para CAPE-----------------------------------
R_cape = CAPE(:,:,1);
G_cape = CAPE(:,:,2);
B_cape = CAPE(:,:,3);

YCbCr_Cape = rgb2ycbcr(CAPE);
Y_cape = YCbCr_Cape(:,:,1);
Cb_cape = YCbCr_Cape(:,:,2);
Cr_cape = YCbCr_Cape(:,:,3);

YIQ_Cape = rgb2ntsc(CAPE);
Yi_cape = YIQ_Cape(:,:,1);
I_cape = YIQ_Cape(:,:,2);
Q_cape = YIQ_Cape(:,:,3);



figure;
%----------RGB------------
subplot(3, 3, 1);
imshow(R_cape, []);
title('Para CAPE R');
subplot(3, 3, 2);
imshow(G_cape, []);
title('Para CAPE G');
subplot(3, 3, 3);
imshow(B_cape, []);
title('Para CAPE B');
%-------------YCbCr----------------
subplot(3, 3, 4);
imshow(Y_cape, []);
title('Para CAPE Y');
subplot(3, 3, 5);
imshow(Cb_cape, []);
title('Para CAPE Cb');
subplot(3, 3, 6);
imshow(Cr_cape, []);
title('Para CAPE Cr');
%-------------YIQ-----------------
subplot(3, 3, 7);
imshow(Yi_cape, []);
title('Para CAPE Y');
subplot(3, 3, 8);
imshow(I_cape, []);
title('Para CAPE I');
subplot(3, 3, 9);
imshow(Q_cape, []);
title('Para CAPE Q');


%--------------------Para MANDRILL ----------------------------------------
R_Mandrill = MANDRILL(:,:,1);
G_Mandrill = MANDRILL(:,:,2);
B_Mandrill = MANDRILL(:,:,3);

YCbCr_Mandrill = rgb2ycbcr(MANDRILL);
Y_Mandrill = YCbCr_Mandrill(:,:,1);
Cb_Mandrill = YCbCr_Mandrill(:,:,2);
Cr_Mandrill = YCbCr_Mandrill(:,:,3);

YIQ_Mandrill = rgb2ntsc(MANDRILL);
Yi_Mandrill = YIQ_Mandrill(:,:,1);
I_Mandrill = YIQ_Mandrill(:,:,2);
Q_Mandrill = YIQ_Mandrill(:,:,3);

figure;
%----------RGB------------
subplot(3, 3, 1);
imshow(R_Mandrill, []);
title('Para MANDRILL R');
subplot(3, 3, 2);
imshow(G_Mandrill, []);
title('Para MANDRILL G');
subplot(3, 3, 3);
imshow(B_Mandrill, []);
title('Para MANDRILL B');
%-------------YCbCr----------------
subplot(3, 3, 4);
imshow(Y_Mandrill, []);
title('Para MANDRILL Y');
subplot(3, 3, 5);
imshow(Cb_Mandrill, []);
title('Para MANDRILL Cb');
subplot(3, 3, 6);
imshow(Cr_Mandrill, []);
title('Para MANDRILL Cr');
%-------------YIQ-----------------
subplot(3, 3, 7);
imshow(Yi_Mandrill, []);
title('Para MANDRILL Y');
subplot(3, 3, 8);
imshow(I_Mandrill, []);
title('Para MANDRILL I');
subplot(3, 3, 9);
imshow(Q_Mandrill, []);
title('Para MANDRILL Q');

%----------------------Para CLOWN---------------------------------------
R_Clown = CLOWN(:,:,1);
G_Clown = CLOWN(:,:,2);
B_Clown = CLOWN(:,:,3);

YCbCr_Clown = rgb2ycbcr(CLOWN);
Y_Clown = YCbCr_Clown(:,:,1);
Cb_Clown = YCbCr_Clown(:,:,2);
Cr_Clown = YCbCr_Clown(:,:,3);

YIQ_Clown = rgb2ntsc(CLOWN);
Yi_Clown = YIQ_Clown(:,:,1);
I_Clown = YIQ_Clown(:,:,2);
Q_Clown = YIQ_Clown(:,:,3);

figure;
%----------RGB------------
subplot(3, 3, 1);
imshow(R_Clown, []);
title('Para CLOWN R');
subplot(3, 3, 2);
imshow(G_Clown, []);
title('Para CLOWN G');
subplot(3, 3, 3);
imshow(B_Clown, []);
title('Para CLOWN B');
%-------------YCbCr----------------
subplot(3, 3, 4);
imshow(Y_Clown, []);
title('Para CLOWN Y');
subplot(3, 3, 5);
imshow(Cb_Clown, []);
title('Para CLOWN Cb');
subplot(3, 3, 6);
imshow(Cr_Clown, []);
title('Para CLOWN Cr');
%-------------YIQ-----------------
subplot(3, 3, 7);
imshow(Yi_Clown, []);
title('Para CLOWN Y');
subplot(3, 3, 8);
imshow(I_Clown, []);
title('Para CLOWN I');
subplot(3, 3, 9);
imshow(Q_Clown, []);
title('Para CLOWN Q');

%-------------------------Para TREES--------------------------------------
R_Trees = TREES(:,:,1);
G_Trees = TREES(:,:,2);
B_Trees = TREES(:,:,3);

YCbCr_Trees = rgb2ycbcr(TREES);
Y_Trees = TREES(:,:,1);
Cb_Trees = TREES(:,:,2);
Cr_Trees = TREES(:,:,3);

YIQ_Trees = rgb2ntsc(TREES);
Yi_Trees = TREES(:,:,1);
I_Trees = TREES(:,:,2);
Q_Trees = TREES(:,:,3);

figure;
%----------RGB------------
subplot(3, 3, 1);
imshow(R_Trees, []);
title('Para TREES R');
subplot(3, 3, 2);
imshow(G_Trees, []);
title('Para TREES G');
subplot(3, 3, 3);
imshow(B_Trees, []);
title('Para TREES B');
%-------------YCbCr----------------
subplot(3, 3, 4);
imshow(Y_Trees, []);
title('Para TREES Y');
subplot(3, 3, 5);
imshow(Cb_Trees, []);
title('Para TREES Cb');
subplot(3, 3, 6);
imshow(Cr_Trees, []);
title('Para TREES Cr');
%-------------YIQ-----------------
subplot(3, 3, 7);
imshow(Yi_Trees, []);
title('Para TREES Y');
subplot(3, 3, 8);
imshow(I_Trees, []);
title('Para TREES I');
subplot(3, 3, 9);
imshow(Q_Trees, []);
title('Para TREES Q');

% Matrizes dos componentes RGB
%
% Vantagens: É uma das representações mais comuns, sendo o formato padrão 
% de cores. Cada canal representa uma cor (vermelho, verde e azul), o que é 
% fácil de visualizar e manipular.
% Desvantagens: Não é o ideal para processamentos como compressão ou análise 
% de características importantes, pois cada canal pode conter muita 
% redundância de informação.

% Matrizes dos componentes YCbCr
%
% Representação Y
% Vantagens: Separa a informação de luminosidade da informação de cor, o 
% que permite maior eficiência em compressão de imagens. Também facilita
% a manipulação de brilho sem alterar as cores.
% Desvantagens: Pode ser mais complicado para processar diretamente, pois 
% exige conversão de e para o espaço de cores RGB.
%
% Representação Cb e Cr
% Vantagens: Utilizadas em formatos de compressão de vídeo e imagem, esses 
% canais contêm informações de cor e permitem uma compressão mais eficiente, 
% já que o olho humano é menos sensível à cor do que à luminosidade.
% Desvantagens: Sem o canal de luminância (Y), as informações de cor podem 
% não ser intuitivas, tornando difícil a visualização direta da imagem.
%
% Matrizes dos componentes YIQ
%
% Vantagens: O espaço de cores YIQ, utilizado em transmissões de TV NTSC, 
% foi projetado para maximizar a percepção humana de luminância (Y) e 
% minimizar a importância de crominância (I e Q). Isso permite compressão 
% eficiente em sistemas de transmissão.
% Desvantagens: A visualização direta dos canais I e Q pode ser confusa, 
% já que são menos intuitivos que os canais RGB.


pause;

echo off;

