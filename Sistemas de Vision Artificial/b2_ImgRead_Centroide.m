clc
clear all
close all

%El comando imread lo que hace es almacenar una imagen en una variable 
%llamada IMA, la imagen de Bulbasaur en específico muestra mucho el color 
%VERDE, que es uno de los colores primarios RGB.
IMA=imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\Bulbasaur.jpeg');
%Con imshow lo que hacemos es mostrar la imagen almacenada en la variable
%IMA en un figure.
figure(1), imshow(IMA)
title('Imagen Original RGB - Cubo Matricial 3D')
%Con el siguiente código se extrae una capa de la variable IMA donde está 
%almacenada la imagen. Es importante mencionar que las imágenes digitales 
%son literal un cubo matricial de 3 dimensiones, cada dimensión o capa es 
%una matriz 2D donde en cada lugar de su matriz tiene un valor de 0 a 255 
%que describe el tono de ese color primario en específico, el tamaño de las 
%matrices 2D de cada capa dependen de la resolución en pixeles de la imagen 
%y al separar cada capa se puede almacenar en distintas variables R, G y B.
%Si por ejemplo al graficar la capa R de la imagen esta aparece mayormente 
%negra es porque casi no existen tonos del color ROJO en la imagen 
%original, si en cambio la imagen se mutesra muy blanca es porque está 
%demasiado presente el color ROJO en la imagen original.
R = IMA(:,:,1);
figure(2), imshow(R)
title('Capa R - Matriz 2D')
%Si la imagen aparece negra porque casi no se encuentran tonos del color 
%VERDE en la imagen original, si aparece blanca es porque está muy presente 
%el color VERDE en la imagen original.
G = IMA(:,:,2);
figure(3), imshow(G)
title('Capa G - Matriz 2D')
%Si la imagen aparece negra porque casi no se encuentran tonos del color 
%AZUL en la imagen original, si aparece blanca es porque está muy presente 
%el color AZUL en la imagen original.
B = IMA(:,:,3);
figure(4), imshow(B)
title('Capa B - Matriz 2D')


%El comando imread lo que hace es almacenar una imagen en una variable 
%llamada IMA, la imagen de Charmander en específico muestra mucho el color 
%ROJO, que es uno de los colores primarios RGB.
IMA=imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\Charmander.jpeg');
%Con imshow lo que hacemos es mostrar la imagen almacenada en la variable
%IMA en un figure.
figure(5), imshow(IMA)
title('Imagen Original RGB - Cubo Matricial 3D')
%Con las siguientes líneas de código se extrae cada capa de la variable IMA 
%y las almacenamos en las variables R, G y B.
%Si la imagen aparece negra porque casi no se encuentran tonos del color 
%ROJO en la imagen original, si aparece blanca es porque está muy presente 
%el color ROJO en la imagen original.
R = IMA(:,:,1);
figure(6), imshow(R)
title('Capa R - Matriz 2D')
%Si la imagen aparece negra porque casi no se encuentran tonos del color 
%VERDE en la imagen original, si aparece blanca es porque está muy presente 
%el color VERDE en la imagen original.
G = IMA(:,:,2);
figure(7), imshow(G)
title('Capa G - Matriz 2D')
%Si la imagen aparece negra porque casi no se encuentran tonos del color 
%AZUL en la imagen original, si aparece blanca es porque está muy presente 
%el color AZUL en la imagen original.
B = IMA(:,:,3);
figure(8), imshow(B)
title('Capa B - Matriz 2D')


%El comando imread lo que hace es almacenar una imagen en una variable 
%llamada IMA, la imagen de Squirtle en específico muestra mucho el color 
%AZUL, que es uno de los colores primarios RGB.
IMA=imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\Squirtle.jpeg');
%Con imshow lo que hacemos es mostrar la imagen almacenada en la variable
%IMA en un figure.
figure(9), imshow(IMA)
title('Imagen Original RGB - Cubo Matricial 3D')
%Con las siguientes líneas de código se extrae cada capa de la variable IMA 
%y las almacenamos en las variables R, G y B.
%Si la imagen aparece negra porque casi no se encuentran tonos del color 
%ROJO en la imagen original, si aparece blanca es porque está muy presente 
%el color ROJO en la imagen original.
R = IMA(:,:,1);
figure(10), imshow(R)
title('Capa R - Matriz 2D')
%Si la imagen aparece negra porque casi no se encuentran tonos del color 
%VERDE en la imagen original, si aparece blanca es porque está muy presente 
%el color VERDE en la imagen original.
G = IMA(:,:,2);
figure(11), imshow(G)
title('Capa G - Matriz 2D')
%Si la imagen aparece negra porque casi no se encuentran tonos del color 
%AZUL en la imagen original, si aparece blanca es porque está muy presente 
%el color AZUL en la imagen original.
B = IMA(:,:,3);
figure(12), imshow(B)
title('Capa B - Matriz 2D')






%EXTRAER LAS CAPAS DE UNA IMAGEN:
IMA = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\1.jpg');
%Existe un código de color llamado hsv, este es el mejor aliado de la 
%visión artificial porque la luz es un factor que hay que vencer para que 
%se pueda hacer un buen analisis de visión artificial, el control de luz se 
%puede hacer por medio de una caja de huevo en forma austera.
figure(13), imshow(IMA)
title('Imagen Original RGB - Cubo Matricial 3D')
%El código hsv ayuda con la luminosidad de las imágenes, para ello también 
%hay que umbralizar.
%Si la imagen aparece negra porque casi no se encuentran tonos del color 
%ROJO en la imagen original, si aparece blanca es porque está muy presente 
%el color ROJO en la imagen original.
R = IMA(:,:,1);
figure(14), imshow(R)
title('Capa R - Matriz 2D')
%Si la imagen aparece negra porque casi no se encuentran tonos del color 
%VERDE en la imagen original, si aparece blanca es porque está muy presente 
%el color VERDE en la imagen original.
G = IMA(:,:,2);
figure(15), imshow(G)
title('Capa G - Matriz 2D')
%Si la imagen aparece negra porque casi no se encuentran tonos del color 
%AZUL en la imagen original, si aparece blanca es porque está muy presente 
%el color AZUL en la imagen original.
B = IMA(:,:,3);
figure(16), imshow(B)
title('Capa B - Matriz 2D')
%Vamos a elegir la matriz de la capa que más se aleje del fondo, osea la 
%que haga que la figura resalte más del color que se vea en el fondo de la 
%imagen, ese en este caso es el vector B de los azules.




%BINARIZAR UNA IMAGEN PARA SEPARAR UN OBJETO DE SU FONDO:
%Ya que se haya extraido la capa de una imagen que más separe el fondo de
%la figura que se quiera identificar, se debe conocer las filas, columnas y
%capas de la imagen que queremos analizar para después ejecutar bucles for
%que analicen cada posición de las matrices de la capa elegida.
[FILAS,COLUMNAS,CAPAS]=size(IMA);
%El proceso de separar una figura de su fondo en colores blanco y negro se 
%llama binarización, esto se hace considerando un valor de umbral U que 
%puede ir de 0 a 255 y se encuentra al hacer varias iteraciones hasta 
%encontrar el óptimo o nos podemos dar una idea con los valores que 
%aparezcan en el histograma de la imagen, pero solamente después de haber 
%transformado la imagen a su escala de grises (extrayendo una capa), 
%a partir del umbral se binariza la imagen, dando un valor de 0 (negro) a 
%los bits de la imagen cuando sean mayores al umbral, osea que sean el 
%fondo y un valor de 1 (blanco) cuando sean menores, osea que sean la 
%figura a separar. Normalmente esto se hace con bucles for, considerando 
%que se realiza a las columnas y filas de la matriz que representa la capa 
%de la imagen en escala de grises extraida de la imagen original.
U = 45; %En este primer ejemplo el umbral se encontró al probar varios.
for i=1:FILAS
    for j=1:COLUMNAS
        if(B(i,j)<=U)
            %Para que además podamos calcular el valor del centroide de la 
            %figura en la imagen, el valor del color blanco en donde se 
            %encuentre la figura no se ponga con valores muy altos de 255, 
            %lo que se hará es poner que el color blanco sea 1 y después 
            %del bucle for se multiplicará la función uint8(f) por 255, 
            %teniendo así como resultado el color blanco al mostrar la 
            %imagen.
            %f(i,j)=255;
            f(i,j)=1;
        else
            f(i,j)=0;
        end
    end
end
figure(17), imshow(255*uint8(f))
title('Binarización de Imagen - Método Bucle for - Matriz 2D')
%Esta es otra manera de binarizar una imagen respecto a un umbral con 
%alguna de las capas RGB de alguna imagen sin usar bucles for.
G=(B<=U);
figure(18), imshow(255*uint8(G))
title('Binarización de Imagen - Método Comparación - Matriz 2D')




%ENCONTRAR EL CENTROIDE DE UNA FIGURA: 
%El centroide de una figura es su punto geométrico central y por medio de 
%la visión artificial se puede encontrar el centroide de la figura de una 
%imagen que hayamos binarizado, para eso se usan las fórmulas generales 
%del centroide, pero aplicada a los vectores que describan el número total 
%de columnas que describen el tamaño horizontal de la imagen "x" y el 
%tamaño de filas que indican el tamaño vertical de la imagen "y", la 
%fórmula del centroide se debe empezar en 1 y terminar hasta el final de su
%tamaño, a continuación se describen las fórmulas:
%centroide_x = Σf(x)*x/Σf(x)
x=[1:COLUMNAS];
%centroide_y = Σf(y)*y/Σf(y)
y=[1:FILAS];
%sum(A): El operador lo que hace es sumar todos los números de las columnas
%del vector A, en este caso se aplica a f porque se está analizando la
%imagen binarizada, el segundo parámetro solo se usa cuando se aplica a 
%matrices y se refiere a que dimensión se va a aplicar la suma, 1 se 
%refiere a las columnas de la matriz, osea "x", mientras que 2 se refiere a 
%las filas de la matriz, osea "y".
fx=sum(f,1);
fy=sum(f,2)';
figure(19), plot(fx)
title('Graficación Puntos Tentativos Centroide fx')
figure(20), plot(fy)
title('Graficación Puntos Tentativos Centroide fy')
%centroide_x=Σf(y)*y/Σf(y) = 482.7213
cy=sum(x.*fx)/sum(fx)
%centroide_y=Σf(x)*x/Σf(x) = 212.9681
cx=sum(y.*fy)/sum(fy)

%PINTAR UNA FIGURA EN UNA IMAGEN:
%Con la siguiente instrucción podemos pintar en la imagen mostrada un 
%cuadrado que vaya del pixel 115 al 315 en el eje horizontal y del 215 al 
%315 en el eje vertical, podemos hacer que sea de color negro, dándole un 
%valor de 0, ya que la variable IMA que es donde se recopiló la imagen es 
%considerada una matriz, de esta manera se puede editar una imagen, 
%accediendo a sus pixeles.
IMA(115:315, 215:315) = 0;
figure(21), imshow(IMA)
title('Pintar Rectángulo en una Imagen - Matriz 3D')

%PINTAR EN EL CENTROIDE DE UNA FIGURA:
%Ya después de haber calculado el centroide de una figura, este se puede
%pintar en su imagen original para mostrar su centroide, cuando se hace
%esto se deben usar números entreros para pintar en una imagen, por ello se
%van a convertir a números enteros de 16 bits por medio de la operación
%uint16(), que puede tener números enteros de 0 a 65,535.
figure(22), plot(cx,cy,'ko')
title('Graficación del Centroide (cx, cy)')
cx_int = uint16(cx);    %Centroide x en números enteros.
ancho_c= 4/2;           %Ancho del cuadrado del centroide en x.
cy_int = uint16(cy);    %Centroide y en números enteros.
alto_c= 2;              %Alto del cuadrado del centroide en y.
IMA(cx_int-ancho_c : cx_int+ancho_c, cy_int-alto_c:cy_int+alto_c) = 255;
figure(23), imshow(IMA)
title('Pintar Centroide en una Imagen - Matriz 3D')