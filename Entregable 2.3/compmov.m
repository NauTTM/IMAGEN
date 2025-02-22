% Proporciona imagen con movimiento compensado a partir de referencia y
% conjunto de vectores de movimiento
%
% Entradas
%   imgI : Imagen de referencia 
%   motionVect : Vectores de movimiento
%   mbSize : Tamaño de los macrobloques
%
% Salida
%   imgComp : Imagen con movimiento compensado
%
% Adaptación de código escrito por Aroh Barjatya disponible en Matlab File
% Exchange
% No se garantiza que esté libre de errores


function imgComp = compmov(imgI, motionVect, mbSize)

[row col] = size(imgI);

% Escaneamos la imagen en modo raster
% Vamos seleccionando cada macrobloque a asignar en la imagen compensada
% y para cada uno leemos el vector de movimiento y le asignamos el
% macrobloque correspondiente a la posición de dicho vector en la imagen de
% referencia

mbCount = 1;
for i = 1:mbSize:row-mbSize+1
    for j = 1:mbSize:col-mbSize+1
        
        % dy índice correspondiente a filas (vertical)
        % dx índice correspondiente a columnas (horizontal)
              
        dy = motionVect(1,mbCount);
        dx = motionVect(2,mbCount);
        refBlkVer = i + dy;
        refBlkHor = j + dx;
        imageComp(i:i+mbSize-1,j:j+mbSize-1) = imgI(refBlkVer:refBlkVer+mbSize-1, refBlkHor:refBlkHor+mbSize-1);
    
        mbCount = mbCount + 1;
    end
end

imgComp = imageComp;