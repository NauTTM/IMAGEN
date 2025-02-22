%%%%%%%%%%%%%%%%%%%%%%%%% Ejercicio 1 %%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
% %Lectura de video YUV RAW
%Formato QCIF europeo , 4:2:0
height =144;
width =176;
nframes =300;

%Lectura de las componentes de video
[Y ,U , V ]=( yuv_import ('akiyo_qcif.yuv',[width height],nframes) ) ;

%Conversi´on video apto para visualizaci´on
vid = zeros ( height , width ,3 , nframes ) ;

for k =1: nframes
    %Resampling de croma para visualizaci´on
    U { k }= imresize ( U { k } ,[ height width ]) ;
    V { k }= imresize ( V { k } ,[ height width ]) ;
    vid (: ,: ,1 , k ) =( Y { k }) ;
    vid (: ,: ,2 , k ) =( U { k }) ;
    vid (: ,: ,3 , k ) =( V { k }) ;
    vidrgb (: ,: ,: , k ) =( ycbcr2rgb ( uint8 ( vid (: ,: ,: , k ) ) ) ) ;
    video ( k ) = im2frame ( uint8 (( vidrgb (: ,: ,: , k ) ) ) ) ;
end

%Reproducci´on del video
%implay (video ,30)

%%%%%%%%%%%%%%%%%%%%%%%%% Ejercicio 2 %%%%%%%%%%%%%%%%%%%%%%%%%%

%Definimos las imagenes
Iref = Y{10};
Iact = Y{15};
%Iact = Y{200};  %Ejercicio 6

%Calculamos el error cuadrático medio entre ambas en dB
E = costFuncMSE(Iact,Iref)

%Visualizamos ambas imágenes
figure(1);
subplot(1,3,1);
imshow(uint8(Iref));
subplot(1,3,2);
imshow(uint8(Iact));

%%%%%%%%%%%%%%%%%%%%%%%%% Ejercicio 3 %%%%%%%%%%%%%%%%%%%%%%%%%%

%Crear una imagen con movimiento compensado
MV = estmov(Iact,Iref,16,3); % Vectores de movimiento
Icomp = compmov(Iref,MV,16); % Imagen compensada

%Visualización de la imagen compensada
subplot(1,3,3);
imshow(uint8(Icomp));

%%%%%%%%%%%%%%%%%%%%%%%%% Ejercicio 4 %%%%%%%%%%%%%%%%%%%%%%%%%%

%Ver las 2 diferencias y calcular el error entre ambas
imdiff = Iact - Iref;
imdiffcomp = Iact - Icomp; %comp-ref

%Calcular el error cuadrático medio entre ambas
E2 = costFuncMSE(Iact,Icomp)

%Las visualizamos
figure(2);
subplot(1,2,1);
imshow(imdiff/255);
subplot(1,2,2);
imshow(imdiffcomp/255);

%%%%%%%%%%%%%%%%%%%%%%%%% Ejercicio 5 %%%%%%%%%%%%%%%%%%%%%%%%%%

%Comprimirlas usando el metodo 2 de JPEG
table = load('tabla.dat');

Imdiff = compresion2jpeg (imdiff,table);
Imdiffcomp = compresion2jpeg (imdiffcomp,table);
Irefjpeg = compresion2jpeg (Iref,table);

%Reconstruir la imagen actual con las comprimidas antes
Iact_reconstruida = Irefjpeg + Imdiff;
Iact_reconstruida_comp = Imdiffcomp + compmov(Irefjpeg,MV,16);

%Calculamos la PSNR
PSNR_1 = 10*log10(max(Iact(:).^2)./costFuncMSE(Iact, Iact_reconstruida))
PSNR_2 = 10*log10(max(Iact(:).^2)./costFuncMSE(Iact, Iact_reconstruida_comp))

%Visualizamos
figure(3);
subplot(1,3,1);
imshow(uint8(Iact));
subplot(1,3,2);
imshow(uint8(Iact_reconstruida));
subplot(1,3,3);
imshow(uint8(Iact_reconstruida_comp));

%%%%%%%%%%%%%%%%%%%%%%%%% Ejercicio 6 %%%%%%%%%%%%%%%%%%%%%%%%%%

%Pasos 3 - 5 para el frame 200 como actual
