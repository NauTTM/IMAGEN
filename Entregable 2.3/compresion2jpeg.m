function [I] = compresion2jpeg (I_dob,table)
I_dob = I_dob - 128;
I = blockproc(I_dob, [8 8], @(block) idct2(round(dct2(block.data)./table).*table));
I = I + 128;
end