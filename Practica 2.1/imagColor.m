M=255;N=255; %M filas N columnas
H=0.1*ones(M,N);
S=ones(M,N);
V=repmat(linspace(0,1,N),M,1);
Ic=zeros(M,N,3);
Ic(:,:,1)=H;
Ic(:,:,2)=S;
Ic(:,:,3)=V;
Irgb=hsv2rgb(Ic);
figure(1);
imshow(Irgb);
figure(2);
imshow(Ic);
