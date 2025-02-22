clear all;close all;
M=256;
N=256;

[x y]=meshgrid(linspace(0,1,N),linspace(0,1,M));

I=y.*(cos(2*pi*25*x.*x));
imshow(I,[])

%axis xy