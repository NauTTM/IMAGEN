% % Lectura y reproducci´on de un video en formato mpeg
% Precarga la estructura de datos .
vidObj = VideoReader("testVideo.mpeg")
s = struct("cdata" , zeros (vidObj.Height , vidObj.Width , "uint8") , "colormap" , []) ;
numFrames = 0;  %poner 631 (numero de frames+1) para que se reproduzca de forma inversa; y el bucle cambiar el signo del 1
Duration = vidObj.CurrentTime ;
while hasFrame(vidObj)
    numFrames = numFrames + 1;
    s(numFrames).cdata = readFrame(vidObj); %Para rotar s(numFrames).cdata = imrotate(readFrame(vidObj),90);
    
    Duration = vidObj.CurrentTime;
end

% Visualizaci´on del video
implay(s,vidObj.FrameRate*2) %Multiplicando o dividiendo FrameRate modificamos la velocidad
Duration
numFrames