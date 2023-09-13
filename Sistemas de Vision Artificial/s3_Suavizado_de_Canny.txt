clc
clear all
close all

%SUAVIZADO DE CANNY: Es el mejor método que existe para encontrar los
%bordes de una figura en una imagen después de haberla suavizado 
%previamente por medio del Filtro Gaussiano.
IMA = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\6_BordesCanny\1.jpg');
%rgb2gray(): Comando que extrae el cubo matricial de la imagen obtenida con 
%imread y hace un tipo de promedio con todos los colores para obtener una 
%escala de grises que no le da prioridad a ningún color R, G o B en 
%específico.
I = double(rgb2gray(IMA)); %Imagen original convertida a escala de grises.

%FILTRO GAUSSIANO: El filtro gaussiano lo que hace es aplicar una función 
%Gaussiana discreta, donde se busca que el punto más alto de la campana de 
%Gauss (su curva) se encuentre justo en donde está el pixel central de la 
%imagen que se quiere analizar, recordemos que el tamaño T del filtro debe 
%ser impar siempre.
%La variable sigma afecta la falda de la función gaussiana, haciendo su
%curva más angosta mientras menor sea el valor de sigma y más ancha 
%mientras mayor sea el valor de sigma.
%T = 11, sig = 2 aplicado al Filtro Gaussiano.
h = p1_FILTRO_GAUSSIANO(11, 2);

%FILTRO CANNY: Para aplicar este filtro primero se debió haber aplicado el 
%filtro Gaussiano que realiza un suavizado de la imagen y da como resultado
%una función h que recibe también como parámetro al tamaño T del filtro que 
%debe ser impar siempre y una variable sigma que afecta la falda de la 
%función gaussiana, haciendo su curva más angosta mientras menor sea su 
%valor y más ancha mientras mayor sea su valor.
J = s1_FILTRO_CANNY(I, h);

%GRADIENTE DE CANNY: El Gradiente de Canny se encuentra después de haber 
%aplicado primero el filtro Gaussiano que realiza un suavizado de la imagen 
%y después el filtro de Canny.
[G, phi2] = s2_GRADIENTE_CANNY(J);

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
