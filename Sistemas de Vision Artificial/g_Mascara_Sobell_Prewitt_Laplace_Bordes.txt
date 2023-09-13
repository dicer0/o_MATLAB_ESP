clc
clear all
close all

%OBTENCIÓN DE BORDES: La obtención de bordes de una imagen se puede 
%realizar a través de su derivación, o a través de la aplicación de 
%máscaras, donde se considera el concepto de vecindad de pixeles que es a 
%donde se aplica la máscara, esto se puede realizar porque las imagenes se
%consideran como funciones de dos variables f(x,y).

%El comando imread sirve para leer una imagen y convertirla a matrices de 3
%dimensiones, que prácticamente se ve como un cubo, del cubo de colores se 
%tienen 3 capas, osea 3 matrices una encima de otra, todas con el mismo
%número de filas y columnas, de este cubo se extraen las distintas capas
%para obtener los colores RGB.
IMA = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\Bulbasaur.jpeg');
figure(1), imshow(IMA)
title('Imagen Original RGB - Cubo Matricial 3D')
R = IMA(:,:,1);%Capa (matriz) R extraida del cubo matricial RGB.
G = IMA(:,:,2);%Capa (matriz) G extraida del cubo matricial RGB.
B = IMA(:,:,3);%Capa (matriz) B extraida del cubo matricial RGB.

%El comando rgb2gray extrae el cubo matricial de la imagen obtenida con
%imread  y hace un tipo de promedio con todos los colores para obtener una
%escala de grises que no le da prioridad a ningún color R, G o B en
%específico, se convierte a double para que se pueda realizar operaciones
%con él y al final se obtiene una matriz 2D de escala de grises.
f = double(rgb2gray(IMA));      
figure(2), imshow([R,G,B])      %Capas R, G y B mostradas a la vez.
title('Capas R, G y B - Matrices 2D')
figure(3), imshow(uint8(f))     %Escala de grises.
title('Escala de Grises - Matriz 2D')
%Se convierte a escala de grises porque es más sencillo analizar una matriz
%2D a una matriz 3D, no tanto por su representación de colores como se
%hacía anteriormente con las capas RGB.

%Dimensionamiento de la matriz obtenida, solo se saca de una de las
%capas de la imagen porque estas deben ser del mismo tamaño todas y se
%guardan en las variables filas y columnas obtenidas con el método size
%aplicado a la matriz R que primero devuelve el número de filas y luego el
%número de columnas, todas las capas RGB son matrices de cierto tamaño
%obtenidas de la imagen con el método imread, el cual devuelve una matriza 
%en forma de cubo con 3 capas, de esta se deben extraer los datos para
%colocarlas en un vector y puedan ser graficadas.
[filas, columnas] = size(f);




%MÁSCARA DE SOBEL:
%La máscara de SOBEL es un operador muy utilizado en visión artificial y lo
%que hace es considerar dos matrices, las cuales se llaman máscaras, estas
%matrices Δx = Sx y Δy = Sy son de 3X3 y se aplican en torno a un pixel 
%central, el cual es el elemento de análisis y a los elementos que lo 
%rodean se les llama vecindad, el pixel central tiene la coordenada i,j y a 
%partir de ese punto se dan las coordenadas de los elementos de la 
%vecindad, siendo las filas de abajo las coordenadas i+1 y las de arriba 
%i-1 y siendo las columnas de la izquierda j-1 y las de la derecha j+1, la 
%siguente matriz se crea a partir de la columna j+1 de la anterior y así se 
%van creando las demás respectivamente.
%El pixel central que se encuentra en el centro de las matrices 3X3 de la
%máscara de Sobel se describe con una función x1(τ) y x2(t-τ) el cual es un
%elemento que se encuentra rotado y con un desplazamiento, intercambiando
%las filas y columnas de la matriz original entre sí. Luego se aplica
%convolución por lo que ambos elementos x1(τ) y x2(t-τ) deben ser
%multiplicados.

%La máscara de Sobel lo que hace es volver cero los elementos centrales y 
%volver la primera fila el negativo de la última con los valores 
%matriciales descritos:
Sx = [-1,-2,-1;0,0,0;1,2,1];

%Así como anteriormente se podía hacer la derivada respecto a x, donde se 
%enfatiza en los bordes horizontales de la imagen, al utilizar Sx se 
%obtiene Gx:
for i = 2:filas-1
    %Se indica que i empiece desde 2 para que al hacer la resta de la
    %derivada el resultado no sea cero cuando i = 1, además se pone el
    %límite superior de filas-1 porque al llegar a la última posición de la
    %imagen el programa le estará pidiendo que llegue a una posición extra
    %y esta no existe, esto se hace con las filas y las columnas del bucle.
    for j = 2:columnas-1
        %Creación de las filas de la vecindad superior (i-1) e inferior 
        %(i+1) y de las columnas de la vecindad izquierda (j-1) y derecha
        %(j+1), a estas se les aplica la máscara de Sobel y se considera
        %una sumatoria de todas ellas, sustituyendo a la integral que se
        %tendría que hacer, para ello se coloca el comando sum() aplicado a
        %toda la matriz, pero como se quiere tener un solo resultado
        %numérico en vez de tener varios valores por cada columna, se
        %aplica otro método sum al primero para que sume el valor de la
        %suma de todas las columnas, que es como una integral doble porque
        %se tiene dos dimensiones en la función, esto se guarda en el
        %gradiente Gx considerando las posiciones fila superior y columna
        %izquierda respecto al pixel central x1(τ).
        Gx(i-1,j-1)=sum(sum(f(i-1:i+1, j-1:j+1).*Sx));
    end
end

%La función Gx(x,y) de dos variables se grafica en 3D con el método mesh(),
%esto muestra una gráfica 3D que al moverla podemos ver que es la misma
%imagen original.
figure(4), mesh(Gx)
title('Bordes - Máscara de Sobel Gx - Visión 3D con Comando mesh')

%Con el comando imshow mostramos las capas de la imagen en forma de una
%nueva imagen considerando sus colores RGB, el resultado de esta operación 
%por sí sola con la máscara de Sobel es una imagen muy ruidosa aplicando
%solamente la máscara Sx = [-1,-2,-1;0,0,0;1,2,1]; para ello es que se usa
%además la máscara de Prewitt que es muy parecida pero tiene unidades 
%distintas a la de Sobel. Además podemos mencionar que la imagen obtenida
%se ve muy saturada debido a que los valores de Gx en el mesh se puede ver
%que tienen valores altísimos alrededor de 1000 y recordemos que el rango
%de color va de 0 a 255, por eso se ve así de saturado.
figure(5), imshow(uint8(Gx))        %Borde simple: Máscara de Sobel Gx.
title('Bordes - Máscara de Sobel Gx - Visión Plana')

%Cuando apenas va a entrar a un borde se crea la parte positiva de la
%gráfica 3D Gx, pero cuando sale de ese borde y continúa con la imagen se
%crea la parte negativa de la función 3D Gx, para poder ver ambos valores
%en vez de eliminar la parte negativa conviertiendo la gráfica con dos 
%variables a un número entero de 8 bits con uint8(), se debe aplicar el 
%método abs() para aplicar el absoluto de la función Gx, que se le llama 
%borde doble en visión artificial, donde se ven más remarcados los bordes.
figure(6), imshow(uint8(abs(Gx)))   %Borde doble: Máscara de Sobel Gx.

%Sy = Transpuesta(Sx), Sx = [-1,-2,-1;0,0,0;1,2,1];
Sy = [-1,0,1;-2,0,2;-1,0,1];
%Ahora se aplica la misma operación que con Gx pero tomando en cuenta ahora
%Sy para obtener Gy:
for i = 2:filas-1
    for j = 2:columnas-1
        Gx(i-1,j-1) = sum(sum(f(i-1:i+1, j-1:j+1).*Sx));
        Gy(i-1,j-1) = sum(sum(f(i-1:i+1, j-1:j+1).*Sy));
        %Las imágenes mostradas con GX y Gy son totalmente distintas ya 
        %que Gx enfatiza en los bordes horizontales de la imagen y Gy 
        %enfatiza en los bordes verticales, para poder ver ambos bordes 
        %unidos se unifican Gx y Gy de una forma vectorial por medio de 
        %los dos gradientes:
        %G = √Gx^2+Gy^2
        G(i-1,j-1) = sqrt(Gx(i-1,j-1).^2+Gy(i-1,j-1).^2);
    end
end

%Borde simple Máscara de Sobel Gy
figure(7), mesh(Gy)
title('Bordes - Máscara de Sobel Gy - Visión 3D con Comando mesh')
%Borde doble Máscara de Sobel Gy
figure(8), imshow(uint8(Gy))
title('Bordes - Máscara de Sobel Gy - Visión Plana')
%Borde con Máscara de Sobel Gx y Gy juntas
figure(9), imshow(uint8(abs(Gy)))
title('Bordes Dobles - Máscara de Sobel Gy - Visión Plana')
figure(10), mesh(G)
title('Bordes - Máscara de Sobel G - Visión 3D con Comando mesh')
figure(11), imshow(uint8(G))
title('Bordes - Máscara de Sobel G - Visión Plana')




%MÁSCARA DE PREWITT: Es básicamente igual que la máscara de Sobel pero su
%matriz de transformación es distinta a la de Sobel.
Px = [-1,-1,-1;0,0,0;1,1,1];
%Sy = Transpuesta(Px)
Py = [-1,0,1;-1,0,1;-1,0,1];

%La fórmula es la misma que la máscara de Sobel pero multiplicándola por la
%matriz de transformación de Prewitt
for i = 2:filas-1
    for j = 2:columnas-1
        Gx(i-1,j-1) = sum(sum(f(i-1:i+1, j-1:j+1).*Px));
        Gy(i-1,j-1) = sum(sum(f(i-1:i+1, j-1:j+1).*Py));
        %G = √Gx^2+Gy^2
        G(i-1,j-1) = sqrt(Gx(i-1,j-1).^2+Gy(i-1,j-1).^2);
    end
end

%Gráfica 3D Gx Máscara de Prewitt
figure(12), mesh(Gx)
title('Bordes - Máscara de Prewitt Gx - Visión 3D con Comando mesh')
%Borde simple Máscara de Prewitt Gx
figure(13), imshow(uint8(Gx))
title('Bordes - Máscara de Prewitt Gx - Visión Plana')
%Borde doble Máscara de Prewitt Gx
figure(14), imshow(uint8(abs(Gx)))
title('Bordes Dobles - Máscara de Prewitt Gx - Visión Plana')
%Gráfica 3D Gy Máscara de Prewitt
figure(15), mesh(Gy)
title('Bordes - Máscara de Prewitt Gy - Visión 3D con Comando mesh')
%Borde simple Máscara de Prewitt Gy
figure(16), imshow(uint8(Gy))
title('Bordes - Máscara de Prewitt Gy - Visión Plana')
%Borde doble Máscara de Prewitt Gy
figure(17), imshow(uint8(abs(Gy)))
title('Bordes Dobles - Máscara de Prewitt Gy - Visión Plana')
%Borde con Máscara de Prewitt Gx y Gy juntas
figure(18), mesh(G)
title('Bordes - Máscara de Prewitt G - Visión 3D con Comando mesh')
figure(19), imshow(uint8(G))
title('Bordes - Máscara de Prewitt G - Visión Plana')



%MÁSCARA DE LAPLACE: Es básicamente igual que la máscara de Sobel pero su
%matriz de transformación es distinta a la de Sobel.
FL = [0,1,0;1,-4,1;0,1,0];

%La fórmula es la misma que la máscara de Sobel pero multiplicándola por la
%matriz de transformación de Prewitt
for i = 2:filas-1
    for j = 2:columnas-1
        imFiltro(i-1,j-1)=sum(sum(f(i-1:i+1, j-1:j+1).*FL));
    end
end

%Gráfica 3D Gx Máscara de Laplace
figure(20), mesh(imFiltro)
title('Bordes - Máscara de Laplace - Visión 3D con Comando mesh')
%Borde simple Máscara de Prewitt Gy
figure(21), imshow(uint8(imFiltro))
title('Bordes - Máscara de Laplace - Visión Plana')
%Borde doble Máscara de Prewitt Gy
figure(22), imshow(uint8(abs(imFiltro)))
title('Bordes Dobles - Máscara de Laplace - Visión Plana')