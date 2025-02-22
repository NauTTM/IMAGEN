%%
% ////////////////////// EJERCICIO 1 ///////////////////////

% Cargamos la imagen y la pasamos a HSV
I = im2double(imread('peppers.png'));
I_hsv = rgb2hsv(I);

% Desaturamos la imagen 
factor_desaturacion = 0.4; % Variamos entre 0.4 y 0.6
I_hsv(:,:,2) = I_hsv(:,:,2) * factor_desaturacion;
I_desaturada = hsv2rgb(I_hsv);

% Imagen desaturada
figure;
imshow(I_desaturada);
title('Imagen desaturada 40%');
%%
% ////////////////////// EJERCICIO 2 ///////////////////////

% Aplicamos un tono cálido
factor_R = 1.2; % Incrementamos el rojo 20%
factor_G = 1.1; % Incrementamos el verde 10%
factor_B = 0.8; % Reducimos el azul 20%
I_calida = I_desaturada;
I_calida(:,:,1) = I_calida(:,:,1) * factor_R;
I_calida(:,:,2) = I_calida(:,:,2) * factor_G;
I_calida(:,:,3) = I_calida(:,:,3) * factor_B;
I_calida = min(I_calida, 1); % Limitar 

% Imagen cálida
figure;
imshow(I_calida);
title('Imagen con tono cálido');
%%
% ////////////////////// EJERCICIO 3 ///////////////////////

% Añadimos ruido Gaussiano
I_ruido = imnoise(I_calida, 'gaussian', 0.05);

% Imagen con ruido
figure;
imshow(I_ruido);
title('Imagen con ruido');
%%
% ////////////////////// EJERCICIO 4 ///////////////////////

% Marcara del destello
[m, n, ~] = size(I);
Cx = round(n*0.90);
Cy = round(m*0.15);
r = min(m, n) / 4;
[x, y] = meshgrid(1:n, 1:m);
mascara = 0.5 * exp(-((x - Cx).^2 + (y - Cy).^2) / (2 * r^2));

% Mascara del destello
figure;
imshow(mascara, []);
title('Mascara para el efecto destello');
%%
% ////////////////////// EJERCICIO 5 ///////////////////////

% Añadimos la máscara a la imagen con ruido gaussiano
I_destello = I_ruido + repmat(mascara, [1, 1, 3]);
I_destello = min(I_destello, 1); % Limitar a [0, 1]

% Imagen con destello
figure;
imshow(I_destello);
title('Imagen con efecto destello');
%%
% ////////////////////// EJERCICIO 6 ///////////////////////

% Aumentamos el brillo 
factor_brillo = 1.1; % Modificamos este parametro ente 1.1 y 1.2
I_brillo = rgb2hsv(I_destello);
I_hsv(:,:,3) = I_hsv(:,:,3) * factor_brillo;
I_brillo = hsv2rgb(I_brillo);
I_brillo = min(I_brillo, 1); % Limitamos

% Imagen con factor de brillo subido
figure;
imshow(I_brillo);
title('Imagen con mas brillo 10%');
%%
% ////////////////////// EJERCICIO 7 ///////////////////////
% Corrección de gamma con imadjust
factor_gamma = 1.1;
I_gamma = imadjust(I_brillo, [], [], factor_gamma);

% Imagen con corrección gamma
figure;
imshow(I_gamma);
title('Imagen con corrección gamma 10%');
%%
% ////////////////////// EJERCICIO 8 ///////////////////////

% Realzamos los bordes 
I_bordes = imsharpen(I_ruido, 'Radius', 2, 'Amount', 1.5);

% Aplicamos brillo y gamma 
I_final = imadjust(I_bordes * factor_brillo, [], [], factor_gamma);

% Imagen final
figure;
imshow(I_final);
title('Imagen final con realce de bordes, brillo y gamma');