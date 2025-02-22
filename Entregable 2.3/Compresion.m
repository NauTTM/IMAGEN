%%
% /////////////////////// Ejercicio 1 //////////////////
I = imread('cameraman.tif');
I_dob1 = double(I);
I_dob = I_dob1 - 128;

% Visualizar los resultados
figure;
subplot(1,3,1);
imshow(I);

%%
% /////////////////////// Ejercicio 2 (metodo 1) //////////////////
mask = zigzag(8, 8, 32);
I_dct2 = blockproc(I_dob, [8 8], @(block) idct2(mask.*dct2(block.data)));
I_dct2 = I_dct2 + 128;
subplot(1,3,2);
imshow(I_dct2, []);

%%
% /////////////////////// Ejercicio 2 (metodo 2) //////////////////

table = load('tabla.dat');
 
I_dct3 = blockproc(I_dob, [8 8], @(block) idct2(round(dct2(block.data)./table).*table));
I_dct3 = I_dct3 + 128;
subplot(1,3,3);
imshow(I_dct3/255, []);

%%
%////////////////// EJERCICIO 3 /////////////////
% PSNR TIENE QUE DAR EN TORNO A 31.57dB
PSNR_1 = 10*log10(max(I_dob1(:).^2)./costFuncMSE(I_dct2, I_dob1))



%%
%////////////////// EJERCICIO 4 /////////////////
% PSNR TIENE QUE DAR EN TORNO A 31.57dB
PSNR_2 = 10*log10(max(I_dob1(:).^2)./costFuncMSE(I_dct3, I_dob1))