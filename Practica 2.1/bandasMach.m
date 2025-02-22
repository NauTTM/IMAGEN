M=256;N=256; %M filas N columnas
k=6; %k=prof.color
Nb=2^k; %2^k niveles de gris, bandas
x=linspace(0,1,N);%vector lineal de 0 a 1 con N componentes
xq=fix((Nb*x))/(Nb-1); %redondear a num enteros
plot(1:N,x,1:N,xq); %para ver los escalones
I=repmat(xq,M,1); %replicamos el vector para crear una matriz
figure(2);
imshow(I,[]); %representar imágenes
figure(3);
colormap("spring"); %color de las gráficas
imagesc(I); %considera la imagen como un campo vectorial, con mapa de colores

I2=uint8(I);
figure(4);
imshow(I2);
I3=uint8(round(I*255));
figure(5);
imshow(I3);
I4=double(I3); %se verá saturado
figure(6);
imshow(I4);
I5=double(I3)/255; %arreglar la saturación
figure(7);
imshow(I5,[]);
