%% //////////////////// EJERCICIO 1 ////////////////////
% Limpieza del entorno
clear all;
close all;

% Dimensiones del video QCIF europeo
height = 144;
width = 176;
nframes = 300; % Número total de frames

% Lectura del video
[Y, U, V] = yuv_import('akiyo_qcif.yuv', [width height], nframes);

% Inicialización de matrices para almacenar los frames procesados
Frames_rec = zeros(height, width, 3, nframes, 'uint8');

% Procesamiento de frames 
% Parámetros
N = 10; % Distancia entre frames tipo I
data=load('tabla_croma.mat'); % Cargar tabla de cuantificación
tabla = data.tabla_croma;
mbSize = 16; % Tamaño de macrobloques
p = 3; % Región de búsqueda para frames P

% Procesar todos los frames
for i = 1:nframes
    if mod(i-1, N) == 0 % Frame tipo I
        % Frame tipo I (luminancia y crominancia)
        frame_Y = Y{i};
        frame_U = imresize(U{i}, [height width]);
        frame_V = imresize(V{i}, [height width]);

        % Compresión JPEG
        frame_Y_comp = compresion2jpeg(double(frame_Y), tabla);
        frame_U_comp = compresion2jpeg(double(frame_U), tabla);
        frame_V_comp = compresion2jpeg(double(frame_V), tabla);

        % Reconstrucción del frame
        frame_Y_rec = uint8(compresion2jpeg(frame_Y_comp, tabla));
        frame_U_rec = uint8(compresion2jpeg(frame_U_comp, tabla));
        frame_V_rec = uint8(compresion2jpeg(frame_V_comp, tabla));

        % Almacenar frame reconstruido
        Frames_rec(:, :, 1, i) = frame_Y_rec;
        Frames_rec(:, :, 2, i) = frame_U_rec;
        Frames_rec(:, :, 3, i) = frame_V_rec;

    else % Frame tipo P
        % Frame actual y de referencia
        frame_Y_ref = Frames_rec(:, :, 1, i-1);
        frame_Y_act = Y{i};

        % Estimación de movimiento
        motionVectors = estmov(double(frame_Y_act), double(frame_Y_ref), mbSize, p);

        % Compensación de movimiento
        frame_Y_comp = compmov(double(frame_Y_ref), motionVectors, mbSize);

        % Diferencia entre el frame actual y el compensado
        frame_diff = double(frame_Y_act) - frame_Y_comp;

        % Compresión JPEG de la diferencia
        frame_diff_comp = compresion2jpeg(frame_diff, tabla);

        % Reconstrucción del frame actual
        frame_diff_rec = compresion2jpeg(frame_diff_comp, tabla);
        frame_Y_rec = uint8(frame_Y_comp + frame_diff_rec);

        % Almacenar frame reconstruido
        Frames_rec(:, :, 1, i) = frame_Y_rec;
        Frames_rec(:, :, 2, i) = Frames_rec(:, :, 2, i-1);
        Frames_rec(:, :, 3, i) = Frames_rec(:, :, 3, i-1);
    end
end


%% ///////////////////////// EJERCICIO 2 /////////////////////////////
% Reproducción del video en formato YCbCr
implay(Frames_rec, 30);

% Conversión de los frames reconstruidos a formato RGB
RGBFrames = zeros(height, width, 3, nframes, 'uint8');
for i = 1:nframes
    RGBFrames(:, :, :, i) = ycbcr2rgb(Frames_rec(:, :, :, i));
end

% Reproducción del video en formato RGB
implay(RGBFrames, 30);

%% //////////////////// EJERCICIO 3 Y EJERCICIO 4 //////////////////////////

% Inicialización de métricas
PSNR_values = zeros(1, nframes);
SSIM_values = zeros(1, nframes);

% Cálculo de PSNR y SSIM para cada frame
for i = 1:nframes
    % Frame original en RGB
    original_frame = ycbcr2rgb(cat(3, uint8(Y{i}), uint8(imresize(U{i}, [height width])), uint8(imresize(V{i}, [height width]))));

    % Frame reconstruido en RGB
    recframe = RGBFrames(:, :, :, i);

    % Cálculo de PSNR y SSIM
    PSNR_values(i) = psnr(recframe, original_frame);
    SSIM_values(i) = ssim(recframe, original_frame);

end

% Representación gráfica de PSNR
figure;
subplot(2, 1, 1);
plot(1:nframes, PSNR_values, '-o');
title('PSNR por Frame');
xlabel('Número de Frame');
ylabel('PSNR (dB)');
grid on;

% Representación gráfica de SSIM
subplot(2, 1, 2);
plot(1:nframes, SSIM_values, '-o');
title('SSIM por Frame');
xlabel('Número de Frame');
ylabel('SSIM');
grid on;

% Promedios
PSNR_promedio = mean(PSNR_values);
SSIM_promedio = mean(SSIM_values);
disp(['PSNR promedio: ', num2str(PSNR_promedio), ' dB']);
disp(['SSIM promedio: ', num2str(SSIM_promedio)]);

%% ///////////////////// EJERCICIO 5 /////////////////////

% //////////////////// EJERCICIO 1 ////////////////////
% Limpieza del entorno
clear all;
close all;

% Dimensiones del video QCIF europeo
height = 144;
width = 176;
nframes = 300; % Número total de frames

% Lectura del video
[Y, U, V] = yuv_import('akiyo_qcif.yuv', [width height], nframes);

% Inicialización de matrices para almacenar los frames procesados
Frames_rec = zeros(height, width, 3, nframes, 'uint8');

% Procesamiento de frames 
% Parámetros
N = 5; % Distancia entre frames tipo I
data=load('tabla_croma.mat');
tabla = data.tabla_croma;
mbSize = 16;
p = 3; % Región de búsqueda para frames P

% Procesar todos los frames
for i = 1:nframes
    if mod(i-1, N) == 0 % Frame tipo I
        % Frame tipo I (luminancia y crominancia)
        frame_Y = Y{i};
        frame_U = imresize(U{i}, [height width]);
        frame_V = imresize(V{i}, [height width]);

        % Compresión JPEG
        frame_Y_comp = compresion2jpeg(double(frame_Y), tabla);
        frame_U_comp = compresion2jpeg(double(frame_U), tabla);
        frame_V_comp = compresion2jpeg(double(frame_V), tabla);

        % Reconstrucción del frame
        frame_Y_rec = uint8(compresion2jpeg(frame_Y_comp, tabla));
        frame_U_rec = uint8(compresion2jpeg(frame_U_comp, tabla));
        frame_V_rec = uint8(compresion2jpeg(frame_V_comp, tabla));

        % Almacenar frame reconstruido
        Frames_rec(:, :, 1, i) = frame_Y_rec;
        Frames_rec(:, :, 2, i) = frame_U_rec;
        Frames_rec(:, :, 3, i) = frame_V_rec;

    else % Frame tipo P
        % Frame actual y de referencia
        frame_Y_ref = Frames_rec(:, :, 1, i-1);
        frame_Y_act = Y{i};

        % Estimación de movimiento
        motionVectors = estmov(double(frame_Y_act), double(frame_Y_ref), mbSize, p);

        % Compensación de movimiento
        frame_Y_comp = compmov(double(frame_Y_ref), motionVectors, mbSize);

        % Diferencia entre el frame actual y el compensado
        frame_diff = double(frame_Y_act) - frame_Y_comp;

        % Compresión JPEG de la diferencia
        frame_diff_comp = compresion2jpeg(frame_diff, tabla);

        % Reconstrucción del frame actual
        frame_diff_rec = compresion2jpeg(frame_diff_comp, tabla);
        frame_Y_rec = uint8(frame_Y_comp + frame_diff_rec);

        % Almacenar frame reconstruido
        Frames_rec(:, :, 1, i) = frame_Y_rec;
        Frames_rec(:, :, 2, i) = Frames_rec(:, :, 2, i-1);
        Frames_rec(:, :, 3, i) = Frames_rec(:, :, 3, i-1);
    end
end

% //////////////////// EJERCICIO 3 Y EJERCICIO 4 //////////////////////////

% Inicialización de métricas
PSNR_values = zeros(1, nframes);
SSIM_values = zeros(1, nframes);

% Inicialización de RGBFrames para N = 5
RGBFrames_N5 = zeros(height, width, 3, nframes, 'uint8');
for i = 1:nframes
    RGBFrames_N5(:, :, :, i) = ycbcr2rgb(Frames_rec(:, :, :, i)); % Convertir a RGB
end

% Cálculo de PSNR y SSIM para cada frame
for i = 1:nframes
    % Frame original en RGB
    original_frame = ycbcr2rgb(cat(3, uint8(Y{i}), uint8(imresize(U{i}, [height width])), uint8(imresize(V{i}, [height width]))));

    % Frame reconstruido en RGB
    recframe = RGBFrames_N5(:, :, :, i);

    % Cálculo de PSNR y SSIM
    PSNR_values(i) = psnr(recframe, original_frame);
    SSIM_values(i) = ssim(recframe, original_frame);

end

% Representación gráfica de PSNR
figure;
subplot(2, 1, 1);
plot(1:nframes, PSNR_values, '-o');
title('PSNR por Frame (N = 5)');
xlabel('Número de Frame');
ylabel('PSNR (dB)');
grid on;

% Representación gráfica de SSIM
subplot(2, 1, 2);
plot(1:nframes, SSIM_values, '-o');
title('SSIM por Frame (N = 5)');
xlabel('Número de Frame');
ylabel('SSIM');
grid on;

% Promedios
PSNR_promedio = mean(PSNR_values);
SSIM_promedio = mean(SSIM_values);
disp(['PSNR promedio(N = 5): ', num2str(PSNR_promedio), ' dB']);
disp(['SSIM promedio(N = 5): ', num2str(SSIM_promedio)]);
