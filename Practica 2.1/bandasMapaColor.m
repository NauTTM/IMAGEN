M=255;N=255; %M filas N columnas
k=6; %k=prof.color
Nb=2^k; %2^k niveles de gris, bandas
xq=fix((Nb*k))/(Nb-1); %redondear a num enteros
%plot(1:N,x,1:N,xq); %para ver los escalones
I=repmat(xq,M,1); %replicamos el vector para crear una matriz
%figure(2);
%imshow(I,[]); %representar imágenes
%figure(3);
%colormap("spring"); %color de las gráficas
%imagesc(I); %considera la imagen como un campo vectorial, con mapa de colores

k=5;
Nmapa=2^k; %niveles de colores
mapa=repmat(linspace(0,1,Nmapa)',1,3); %repito el vector columna 3 veces (creo el mapa de colores)
mapa2=colormap(jet(Nmapa)); %creo un mapa de colores con el "cool"
J=gray2ind(I,Nmapa); %convierte los valores de grises a indexados
figure(4);
imshow(J,mapa2)
colormap(255);

