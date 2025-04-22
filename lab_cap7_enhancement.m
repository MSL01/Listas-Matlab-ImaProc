% PROCESSAMENTO DE IMAGENS
% Exercícios relativos ao Capítulo 7 – Image Enhancement
% Livro Texto: Fundamentals of Digital Image Processing. A. K. Jain.

%%
%                       I Operações pontuais
%
% 1. Operações de limiar (Thresholding): 
%    Para as imagens TEXT2, POLLENS, INSETO e HARDWARE, (supondo que a sua 
%    faixa dinâmica está entre 0 e 255), para β ∈ {50, 75, 100, 150, 200}, 
%    zerar os pixels menores que β e fazer os pixels maiores que β iguais a 
%    255 e observar o resultado.

% 2. Expansão de contraste: 
%    Fazer uma transformação de expansão de contraste na imagem HARDWARE 
%    (use um modelo linear de 2 partes – ver figura 7.2, pp. 235 no livro 
%    texto) de modo que as roscas dos parafusos fiquem visíveis e ao mesmo 
%    tempo não se perca nenhum detalhe da imagem.

% 3. Modelamento de histogramas: 
%    Observar a imagem original e seu histograma (use a função imhist). 
%    Em seguida, fazer a equalização de histograma e observar a imagem 
%    resultante bem como o seu histograma. Execute este processo para as 
%    imagens XRAY, BACTERIA2, GALAXY e HARDWARE. Compare o resultado obtido 
%    para a imagem HARDWARE com o obtido em I.2. Explique o resultado, 
%    comentando sobre em que casos o processo de equalização de histogramas 
%    funciona melhor ou pior que a transformação de expansão de contraste.

%%
%                           II Operações espaciais

% 1. Filtragem de ruído: 
%    A partir das imagens ZELDA S e XRAY, fazer o seguinte:
%       a) Somar ruído gaussiano com variância igual a 0.003 e média igual 
%          a zero (sugestão: use a função imnoise).
%       b) Filtrar tanto a imagem original como a com ruído adicionado 
%          usando cada um dos filtros f1, f2 e f3 definidos abaixo:
%               f1 = [1/9, 1/9, 1/9; 1/9, 1/9, 1/9; 1/9, 1/9, 1/9];
%               f2 = (4/3) * [0, 1/8, 0; 1/8, 1/4, 1/8; 0, 1/8, 0];
%               h = conv([1/2, 1/2], [1/2, 1/2]);
%               f3 = conv(h, h)' * conv(h, h);
%          Observar as imagens antes e depois da filtragem.
%       c) Repetir os itens 1a e 1b para ruído gaussiano de média zero e 
%          variância 0.01.

% 2. Filtragem por medianas: 
%    A partir das imagens ZELDA S e XRAY, fazer o seguinte:
%       a) Somar ruído binário às imagens acima (sugestão: use a função 
%          imnoise com a opção 'salt & pepper' com densidade igual a 0.05).
%       b) Filtrar as imagens originais, as com ruído binário e as com ruído 
%          gaussiano (geradas em 1a) usando cada um dos filtros f2 e f3 
%          definidos em 1b bem como o filtro por medianas usando uma janela 
%          3×3 (sugestão: use a função medfilt2).
%       c) Observe o resultado e indique qual o filtro que se aplica melhor 
%          a cada caso. Explique.

% 3. “Crispening”: 
%    Para cada uma das imagens ZELDA S, XRAY e BACTERIA1 CROP e INFLAMACAO, 
%    gerar a seguinte imagem: Z = X + λ(X − Y), onde X é a imagem original, 
%    Y é uma versão passa baixas de X e λ é uma constante. Y deve ser gerado 
%    com o filtro f1 definido em 1b, e λ deve tomar os valores 0.5, 1, 2, 4, 
%    8 e 16. Observar e comentar os resultados.

% 4. Filtragem passa-baixas, passa-altas e passa banda: 
%    sejam os pares de vetores (F1, A1), (F2, A2) e (F3, A3) descritos abaixo:
%           F1 = [0.0 0.4 0.6 1.0];
%           A1 = [ 1 1 0 0 ];
%           F2 = [0.0 0.4 0.6 1.0];
%           A2 = [ 0 0 1 1 ];
%           F3 = [0.0 0.2 0.3 0.7 0.8 1.0];
%           A3 = [ 1 1 0 0 1 1 ];
%    Usando a função remez(10, Fi, Ai), gerar para i = 1, 2, 3, filtros de 
%    1 dimensão com respostas ao impulso hi, i = 1, 2, 3, de comprimento 11. 
%    A partir destas respostas, gerar filtros bi-dimensionais aplicando hi 
%    às linhas e colunas das imagens. Plotar a resposta em frequência 
%    bi-dimensional de cada filtro e observar a imagem filtrada 
%    correspondente, para as imagens LENA256, BUILDING e HARDWARE.

% 5. Escalamento estatístico e mapeamento inverso de contraste: 
%    Carregar as imagens HARDWARE e BACTERIA2, e aplicar nela um filtro não 
%    linear da seguinte forma: substituir cada pixel x(m,n) da imagem por 
%    x(m,n)/σ(m,n), onde σ(m,n) é o desvio padrão do bloco 3×3 centrado 
%    no pixel x(m,n) (Sugestão: crie uma função que calcula a variância de  
%    uma matriz qualquer e use a função nlfilter). O que você observa?

%%
% III Operações no domínio das transformadas

% 1. Filtragem linear generalizada: 
%    Para as imagens ZELDA S e TEXT, repetir o item II.1a. Para cada uma das 
%    imagens resultantes, bem como para as originais, fazer o seguinte:
%       a) Achar a DCT da imagem inteira (usar dct2).
%       b) Zerar os coeficientes da DCT que não estejam acima e à esquerda 
%          da diagonal que une os elementos (1, k) a (k, 1), para k = 96 e 
%          k = 128.
%       c) Achar a DCT inversa (use idct2) e observar o resultado.
%    Em termos de qualidade de imagem, como este tipo de filtragem se 
%    compara à filtragem linear no domínio espacial (item II.4)? 
%    Explique porque. Sugira formas de minimizar os problemas que este tipo 
%    de filtragem apresenta.

% 2. Filtragem por raiz: 
%    Para as imagens ZELDA S, INSETO e POLLENS, fazer o seguinte:
%       a) Achar a transformada de Fourier bi-dimensional (use fft2).
%       b) Se o elemento y(m,n) da transformada de Fourier é da forma 
%          M(m,n)ejθ(m,n), gerar uma matriz cujos elementos são 
%          z(m,n) = (M(m,n))^α * ejθ(m,n), e achar a sua transformada 
%          inversa W.
%       c) Dar o display em W para α = 0, 0.5 e 0.7 (como as imagens 
%          resultantes podem não possuir a faixa dinâmica entre 0 e 1, 
%          podendo inclusive possuir elementos negativos, usar para dar o 
%          display nas imagens resultantes o comando imagesc(W + 0.5)). 
%    O que você pode concluir sobre o efeito do valor de α na imagem 
%    resultante?

% 3. Processamento homomórfico - Cepstrum: 
%    Para as imagens ZELDA S, INSETO e POLLENS, fazer o seguinte:
%       a) Achar a transformada de Fourier bi-dimensional (use fft2).
%       b) Se o elemento y(m,n) da transformada de Fourier é da forma 
%          M(m,n)ejθ(m,n), gerar uma matriz cujos elementos são 
%          z(m,n) = log(1 + M(m,n)) * ejθ(m,n), e achar a sua transformada 
%          inversa W.
%       c) Dar o display em W (como em 2c, usar para dar o display nas 
%          imagens resultantes o comando imagesc(W + 0.5)). 
%    O que você pode dizer a respeito da imagem resultante? W é chamado de 
%    “cepstrum” da imagem (anagrama de “spectrum”).

% 4. Pseudo-cor: 
%    Dar o display nas imagens XRAY, EOSINOFILO, BACTERIA1 CROP, POLLENS e 
%    GALAXY. Mostrar a “colorbar” junto (dar o comando colorbar logo após o 
%    imshow). Não converter a imagem para “grayscale”! 
%    Observe o efeito com os colormaps jet, hot, flag, prism, variando o 
%    número de níveis entre 10 e 256, à vontade. 
%    O que você pode concluir a respeito das vantagens e desvantagens do 
%    uso da pseudo-cor?
