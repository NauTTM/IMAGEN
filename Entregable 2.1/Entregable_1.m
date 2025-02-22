%///////////////EJERCICIO 1///////////////////////////

M=256;N=256; %M filas N columnas
r=32; %Radio pequeño
R=128; %Radio grande
center=M/2; %Calculamos el pixel que estara en el centro

cuadro_negro = zeros(M, N); %Imagen negra entera


[x, y] = meshgrid(1:M, 1:N); %Creamos las matrices del plano con las que nos basaremos para medir la distancia del centro
circ=(x - center).^2 + (y - center).^2;%Calculamos la ecucación de la circunferencia para cada (x,y) 
mask = (circ <= R^2) & (circ >= r^2); %Creamos  la mascara para los valores que se incluyen dentro de la corona que valdra 1 cuando se cumpla la condición lógica

figure;

subplot(5, 2, 1);  
imshow(cuadro_negro);
title('Recuadro negro');


subplot(5, 2, 2);  
imshow(mask);
title('Solución 1');

%////////////////EJERCICIO 2///////////////////////////

M=256;N=256; %M filas N columnas


h = linspace(1, 0, M);  % Variación del color (H) de 0 a 1
H = toeplitz(h);  % Matriz de Toeplitz que varía el color

% Ajustar la matriz para que la variación del tinte sea uniforme

S = ones(M, N);  % S constante
V = ones(M, N);  % L constante


Ic = zeros(M, N, 3);  % Inicializar matriz para la imagen HSV
Ic(:,:,1) = H;  % Asignar el canal H
Ic(:,:,2) = S;  % Asignar el canal S
Ic(:,:,3) = V;  % Asignar el canal L


Irgb = hsv2rgb(Ic);% Convertir la imagen de HSV a RGB

% Mostrar la imagen
subplot(5, 2, 3);
imshow(Irgb);
title('Solucion 2');

%////////////////EJERCICIO 3///////////////////////////

M=256;N=256; %M filas N columnas


h = linspace(1, 0, M);  % Variación del color (H) de 0 a 1
H = toeplitz(h);  % Matriz de Toeplitz que varía el color

s = linspace(0.5, 1, M);  % Variación de la saturación (S) de 0.5 a 1s
S = toeplitz(s);  % Matriz de Toeplitz que varía el color

V = ones(M, N);  % L constante


Ic = zeros(M, N, 3);  % Inicializar matriz para la imagen HSV
Ic(:,:,1) = H;  % Asignar el canal H
Ic(:,:,2) = S;  % Asignar el canal S
Ic(:,:,3) = V;  % Asignar el canal L


Irgb = hsv2rgb(Ic);% Convertir la imagen de HSV a RGB

% Mostrar la imagen
subplot(5, 2, 4);
imshow(Irgb);
title('Solucion 3');

%////////////////EJERCICIO 4///////////////////////////

M=256;N=256; %M filas N columnas


h = linspace(1, 0, M);  % Variación del color (H) de 0 a 1
H = toeplitz(h);  % Matriz de Toeplitz que varía el color

s = linspace(0.5, 1, M);  % Variación de la saturación (S) de 0 a 0.5
S = toeplitz(s);  % Matriz de Toeplitz que varía el color

V = ones(M, N);  % L constante


Ic = zeros(M, N, 3);  % Inicializar matriz para la imagen HSV
Ic(:,:,1) = H;  % Asignar el canal H
Ic(:,:,2) = S;  % Asignar el canal S
Ic(:,:,3) = V;  % Asignar el canal L


Irgb = hsv2rgb(Ic);% Convertir la imagen de HSV a RGB

% Cuantificación de la imagen a 8 colores con dithering
[Iind_dither, map_dither] = rgb2ind(Irgb, 8, 'dither');

% Cuantificación de la imagen a 3 colores sin dithering
[Iind_nodither, map_nodither] = rgb2ind(Irgb, 3, 'nodither');


% Mostrar la imagen cuantificada con dithering
subplot(5, 2, 6);
imshow(Iind_dither, map_dither);  % Es importante usar el mapa de colores
title('Solucion 3 con Dithering');

% Mostrar la imagen cuantificada sin dithering
subplot(5, 2, 5);
imshow(Iind_nodither, map_nodither);  % Es importante usar el mapa de colores
title('Solucion 3 sin Dithering');

%////////////////EJERCICIO 5///////////////////////////

M=256;N=256; %M filas N columnas


h = linspace(1, 0, M);  % Variación del color (H) de 0 a 1
H = toeplitz(h);  % Matriz de Toeplitz que varía el color

s = linspace(0.5, 1, M);  % Variación de la saturación (S) de 0 a 0.5
S = toeplitz(s);  % Matriz de Toeplitz que varía el color

V = ones(M, N);  % L constante


Ic = zeros(M, N, 3);  % Inicializar matriz para la imagen HSV
Ic(:,:,1) = H;  % Asignar el canal H
Ic(:,:,2) = S;  % Asignar el canal S
Ic(:,:,3) = V;  % Asignar el canal L


Irgb = hsv2rgb(Ic);% Convertir la imagen de HSV a RGB

Irgb_enmascarada = Irgb.*mask;

% Mostrar la imagen
subplot(5, 2, 7);
imshow(Irgb_enmascarada);
title('Solucion 5');

%////////////////EJERCICIO 6///////////////////////////

M=256;N=256; %M filas N columnas


h = linspace(1, 0, M);  % Variación del color (H) de 0 a 1
H = toeplitz(h);  % Matriz de Toeplitz que varía el color

s = linspace(0.5, 1, M);  % Variación de la saturación (S) de 0 a 0.5
S = toeplitz(s);  % Matriz de Toeplitz que varía el color

V = ones(M, N);  % L constante


Ic = zeros(M, N, 3);  % Inicializar matriz para la imagen HSV
Ic(:,:,1) = H;  % Asignar el canal H
Ic(:,:,2) = S;  % Asignar el canal S
Ic(:,:,3) = V;  % Asignar el canal L


Irgb = hsv2rgb(Ic);% Convertir la imagen de HSV a RGB

Irgb_enmascarada = Irgb.*mask;

% Cuantificación de la imagen a 8 colores con dithering
[Iind_dither, map_dither] = rgb2ind(Irgb_enmascarada, 8, 'dither');

% Cuantificación de la imagen a 3 colores sin dithering
[Iind_nodither, map_nodither] = rgb2ind(Irgb_enmascarada, 3, 'nodither');

% Mostrar la imagen cuantificada con dithering
subplot(5, 2, 10);
imshow(Iind_dither, map_dither);  % Es importante usar el mapa de colores
title('Solucion 5 con Dithering');

% Mostrar la imagen cuantificada sin dithering
subplot(5, 2, 9);
imshow(Iind_nodither, map_nodither);  % Es importante usar el mapa de colores
title('Solucion 5 sin Dithering');

