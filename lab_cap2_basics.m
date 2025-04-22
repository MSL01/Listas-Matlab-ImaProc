echo on;
% COE784: Processamento Digital de Imagens
% Lista: Lab_cap2_basics
% Aluno: Miguel Angel Saavedra Lozano
% Professor: Eduardo Antonio Barros Da Silva
% 

%%
% Fazer o exercício 2.5, pag. 45 do livro, usando a função conv2. Usar tambem o comando
% spy para observar as regiões de suporte do filtro, do sinal e do sinal filtrado

% Define x(m, n)
x = [1 4 1; 2 5 3];
hi = [0 -1 1; -1 4 -1; 0 -1 0];
hii = [1 2 3];
hiii = [-2; 3; -1];
yi = conv2(x, hi, 'full');
yii = conv2(x, hii, 'full');
yiii = conv2(x, hiii, 'full');
spy(yi)
pause;
spy(yii)
pause;
spy(yiii)
% Fecha a figura ao final do ciclo
close(gcf);

%%
% Idem para o sinal x(m, n) representado pela matriz X e h(m, n) representado pela matriz h

X = [0 0 0 0 0 0 0; 
     1 1 1 1 0 0 0; 
     0 1 1 1 1 0 0; 
     0 0 1 1 1 1 0; 
     0 0 0 0 0 0 0];

h = [0 1 0 0 0;
     0 1 0 0 0;
     0 1 1 0 0;
     0 1 1 0 0;
     0 1 1 0 0;
     0 1 1 1 0;
     0 0 0 0 0];

Y = conv2(X, h);
spy(Y)
pause;
close(gcf);

%%
% Gere imagens senoidais de dimensões 256x556 usando a siguinte expressão:


% Definindo os parâmetros de a sinai:

d = [256, 150, 64*sqrt(2), 64, 25, 16*sqrt(2), 10, 4, 2, 1, 32, 32*sqrt(2), 16, 4];
theta = [0, 0, 0, 0, 90, 90, 90, 90, 90, 90, 45, 45, 30, 70];

% Definindo dimenssões 256x256
[m, n] = meshgrid(0:255, 0:255);

figure;
% Gerando a imagen
for i = 1:length(d)
    g = 0.5 + 0.5 * cos(2 * pi / d(i) * (m * cos(theta(i)) + n * sin(theta(i))));

    % Plotando a Imagen
    subplot(2, 1, 1);
    imshow(g, [])
    subplot(2, 1, 2);
    mesh(g)
    %colormap("gray")
    title(['d = ', num2str(d(i)), ', theta = ', num2str(theta(i))]);
    pause; 
end
% Fecha a figura ao final do ciclo
close(gcf);

% Nos resultados observamos as variações de d e theta, dentro disso,
% observamos que à medida que o valor de d diminui, a frequência do sinal
% aumenta; portanto, mais oscilações são observadas.
% Por outro lado, quando o valor de d aumenta, a oscilação do sinal é mais
% lenta, de modo que se pode assumir que d é o período espacial da
% senoide e define a velocidade com que o sinal oscila. O ângulo theta
% define a direção da senoide, de modo que se pode observar uma inclinação
% em graus no gráfico.
% Se observarmos a senoide de cima, podemos ver a representação da
% imagem gerada na parte superior. Para valores de d baixos, também se
% pode observar que é um sinal periódico.


%% 
% Plote (como uma imagem em níveis de cinza) a transformada de Fourier (DFT) de cada
% imagem do exemplo anterior. Comente sobre o significado de θ e d. Comente sobre o
% efeito da relação entre θ e d na DFT das imagens. O que acontece quando d = 1 e d = 2?
% Explique. Sugestão: use os comandos fft2 e fftshift. Se houver problemas com a faixa
% dinâmica plote o logaritmo do módulo da transformada de Fourier somado com 1.

% Definindo os parâmetros de a sinai:

d = [256, 150, 64*sqrt(2), 64, 25, 16*sqrt(2), 10, 4, 2, 1, 32, 32*sqrt(2), 16, 4];
theta = [0, 0, 0, 0, 90, 90, 90, 90, 90, 90, 45, 45, 30, 70];
% Definindo dimenssões 256x256
[m, n] = meshgrid(0:255, 0:255);

figure;
% Gerando a imagen
for i = 1:length(d)
    g = 0.5 + 0.5 * cos(2 * pi / d(i) * (m * cos(theta(i)) + n * sin(theta(i))));
    % Calcular a Transformada de Fourier
    F = fft2(g);
    F_2 = abs(fftshift(F));
    
    % Adicionar 1 ao módulo para evitar log(0)
    F_2 = F_2 + 1;
    
    % Calcular o logaritmo do módulo
    log_F_2 = log(F_2);
    % Plotando a Imagen
    imshow(log_F_2)
    title(['d = ', num2str(d(i)), ', theta = ', num2str(theta(i))]);
    pause; 
end
% Fecha a figura ao final do ciclo
close(gcf);


% A transformada de Fourier nos permite observar as frequências altas e 
% baixas na imagem, neste caso, quando d = 1 significa que atinge sua 
% máxima frequência espacial na imagem. Portanto, quando temos valores de 
% frequência altos, vamos observar picos mais brilhantes, esses indicam os 
% componentes de frequência mais fortes. Quando os valores de d são altos, 
% indica uma menor velocidade na frequência, por isso, quanto maior o valor 
% observamos apenas pontos ou componentes de frequência mais fracos. O valor 
% de theta indica que a senoide oscila na direção vertical.                 
% Quando o valor de theta é 0, a senoide oscila de forma horizontal, por
% isso observa-se uma linha reta ou alguns pontos no eixo horizontal ou 
% eixo m. Quando d é muito grande, observa-se uma oscilação suave. À 
% medida que d diminui, sem alterar o ângulo theta, observa-se uma 
% representação com pontos no eixo horizontal.
% As variações na intensidade do brilho da imagem são devidas a um
% aumento da frequência e uma variação no ângulo theta. Ou seja, à medida
% que o sinal se desloca no eixo vertical, observam-se componentes com
% frequências mais fortes.



%%
%  De acordo com o exemplo 2.2, pp. 22 do livro texto, plotar no intervalo ([-2,2],[-2,2]) a
% resposta ao impulso h(x, y), para x0 = y0 = 0 usando uma matriz de 50×50. Sugestão:
% usar as funções mesh e meshgrid.

x0 = 0;
y0 = 0;
N = 50;

x = linspace(-2, 2, N);
y = linspace(-2, 2, N);
[X, Y] = meshgrid(x, y);

% Calculando a resposta ao impulso h(x, y)
h = 2 * (sin(pi * (X - x0)).^2 ./ (pi * (X - x0)).^2) .* (sin(pi * (Y - y0)).^2 ./ (pi * (Y - y0)).^2);
% Plotando a resposta ao impulso
figure;
mesh(X, Y, h);
xlabel('x');
ylabel('y');
zlabel('h(x, y)');
title('Resposta ao Impulso h(x, y)');
pause;
close(gcf);
%%
% Plotar a transformada de Fourier do exemplo anterior. Sugestão: usar as funções fft,
% fftshift e mesh.

x0 = 0;
y0 = 0;
N = 50;

x = linspace(-2, 2, N);
y = linspace(-2, 2, N);
[X, Y] = meshgrid(x, y);

% Calculando a resposta ao impulso h(x, y)
h = 2 * (sin(pi * (X - x0)).^2 ./ (pi * (X - x0)).^2) .* (sin(pi * (Y - y0)).^2 ./ (pi * (Y - y0)).^2);
% Plotando a resposta ao impulso
figure;
F = fft2(h);
F_2 = abs(fftshift(F));
    
% Adicionar 1 ao módulo para evitar log(0)
F_2 = F_2 + 1;
    
% Calcular o logaritmo do módulo
log_F_2 = log(F_2);
% Plotando a Imagen
imshow(log_F_2)
pause;
close(gcf);
%%

% Carregue a imagem zelda_s.tif. Mostre a imagem e o logaritmo do módulo 
% da transformada de Fourier somado com um (como uma imagem em níveis de 
% cinza). Interprete a transformada de Fourier. Repita o exemplo para a 
% imagem text2.


% Carregar a imagem
img = imread('zelda.tif'); 
img2 = imread('text2.tif'); 

% Calcular a Transformada de Fourier
F = abs(fftshift(fft2(double(img))));
F2 = abs(fftshift(fft2(double(img2))));

% Adicionar 1 ao módulo para evitar log(0)
% Calcular o logaritmo do módulo 
log_F_magnitude = log(F + 1);
log_F2_magnitude = log(F2 + 1);


% Mostrar a imagem original
figure;
set(gcf, 'Position', [50, 50, 1100, 600]);
subplot(2,2,1);
imshow(img_gray, []);
title('Imagem Original em Escala de Cinza');

% Mostrar o logaritmo do módulo da Transformada de Fourier
subplot(2,2,2);
imshow(log_F_magnitude, []);
title('Log do Módulo da Transformada de Fourier');

subplot(2,2,3);
imshow(img2_gray, []);
title('Imagem Original em Escala de Cinza');

% Mostrar o logaritmo do módulo da Transformada de Fourier
subplot(2,2,4);
imshow(log_F2_magnitude, []);
title('Log do Módulo da Transformada de Fourier');

% Ajustar a escala para visualização
colormap('gray');
colorbar;

% Quando você tenta calcular a transformação furier, nada aparece,
% então nenhuma influência das outras frequências é vista. Para
% que é o log calculado para que as diferenças nas intenções sejam
% atenuadas.

% Imagem 'zelda.tif': Esta imagem pode ter mais áreas suaves com menos 
% detalhes finos, resultando em uma Transformada de Fourier com componentes 
% de baixa frequência mais proeminentes (centro mais escuro) e menos 
% componentes de alta frequência.

% Imagem 'text2.tif': Esta imagem pode ter mais detalhes finos e padrões 
% repetitivos, resultando em uma Transformada de Fourier com mais 
% componentes de alta frequência (bordas mais claras) e um espectro de 
% frequência mais variado.

pause;
close(gcf);

echo off;