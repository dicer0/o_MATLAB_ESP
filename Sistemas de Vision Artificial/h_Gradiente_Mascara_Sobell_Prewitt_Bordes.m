clc
clear all
close all

%COMPARACIÓN DE LA OBTENCIÓN DE BORDES DE UNA IMAGEN POR MEDIO DE GRADIENTE
%(DERIVACIÓN), MÁSCARA DE SOBEL Y MÁSCARA DE PREWITT:

%imread(): Comando para leer una imagen y convertirla a matrices de 3
%dimensiones, que prácticamente se ve como un cubo, del cubo de colores se 
%tienen 3 capas, osea 3 matrices una encima de otra, todas con el mismo
%número de filas y columnas, de este cubo se extraen las distintas capas
%para obtener los colores RGB.
IMA = imread('C:\Users\diego\OneDrive\Documents\Instrumentación Virtual\Sistemas de Visión Artificial\Imagenes\Lena.jpg');
figure(1), imshow(IMA)          %Impresión de imagen original.
title('Imagen Original RGB - Cubo Matricial 3D')
f = double(rgb2gray(IMA));      %Conversión a escala de grises (matriz 2D).
[filas, columnas] = size(f);    %Dimensionamiento de la matriz 2D.




%GRADIENTE O DERIVACIÓN DE LA IMAGEN: Se obtiene a partir de la fórmula del
%gradiente aplicada a una función f(x,y) donde el incremento es de 1 pixel,
%al aplicarse se obtiene el gradiente de x Gx y el gradiente de y Gy.
dx = 1;     %dx = Δx; Incremento de 1 en 1.
dy = 1;     %dy = Δy; Incremento de 1 en 1.
for y=2:columnas-1
    for x=2:filas-1        
        %Gx = f(x+Δx,y(cte))-f(x-Δx,y(cte))/Δx
        Gx_D(x,y) = (f(x+dx,y)-f(x-dx,y))/(2*dx);
        %Gy = f(x(cte),y+Δy)-f(x(cte),y-Δy)/Δx
        Gy_D(x,y) = (f(x,y+dy)-f(x,y-dy))/(2*dy);
        %G = √Gx^2+Gy^2
        G_D(x,y) = sqrt(Gx_D(x,y)^2+Gy_D(x,y)^2);
    end
end
%Borde con Gráfica 3D del Gradiente G: Gx y Gy juntas.
figure(2), mesh(G_D)
title('Bordes - Derivación G - Visión 3D con Comando mesh')
%Cuando apenas va a entrar a un borde se crea la parte positiva de la
%gráfica 3D Gx, pero cuando sale de ese borde y continúa con la imagen se
%crea la parte negativa de la función 3D Gx, para poder ver ambos valores
%en vez de eliminar la parte negativa conviertiendo la gráfica con dos 
%variables a un número entero de 8 bits con uint8(), se debe aplicar el 
%método abs() para aplicar el absoluto de la función Gx, que se le llama 
%borde doble en visión artificial, donde se ven más remarcados los bordes.

%Derivadas de Gradiente G, Gradiente Gx y Gradiente Gy mostradas a la vez.
%Gradiente Gx: Enfatiza en los bordes horizontales de la imagen. 
%Gradiente Gy: Enfatiza en los bordes verticales de la imagen.
figure(3), imshow([(uint8(G_D)),(uint8(abs(Gx_D))),(uint8(abs(Gy_D)))])
title('Bordes - Derivación G, Gx y Gy - Visión Plana')




%MÁSCARA DE SOBEL: forma de obtener los bordes de una imagen a través de
%una transformación matricial.
Sx = [-1,-2,-1;0,0,0;1,2,1];
%Sy = Transpuesta(Sx), Sx = [-1,-2,-1;0,0,0;1,2,1];
Sy = [-1,0,1;-2,0,2;-1,0,1];
for i = 2:filas-1
    for j = 2:columnas-1
        Gx_MS(i-1,j-1) = sum(sum(f(i-1:i+1, j-1:j+1).*Sx));
        Gy_MS(i-1,j-1) = sum(sum(f(i-1:i+1, j-1:j+1).*Sy));
        %G = √Gx^2+Gy^2
        G_MS(i-1,j-1) = sqrt(Gx_MS(i-1,j-1).^2+Gy_MS(i-1,j-1).^2);
    end
end
%Borde con Gráfica 3D de la máscara de Sobel G: Gx y Gy juntas.
figure(4), mesh(G_MS)
title('Bordes - Máscara de Sobel G - Visión 3D con Comando mesh')
%Máscara de Sobel con Gradiente G, Gradiente Gx y Gradiente Gy mostradas a 
%la vez.
%Borde doble de la máscara de Sobel Gx.
%Borde doble de la máscara de Sobel Gy.
figure(5), imshow([(uint8(G_MS)),(uint8(abs(Gx_MS))),(uint8(abs(Gy_MS)))])
title('Bordes - Máscara de Sobel G, Gx y Gy - Visión Plana')



%MÁSCARA DE PREWITT: Es básicamente igual que la máscara de Sobel pero su
%matriz de transformación es distinta a la de Sobel.
Px = [-1,-1,-1;0,0,0;1,1,1];
%Py = Transpuesta(Px).
Py = [-1,0,1;-1,0,1;-1,0,1];
%La fórmula es la misma que la máscara de Sobel pero multiplicándola por la
%matriz de transformación de Prewitt.
for i = 2:filas-1
    for j = 2:columnas-1
        Gx_MP(i-1,j-1) = sum(sum(f(i-1:i+1, j-1:j+1).*Px));
        Gy_MP(i-1,j-1) = sum(sum(f(i-1:i+1, j-1:j+1).*Py));
        %G = √Gx^2+Gy^2
        G_MP(i-1,j-1) = sqrt(Gx_MP(i-1,j-1).^2+Gy_MP(i-1,j-1).^2);
    end
end
%Borde con Gráfica 3D de la máscara de Prewitt Gx y Gy juntas
figure(6), mesh(G_MP)
title('Bordes - Máscara de Prewitt G - Visión 3D con Comando mesh')
%Máscara de Prewitt con Gradiente G, Gradiente Gx y Gradiente Gy mostradas 
%a la vez.
%Borde doble de la máscara de Prewitt Gx
%Borde doble de la máscara de Prewitt Gy
figure(7), imshow([(uint8(G_MP)),(uint8(abs(Gx_MP))),(uint8(abs(Gy_MP)))])
title('Bordes - Máscara de Prewitt G, Gx y Gy - Visión Plana')

%COMPARACIÓN DE BORDES:
%subplot(filas, columnas, posición): Método que crea una ventana con
%múltiples elementos que puedo acomodar al gusto.
figure (8)
subplot(3,1,1), imshow([(uint8(G_D)),(uint8(abs(Gx_D))),(uint8(abs(Gy_D)))])
title('Bordes - Derivación G, Gx y Gy - Visión Plana')
subplot(3,1,2), imshow([(uint8(G_MS)),(uint8(abs(Gx_MS))),(uint8(abs(Gy_MS)))])
title('Bordes - Máscara de Sobel G, Gx y Gy - Visión Plana')
subplot(3,1,3), imshow([(uint8(G_MP)),(uint8(abs(Gx_MP))),(uint8(abs(Gy_MP)))])
title('Bordes - Máscara de Prewitt G, Gx y Gy - Visión Plana')