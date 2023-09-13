clc
clear all
close all

%SUAVIZADO DE IMÁGENES - Filtro Promediador: Este lo que hace es difuminar, 
%si se aplica a una imagen con una Máscara de Sobel que reconoce bordes, 
%puede elegirse un tamaño de filtro en específico para que solamente se 
%reconozcan los bordes que nos sirvan, en vez de reconocerlos todos.

%imread(): comando para leer una imagen y convertirla a matrices de 3 
%dimensiones, que prácticamente se ve como un cubo, del cubo de colores se 
%obtienen 3 capas, osea 3 matrices una encima de otra, todas con el mismo 
%número de filas y columnas, de este cubo se extraen las distintas capas 
%para obtener los colores RGB.
IMA = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\Yo merengues.jpg');
%rgb2gray(): Comando que extrae el cubo matricial de la imagen obtenida con 
%imread y hace un tipo de promedio con todos los colores para obtener una 
%escala de grises que no le da prioridad a ningún color R, G o B en 
%específico.
f = double(rgb2gray(IMA));

%Dimensionamiento de la matriz obtenida: Con el método size aplicado a una 
%matriz cualquiera, se obtiene primero el número de filas y luego el
%número de columnas.
[filas, columnas] = size(f);

%FILTRO PROMEDIADOR:
%Cuando un pixel llega a presentar una diferencia en comparación con los 
%tonos RGB o grises de sus pixeles próximos, se identifica eso como un 
%factor de ruido, el suavizado lo que hace es realizar una convolución de 
%un pixel junto con sus pixeles próximos, que son los pixeles de arriba, 
%abajo, a un lado y a el otro, estos son analizados y llamados vecindad, lo 
%que pasará es que se tratará de corregir y quitar esos pixeles que tienen 
%ruido, esto se aplica a todos los pixeles que conforman la imagen, se hace 
%siguiendo la fórmula descrita a continuación, donde A es la matriz que 
%describe la imagen original y T es el tamaño del filtro que se quiere 
%aplicar:
%h = (1/T^2)*Σ(A)
%Los filtros deben ser de tamaño impar para que el pixel que se está
%analizando quede en el centro de la vecindad.

%Para ello se debe extraer de la matriz f (que es la escala de grises de la
%imagen original) pequeñas partes de 3X3 para poder aplicar el filtro h, se
%indica que parta desde la posición 2 hasta el número de filas y columnas
%-1 porque el número de inicio es el centro de la matriz y de ahí parte a 
%sus demás coordenadas, ya que los demás pixeles que se analizan deben 
%tener el mismo tamaño del filtro, por eso es que se le resta cierto valor 
%a las filas y columnas del bucle, como se ve en los siguientes tamaños de 
%filtro:
%T = 3, inicio:2, final: filas-1
%T = 5, inicio:3, final: filas-2
%T = 7, inicio:4, final: filas-3
%Para obtener esta relación en el inicio y el final se usan las fórmuas:
%T = tamaño filtro, inicio: (T+1)/2, final: (T-1)/2
%Para probar varios filtros se crea un bucle for que pruebe varios valores
%de T y vaya de 2 en 2.
for T = 3:2:35
    h = (1/T^2)*ones(T);
    for i = (T+1)/2:filas-(T-1)/2
        for j = (T+1)/2:columnas-(T-1)/2
            %Extracción de las submatrices para que el filtro pueda tener
            %cualquier tamaño, se hace lo mismo que se hizo en los límites 
            %del bucle, pero solo en las partes donde hay una suma o resta.
            I = f(i-(T-1)/2:i+(T-1)/2, j-(T-1)/2:j+(T-1)/2);
            %De la siguiente manera ya que se hayan obtenido las 
            %submatrices de la matriz original que describe la imagen, 
            %simplemente se multiplica por el filtro h cada una de ellas, 
            %a esto se le aplica convolución para obtener un solo dato de 
            %cada pixel.
            g(i-1,j-1) = sum(sum(I.*h));
        end
    end
    
    %MÁSCARA DE SOBEL: Obtención de bordes.
    %Es importante aplicar la Máscara de Sobel hasta después de haber 
    %aplicado el Filtro Promediador para no afectar la resolución del 
    %resultado y eliminar de mejor manera el ruido de la imagen original, 
    %ya que en la imagen donde ya se aplicó la máscara, el borde es 
    %resaltado y puede ser considerado erróneamente como ruido por el 
    %filtro.
    figure(1), imshow(uint8(n1_MASCARA_SOBEL(g)))
    title(strcat('Suavizado - Filtro Promediador: Tamaño T=', num2str(T)))
    %drawnow se usa para mostrar una animación respecto a alguna variable 
    %del bucle for, en este caso la variable R.
    drawnow
end
%IMAGEN EN ESCALA DE GRISES:
figure(2), imshow(uint8(f))
title('Imagen en Escala de Grises - Matriz 2D')

%Si a la imagen que tiene el Filtro Promediador se le aplica la Máscara de 
%Sobel que identifica bordes, el resultado es una imagen donde los bordes 
%ya no se ven tan remarcados en algunas zonas, esto lo que hace es 
%disminuir el ruido y pasa porque las máscaras de Sobel, Prewitt y 
%Gradiente son derivadas, por eso es que ellas exageran razgos de la imagen 
%sin control, pero con el suavizado de imagenes estos razgos se suavizan.
figure(3), imshow(uint8(n1_MASCARA_SOBEL(f)))
title('Bordes - Máscara de Sobel G')
figure(4), imshow(uint8(n1_MASCARA_SOBEL(g)))
title('Bordes y Suavizado - Máscara de Sobel G y Filtro Promediador')

%El filtro Promediador tiene como característica principal que es el que
%más difumina la imagen después de haber sido aplicado, por lo cual la 
%imagen se puede ver demasiado borrosa cuando este se usa, lo que lo hace 
%el peor de los 3 filtros que se pueden utilizar.