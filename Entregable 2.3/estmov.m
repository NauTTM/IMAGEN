% C�lculo de vectores de movimiento mediante b�squeda exhaustiva
%
% Entradas
%   imgP : Imagen para la que calculamos los vectores
%   imgI : Imagen de referencia, puede ser I o P
%   mbSize : Tama�o del macrobloque (mbsize=16 para macrobloques t�picos de
%   16x16
%   p : Par�metro que delimita la regi�n de b�squeda
%
% Ouput
%   vectors : Matriz 2x(MxN/mbsize^2) que contiene las coordenadas de los
%   vectores para cada macrobloque en la imagen P
%
% Adaptaci�n de c�digo escrito por Aroh Barjatya disponible en Matlab File
% Exchange
% No se garantiza que est� libre de errores

function [vectors] = estmov(imgP, imgI, mbSize, p)

[row col] = size(imgI);

vectors = zeros(2,row*col/mbSize^2); %Tantos vectores de movimiento como macrobloques
costs = ones(2*p + 1, 2*p +1) * 65537;%Inicializao matriz de costes para evitar problemas
% Escaneamos la imagen en modo raster
% Vamos seleccionando cada macrobloque
% Para cada macrobloque exploramos la regi�n de b�squeda en imgI (de tama�o
% (2p+mbsize)x(2p+mbsize) p�xeles, centrada en la posici�n del macrobloque





mbCount = 1;
for i = 1 : mbSize : row-mbSize+1
    for j = 1 : mbSize : col-mbSize+1
        
        % Aqu� empieza la b�squeda exhaustiva
        % Evaluaremos el MSE para (2p+1)x(2p+1) bloques (excepto en los
        % bbordes de la imagen)
        % m contador de filas
        % n contador de columnas
        % Exploraci�n por l�neas
        
        for m = -p : p        
            for n = -p : p
                refBlkVer = i + m;   %posicionamiento vertical a partir del bloque de referencia
                refBlkHor = j + n;   %posicionamiento horizontal a partir del bloque de referencia
                if ( refBlkVer < 1 || refBlkVer+mbSize-1 > row ... %Ignoramos los efectos de borde
                        || refBlkHor < 1 || refBlkHor+mbSize-1 > col)
                    continue;
                end
                costs(m+p+1,n+p+1) = costFuncMSE(imgP(i:i+mbSize-1,j:j+mbSize-1), ...
                     imgI(refBlkVer:refBlkVer+mbSize-1, refBlkHor:refBlkHor+mbSize-1));%generamos una matriz de costes con los MSEs de cada comparativa
           end
        end
        
        % Ahora buscamos el vector para el que el coste es m�nimo y lo almacenamos..
        
          minimo=min(costs(:));
          minimo=minimo(1);if isempty(minimo),minimo=65537;end
          [dy, dx] = find(costs==minimo);
          dx=dx(1);dy=dy(1); % Encuentra qu� macrobloque en imgI da lugar al m�nimo coste

        vectors(1,mbCount) = dy-p-1;    % coordenada x
        vectors(2,mbCount) = dx-p-1;    % coordenada y
              mbCount = mbCount + 1; % Contador de macrobloques ++
        costs = ones(2*p + 1, 2*p +1) * 65537^2; %Asignaci�n de costes m�ximos para evitar problemas

    end
end


                    