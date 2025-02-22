function MascaraSalida =zizzag(Filas, Columnas,Coeficientes)

% no se garantiza que esta rutina este libre de errores

MascaraSalida	=zeros(Filas,Columnas);
debug=0;

if (Coeficientes==0) 
   return;
end;
   
SubidaDiagonal=1;
i=1;
j=1;
CoefAcumulados=0;
continua=1;

  while (continua)
     MascaraSalida(i,j)=1;
     CoefAcumulados=CoefAcumulados+1;
     if (SubidaDiagonal) %estamos subiendo por una diagonal
        if ((i-1>0)&(j+1<=Columnas)) %Puedo subir??
           if (debug) disp('Puedo subir diagonal'); end;
           i=i-1;
           j=j+1;           
        elseif (j<Columnas) %no he podido subir, y estoy en el triangulo superior. 
           			    % me voy a la derecha
                        j=j+1;
                        SubidaDiagonal=0; 
                        if (debug) disp('No pude subir diagonal. Me voy derecha'); end;
        elseif (i<Filas) %entonces puedo bajar vertical
        	i=i+1;
            SubidaDiagonal=0;
           	if (debug) disp('No pude subir diagonal. Bajo en vertical'); end;
        else
         	return;   
        end;
     else %estamos bajando por una diagonal
        if (((i+1)<=Filas)&((j-1)>0)) %Puedo bajar??
           if (debug) disp('Puedo bajar diagonal'); end;
           i=i+1;
           j=j-1;   
        elseif (i<Filas) %no he podido bajar en diagonal, y estoy en el triangulo superior. 
           			    % me voy hacia abajo
                        i=i+1;
                        SubidaDiagonal=1;  
                        if (debug) disp('No pude bajar diagonal. Bajo en vertical'); end;
        elseif (j<Columnas) %entonces puedo ir horizontal
        	j=j+1;
            SubidaDiagonal=1;
            if (debug) disp('No pude bajar diagonal. Me voy a la derecha'); end;
        else
         	return;   
         end;
      end;   
      
      continua=(CoefAcumulados<Coeficientes);  
   
   
   
   
end;
