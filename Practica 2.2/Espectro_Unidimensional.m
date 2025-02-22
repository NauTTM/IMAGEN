%///////////////// EJERCICIO 2 ///////////////
% Lectura y reproducci´on de un video en formato mpeg
% Precarga la estructura de datos .
vidObj = VideoReader("testVideo.mpeg")
s = struct("cdata" , zeros (vidObj.Height , vidObj.Width , "uint8") , "colormap" , []) ;
numFrames = 0; %poner 631 (numero de frames+1) para que se reproduzca de forma inversa; y el bucle cambiar el signo del 1
nframes=200;
Duration = vidObj.CurrentTime ;
while hasFrame(vidObj)
    numFrames = numFrames + 1;
    s(numFrames).cdata = readFrame(vidObj); %Para rotar s(numFrames).cdata = imrotate(readFrame(vidObj),90);
    Duration = vidObj.CurrentTime;
end

m=vidObj.Height;
n=vidObj.Width;
%%
vf=[];
%Repetir 10 veces la primera imagen
    for i=1:nframes
        vf=[vf im2col(rgb2gray(s(1).cdata), [1 1], 'distinct')];
    end
%Transponer frame para que el im2col lea por filas
%%
fimagen=vidObj.FrameRate;
flinea=m*fimagen;
fs=n*flinea;
Ts=1/fs;
t=0:Ts:(nframes/fimagen-Ts);
Vf=1/fs*fftshift(abs(fft(vf)));
f=-fs/2:fs/(size(vf,2)):fs/2-fs/(size(vf, 2));
plot(t, vf)
figure;
plot(f, Vf)
axis([-2.5*flinea 0 0 max(Vf)])

%%
%/////////////////// EJERCICIO 3 ///////////////////////
[I]=imread('cameraman.tif');
subsampx=2;subsampy=2;
I_sub=I(1:subsampy:end,1:subsampx:end); %Simulamos el submuestro simple
I_sub2=blockproc(double(I)/255,[subsampy,subsampx],@(blockstruct) (mean(blockstruct.data(:))));%Simulamos la adquisicion del sensor

subplot(1,3,1)
imshow(I)
subplot(1,3,2)
imshow(I_sub)
subplot(1,3,3)
imshow(I_sub2)

%%
%Cambio los niveles de cuantificacion
I_dob=double(I)/255;
bit_depth=3;
N_cuant=2^bit_depth;
I_cuant=fix(N_cuant*I_dob)/(N_cuant);

figure
subplot(1,2,1)
imshow(I_dob)
subplot(1,2,2)
imshow(I_cuant)

%%
%%Repetimos el ejercicio 3 con imagen RGB
clear all;close all;
[I]=double(imread('peppers.png'))/255;
[J]=rgb2ycbcr(I);
y=J(:,:,1); u=J(:,:,2); v=J(:,:,3);
subsamp_y=4;subsamp_u=1;subsamp_v=1;
y_sub=imresize(y(1:subsamp_y:end,1:subsamp_y:end),[size(I,1),size(I,2)],'nearest');
u_sub=imresize(u(1:subsamp_u:end,1:subsamp_u:end),[size(I,1),size(I,2)],'nearest');
v_sub=imresize(v(1:subsamp_v:end,1:subsamp_v:end),[size(I,1),size(I,2)],'nearest');
I_sub=zeros(size(I));
I_sub(:,:,1)=y_sub;
I_sub(:,:,2)=u_sub;
I_sub(:,:,3)=v_sub;
I_sub=ycbcr2rgb(I_sub); 

subplot(1,2,1)
imshow(I)
subplot(1,2,2)
imshow(I_sub)

%%
%muestreo por canal

sub_r=1;
sub_g=1;
sub_b=1;

r_sub=imresize(y(1:sub_r:end,1:sub_r:end),[size(I,1),size(I,2)],'nearest');
g_sub=imresize(y(1:sub_g:end,1:sub_g:end),[size(I,1),size(I,2)],'nearest');
b_sub=imresize(y(1:sub_b:end,1:sub_b:end),[size(I,1),size(I,2)],'nearest');

I_sub=zeros(size(I));
I_sub(:,:,1)=r_sub;
I_sub(:,:,2)=g_sub;
I_sub(:,:,3)=b_sub;

figure;
subplot(1,3,1)
imshow(I)
subplot(1,3,2)
imshow(I_sub)

%%
%/////////////////////// EJERCICIO 4 /////////////////////////
[A]=imread('cameraman.tif');
J=double(A)/255;
h = ones([5,5])/25;
If = filter2 (h,J); %filtro

J2=imnoise(J,'salt & pepper'); %imagen degradada con ruido
If2 = filter2 (h,J2);    %filtro
If3 = imgaussfilt(J2,2); %filtro gaussiano
If4 = medfilt2(J2);      %filtro mediana

J3=imnoise(J,'gaussian',0.05);
If5 = filter2 (h,J3);    %filtro
If6 = imgaussfilt(J3,2); %filtro gaussiano
If7 = medfilt2(J3);      %filtro mediana

J4=imsharpen(J,"Amount",1.2,"Radius",1.5); 

h2 = -1 * ones([7,7])/49;
h2(4, 4)=48/49;
J5=J+filter2 (h2,J); %filtrada con filtro 7x7 

figure;
subplot(4,3,1)
imshow(J)
subplot(4,3,2)
imshow(If,[]);
subplot(4,3,3)
imshow(J2);
subplot(4,3,4)
imshow(If2,[]);
subplot(4,3,5)
imshow(If3,[]);
subplot(4,3,6)
imshow(If4,[]);
subplot(4,3,7)
imshow(If5,[]);
subplot(4,3,8)
imshow(If6,[]);
subplot(4,3,9)
imshow(If7,[]);
subplot(4,3,10)
imshow(J4);
subplot(4,3,11)
imshow(J5);

%%
%////////////// EJERCICIO 5 ////////////////

[A]=imread('pout.tif');
J=double(A)/255;

figure;
subplot(1,2,1)
imshow(J)
subplot(1,2,2)
imhist(J,64)%histograma

%Transformación con histeq
R=histeq(J);

figure;
subplot(1,2,1)
imshow(R)
subplot(1,2,2)
imhist(R,64)%histograma e imagen ecualizados

%Transformación con histeq, curva del diagrama
[R,T]=histeq(J);
nn=imhist(J,256)';
cum=cumsum(nn/length(J(:)));

figure;
plot((0:255)/155,T,(0:255)/255,cum);

%transformación sin histeq
nn = imhist(J,256)';
cum=cumsum(nn/length(J(:)));
map=(repmat(cum',1,3));
[R,map_old]=gray2ind(J,256);
R=ind2gray(R,map);
figure;
subplot(1,2,1)
imshow(R)
subplot(1,2,2)
imhist(R,64)

%nueva transformación
R=histeq(J);
H=sqrt(double(R));

figure;
subplot(1,3,1)
imshow(H)
subplot(1,3,2)
imhist(H,64);
[nn, x]=imhist(H,64);
%bar(x,nn)
subplot(1,3,3)
plot(x,2*x,x,nn/length(H(:))/(x(2)-x(1)))

