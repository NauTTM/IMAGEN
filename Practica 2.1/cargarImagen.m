%Hay que comentar una de las 2 imagenes o la I se duplicará
%[I]=double(imread('board.tif'))/255; %cargo la imagen en formato double
[I,map]=imread('forest.tif'); %como es de tipo indexado, hay que cargar tanto la matriz como el mapa de color
I=ind2rgb(I,map); %la paso a double para poder trabajar con ella
%tambien se puede hacer con el comando im2double()
[J]=rgb2gray(I);
[J2]=0.3*I(:,:,1)+0.59*I(:,:,2)+0.11*I(:,:,3); %multiplico cada canal (r,g,b) con el factor
J3=mean(I,3); %hace la media en la 3 dimension, es decir, promedia en cada elemento el rojo, verde y azul
figure;
subplot(2,2,1);imshow(I);
subplot(2,2,2);imshow(J);
subplot(2,2,3);imshow(J2);
subplot(2,2,4);imshow(J3);