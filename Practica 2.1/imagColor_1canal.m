N=255;M=255;
h=0.1*ones(N,1);  %hago mi mapa de colores en hsv
s=ones(N,1);
v=(linspace(0,1,N))';

map=hsv2rgb([h,s,v]); %lo paso a rgb
imagen=repmat(1:N,M,1); %lo indexo cada columna a un color

figure;
imshow(imagen,map);