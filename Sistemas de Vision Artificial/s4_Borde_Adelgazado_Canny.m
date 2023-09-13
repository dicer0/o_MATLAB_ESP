clc
clear all
close all

%GRADIENTE DE CANNY: Sirve para cerrar y adelgazar los bordes de la figura 
%analizada en la imagen, evitando así posibles errores durante la
%identificación de figuras al aplicar visión artificial, ya que mientras
%más delgado sea el borde, mejor lo podrá analizar el programa, de tal
%forma que pueda obtener hasta su firma.
IMA = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\6_BordesCanny\5.jpg');
%rgb2gray(): Comando que extrae el cubo matricial de la imagen obtenida con 
%imread y hace un tipo de promedio con todos los colores para obtener una 
%escala de grises que no le da prioridad a ningún color R, G o B en 
%específico.
I=double(rgb2gray(IMA));

%FILTRO GAUSSIANO: El filtro gaussiano lo que hace es aplicar una función 
%Gaussiana discreta, donde se busca que el punto más alto de la campana de 
%Gauss (su curva) se encuentre justo en donde está el pixel central de la 
%imagen que se quiere analizar, recordemos que el tamaño T del filtro debe 
%ser impar siempre.
%La variable sigma afecta la falda de la función gaussiana, haciendo su
%curva más angosta mientras menor sea el valor de sigma y más ancha 
%mientras mayor sea el valor de sigma.
%T = 3, sig = 2 aplicado al Filtro Gaussiano.
h = p1_FILTRO_GAUSSIANO(3,2);

%FILTRO DE CANNY: Para aplicar este filtro primero se debió haber 
%aplicado el filtro Gaussiano que realiza un suavizado de la imagen y da 
%como resultado una función h que recibe también como parámetro al tamaño T 
%del filtro que debe ser impar siempre y una variable sigma que afecta la 
%falda de la función gaussiana, haciendo su curva más angosta mientras 
%menor sea su valor y más ancha mientras mayor sea su valor.
J = s1_FILTRO_CANNY(I,h);
%G: Se refiere a la magnitud del gradiente G de Canny.
%phi2: Se refiere al ángulo del gradiente phi2 de Canny.
[G,phi2] = s2_GRADIENTE_CANNY(J);

%size(): Comando que devuelve el número de filas y columnas de una matriz 
%en ese orden.
[filas, columnas] = size(phi2);

%ADELGAZAR BORDES CON EL GRADIENTE DE CANNY: Por medio de bucles se recorre
%la matriz del ángulo del Gradiente de Canny y se comparar la magnitud del 
%Gradiente de Canny en todas sus posiciones para encontrar la dirección 
%perpendicular al borde y así adelgazarlo.
for i = 2: filas-1
    for j = 2: columnas-3
        %El vector "d" es de 1 fila y 4 columnas, se crean varios vectores 
        %d para cada valor que puede adoptar el ángulo del gradiente de 
        %Canny, esto para considerar las direcciones que consideran las 
        %orientaciones de 0, 45, 90 y 135°.
        d = [cosd(phi2(i,j)-0), cosd(phi2(i,j)-45), cosd(phi2(i,j)-90), cosd(phi2(i,j)-135)];
        
        %Dependiendo de la columna del vector se realiza un switch para
        %determinar el valor de la variable de salida IN que representa la 
        %imagen con borde adelgazado.
        [b, c] = max(d);
        
        switch(c)
            %columna 1: d = 0°.
            case 1
                %Se compara la magnitud actual del Gradiente G de Canny con 
                %una posición antes y una después para determinar la salida 
                %In, ya que si G es más pequeño que al menos uno de sus 
                %vecinos en la dirección perpendicular al borde, se le 
                %asigna valor cero y sino es igual al gradiente G de Canny,
                %esto se realiza con la compuerta OR (|) y una comparación
                %del valor de G antes y después.
                if ((G(i, j)<G(i-1, j)) | (G(i, j)<G(i+1, j)))
                    In(i-1, j-1) = 0;
                else
                    In(i-1, j-1) = G(i, j);
                end
            %columna 2: d = 45°.
            case 2
                if ((G(i, j)<G(i-1, j-1)) | (G(i, j)<G(i+1, j+1)))
                    In(i-1, j-1) = 0;
                else
                    In(i-1, j-1) = G(i, j);
                end
            %columna 3: d = 90°.
            case 3
                if ((G(i,j)<G(i,j+1)) | (G(i,j)<G(i,j-1)))
                    In(i-1, j-1) = 0;
                else
                    In(i-1,j-1) = G(i,j);
                end
            %columna 4: d = 135°.
            otherwise
                if ((G(i,j)<G(i-1,j+1)) | (G(i,j)<G(i+1,j-1)))
                    In(i-1,j-1) = 0;
                else
                    In(i-1,j-1) = G(i,j);
                end
        end %Fin del switch
    end %Fin del for que recorre las columnas de la matriz phi2.
end %Fin del for que recorre las filas de la matriz phi2.

%IMAGEN ORIGINAL:
figure(1), imshow(uint8(I))
title('Imagen Original RGB - Cubo Matricial 3D')
%IMAGEN DESPUÉS DE HABER APLICADO EL SUAVIZADO GAUSSIANO Y CANNY:
figure(2), imshow(uint8(J))
title('Imagen Con Suavizado Gaussiano y Canny - Matriz 2D')
%IMAGEN DESPUÉS DEL SUAVIZADO DE CANNY (MAGNITUD Y ÁNGULO):
figure(3), mesh(phi2)
title('Bordes - Ángulo Gradiente Canny - Visión 3D con Comando mesh')
figure(4), imshow(3*uint8(G))
title('Bordes - Magnitud Gradiente Canny - Visión Plana')
%IMAGEN CON EL BORDE ADELGAZADO DE CANNY:
figure(5), imshow(uint8(In))
title('Imagen Con Borde Adelgazado Canny - Matriz 2D')