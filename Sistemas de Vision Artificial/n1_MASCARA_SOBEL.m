%MÁSCARA DE SOBEL: La máscara de SOBEL es un operador muy utilizado en 
%visión artificial y lo que hace es considerar dos matrices, las cuales se 
%llaman máscaras, estas matrices Δx = Sx y Δy = Sy son de 3X3 y se aplican 
%en torno a un pixel central, el cual es el elemento de análisis y a los 
%elementos que lo rodean se les llama vecindad, el pixel central tiene la 
%coordenada i,j y a partir de ese punto se dan las coordenadas de los 
%elementos de la vecindad, siendo las filas de abajo las coordenadas i+1 y 
%las de arriba i-1 y siendo las columnas de la izquierda j-1 y las de la 
%derecha j+1, la siguente matriz se crea a partir de la columna j+1 de la 
%anterior y así se van creando las demás respectivamente.
%El pixel central que se encuentra en el centro de las matrices 3X3 de la
%máscara de Sobel se describe con una función x1(τ) y x2(t-τ) el cual es un
%elemento que se encuentra rotado y con un desplazamiento, intercambiando
%las filas y columnas de la matriz original entre sí. Luego se aplica
%convolución por lo que ambos elementos x1(τ) y x2(t-τ) deben ser
%multiplicados.
function R = n1_MASCARA_SOBEL(f)
Sx = [-1,-2,-1;0,0,0;1,2,1];    %Sx = Δx
Sy = [-1,0,1;-2,0,2;-1,0,1];    %Sy = Δy = Transpuesta(Sx)
[filas, columnas] = size(f);    %Dimensionamiento de la escala de grises.

for i = 2:filas-1
    for j = 2:columnas-1
        %Gx = f(x+Δx,y(cte))-f(x-Δx,y(cte))/Δx*Sx
        %Gy = f(x(cte),y+Δy)-f(x(cte),y-Δy)/Δx*Sy
        S = f(i-1:i+1, j-1:j+1);
        %G = √Gx^2+Gy^2
        R(i-1,j-1) = sqrt(sum(sum(S.*Sx))^2+sum(sum(S.*Sy))^2);
    end
end