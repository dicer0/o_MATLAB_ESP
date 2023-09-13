clc 
clear all 
close all

%DETECTOR BAUDET: Método matemático para la detección de esquinas en una 
%figura.
IMA = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\4_Firmas_de_Figuras_Simples\firma estrella.bmp');
%rgb2gray(): Comando que extrae el cubo matricial de la imagen obtenida con 
%imread y hace un tipo de promedio con todos los colores para obtener una 
%escala de grises que no le da prioridad a ningún color R, G o B en 
%específico.
Im=double(rgb2gray(IMA));

%ones(n): Método que crea una matriz vacía, llenándola de puros unos en sus 
%nxn posiciones.
h=ones(3)/9;

%imfilter(A,h): Método que filtra la matriz A con el vector o matriz h, 
%osea que en este caso filtra la imagen con la matriz H, esto lo que hace
%es que el borde sea más grueso para el análisis de las esquinas.
Im = imfilter(Im,h);

%MÁSCARA DE SOBEL: forma de obtener los bordes de una imagen a través de
%una transformación matricial.
sx = [-1,0,1;-2,0,2;-1,0,1];
%Sy = Transpuesta(Sx), Sx = [-1,-2,-1;0,0,0;1,2,1];
sy = [-1,-2,-1;0,0,0;1,2,1];

%DERIVADAS PARCIALES DE LA IMAGEN CON LAS MÁSCARAS DE SOBEL: Se realizan 
%derivadas parciales porque el Gradiente de Gx utilizando la máscara de 
%Sobel enfatiza en los bordes verticales de la imagen y el Gradiente Gy 
%enfatiza en los bordes horizontales de la imagen.
%PRIMERA DERIVADA PARCIAL EN EL SENTIDO VERTICAL Y HORIZONTAL:
Ix = imfilter(Im,sx); %Gradiente horizontal, primera derivada.
Iy = imfilter(Im,sy); %Gradiente vertical, primera derivada.
%SEGUNDA DERIVADA PARCIAL EN EL SENTIDO VERTICAL Y HORIZONTAL:
Ixx = imfilter(Ix,sx); %Gradiente horizontal, segunda derivada.
Iyy = imfilter(Iy,sy); %Gradiente vertical, segunda derivada.
Ixy = imfilter(Ix,sy); %Gradiente mixto.

%FÓRMULAS DETECTOR DE ESQUINAS BEAUDET:
%Numerador de la matriz B(x,y), determinante de la matriz H.
NB = Ixx.*Iyy-(Ixy).^2;
%Denominador de la matriz B(x,y).
DB = (1+Ix.*Ix+Iy.*Iy).^2;
%Matriz B(X,Y).
B = (NB./DB);
%Escala de la matriz.
B = (1000/max(max(B)))*B;
%Binarización para crear la matriz V1 con un Umbral de U = 10.
V1 = (B)>10;
pixel = 10;     %Número de pixeles que rodean al pixel central.

%ANÁLISIS DE LOS PIXELES DE LA VECINDAD PARA ENCONTRAR ESQUINAS:
%size(): Comando que devuelve el número de filas y columnas de una matriz 
%en ese orden.
[filas, columnas] = size(V1);
%zeros(filas, columnas): Método que crea una matriz vacía, llenándola de 
%puros ceros, esta matriz almacenará las posiciones de la imagen donde
%exista una esquina.
res = zeros(filas, columnas);
for r = 1:filas
    for c = 1:columnas
        if (V1(r,c))
            I1 = [r-pixel, 1];          %Limite Izquierdo
            I2 = [r+pixel, filas];      %Limite derecho
            I3 = [c-pixel, 1];          %Limite Superior
            I4 = [c+pixel, columnas];   %Limite Inferior
            %max(): Método que devuelve el valor máximo de una matriz o
            %vector.
            %min(): Método que devuelve el valor mínimo de una matriz o
            %vector.
            MaxXi = max(I1);            %Valor máximo del límite izq.
            MaxXd = min(I2);            %Valor mínimo del límite der.
            MaxYs = max(I3);            %Valor máximo del límite superior.
            MaxYi = min(I4);            %Valor mínimo del límite inferior.
            
            %Las esquinas son las que tendrán los valores máximos o mínimos
            %en las derivadas parciales porque es donde se da un cambio
            %brusco en los bordes y recordemos que la derivada da la razón
            %de cambio de una curva, por eso la matriz tmp se crea con los
            %valores máximos y mínimos para conocer la ubicación de las
            %esquinas.
            tmp = B(MaxXi:MaxXd, MaxYs:MaxYi);
            maxim = max(max(tmp));
            if (B(r,c)== maxim)
                res(r,c)=1;
            end
        end
    end 
end

%IMAGEN CON EL FILTRO DE LA MATRIZ 1/9:
figure(1), imshow(uint8(Im))
title('Imagen Con Filtro de la Matriz 1/9 - Matriz 2D')
%IMAGEN CON LAS ESQUINAS REPRESENTADAS CON TACHES: La transpuesta de la 
%matriz res que considera los valores máximos o mínimos de la derivada del 
%borde nos da como resultado la posición de las esquinas y las pinta en la 
%imagen original.
figure(2), imshow(uint8(IMA));
hold on
[re,co] = find(res');
plot(re, co, '+ r');
hold off
title('Imagen Original con Esquinas - Detector Baudet - Cubo Matricial 3D')