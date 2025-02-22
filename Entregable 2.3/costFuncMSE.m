% Calcula el error cuadr�tico medio entre los dos bloques de entrada 


function cost = costFuncMSE(currentBlk,refBlk)


cost=mean((int32(currentBlk(:))-int32(refBlk(:))).^2);

