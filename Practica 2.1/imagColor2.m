M=255;N=255; %M filas N columnas
H=repmat(linspace(0,1,N),M,1);
%[h, s]=meshgrid(linspace(0,1,N), linspace(0, 1, M); Lo mismo pero con
%meshgrid
V=ones(M,N);  %la dejamos constante
S=H';   %la H pero traspuesta
Ic=zeros(M,N,3);
Ic(:,:,1)=H;
Ic(:,:,2)=S;
Ic(:,:,3)=V;
Irgb=hsv2rgb(Ic);
figure(1);
imshow(Irgb);
figure(2);
imshow(Ic);
