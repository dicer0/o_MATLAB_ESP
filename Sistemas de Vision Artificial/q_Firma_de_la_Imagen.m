clc
clear all
close all

%FIRMA DE LA IMAGEN: Es un identificador de figuras simples que se obtiene 
%al encontrar su centroide, generando después una gráfica que identifique 
%la distancia del centro de la figura a sus contornos, graficando esa 
%distancia para cada punto del contorno de esa figura; por ello es que un 
%círculo tiene firma distinta a un rectángulo. 
%Para que la firma de la imagen se pueda graficar se debe contar con 
%perímetros de 1 pixel. La distancia se obtiene de forma radial desde el 
%centro de cada figura para graficarse.

%imread(): comando para leer una imagen y convertirla a matrices de 3 
%dimensiones, que prácticamente se ve como un cubo, del cubo de colores se 
%obtienen 3 capas, osea 3 matrices una encima de otra, todas con el mismo 
%número de filas y columnas, de este cubo se extraen las distintas capas 
%para obtener los colores RGB.
IMA = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\4_Firmas_de_Figuras_Simples\firma triangulo.bmp');
%rgb2gray(): Comando que extrae el cubo matricial de la imagen obtenida con 
%imread y hace un tipo de promedio con todos los colores para obtener una 
%escala de grises que no le da prioridad a ningún color R, G o B en 
%específico.
GRIS = rgb2gray(IMA);
%Binarización de la imagen: Se binariza la imagen en colores blancos y
%negros, diferenciando así una figura de su fondo en una imagen, esto se
%hace por medio de una comparación con algún tono de gris en este caso.
f = double(GRIS<127);
%Dimensionamiento de la matriz obtenida: Con el método size aplicado a una 
%matriz cualquiera, se obtiene primero el número de filas y luego el
%número de columnas.
[filas, columnas] = size(f);




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
x = [1:columnas];
%centroide_y = Σf(y)*y/Σf(y)
y = [1:filas];
%El operador sum(A) lo que hace es sumar todos los números de las columnas
%del vector A, en este caso se aplica a f porque se está analizando la
%imagen binarizada, el segundo parámetro solo se usa cuando se aplica a 
%matrices y se refiere a que dimesión se va a aplicar la suma, 1 se refiere 
%a las columnas de la matriz, osea "x" mientras que 2 se refiere a las 
%filas de la matriz, osea "y".
fx = sum(f, 1);
fy = sum(f, 2)';
%centroide_x = Σf(y)*y/Σf(y) = xc = (Σy*fy)/fy
xc = sum(y.*fy)/sum(fy)
%centroide_y = Σf(x)*x/Σf(x) = yc = (Σx*fy)/fx
yc = sum(x.*fx)/sum(fx)

%PINTAR EN EL CENTROIDE DE UNA FIGURA:
%Ya después de haber calculado el centroide de una figura, este se puede
%pintar en su imagen original para mostrar su centroide, cuando se hace
%esto se deben usar números entreros para pintar en una imagen, por ello se
%van a convertir a números enteros de 16 bits por medio de la operación
%uint16(), que puede tener números enteros de 0 a 65,535.
f(uint16(xc), uint16(yc)) = 1;

%Código cadena: Lo que hace es analizar un pixel y a su vecindad, osea
%a sus pixeles vecinos, que estén arriba, a la izq, derecha, abajo,
%etc. 
%Barrido de la imagen hasta que detecte el primer punto de color blanco.
for i=1: filas %Filas de pixeles de toda la imagen.
    for j=1:columnas %Columnas de pixeles de toda la imagen.
        %Si se encuentra con el punto del centroide, se sale del bucle for.
        if (f(i,j))==1
            break;
        end
    end
    %Si se encuentra con el punto del centroide, se sale del bucle for.
    if (f(i,j))==1
        break;
    end
end
%i será la coordenada "x" del primer pixel que conforma el contorno de la 
%figura con el que se encontró el programa al hacer el barrido de la 
%imagen desde la esquina suiperior izquierda, mientras j es la coordenada
%"y".
%VECINDAD: Está conformada por 8 pixeles que rodean un pixel central, estos
%pixeles están numerados del 8 a 1 empezando desde la derecha del pixel
%central, siendo el número 8, yendo en sentido horario hasta llegar al
%pixel con la coordenada 1 al dar la vuelta completa.
M = [3,2,1;
     4,0,8;
     5,6,7]; %Coordenadas de la matriz vecindad.
%Con esta máscara se hace el mapeo de los puntos del contorno hacia la
%derecha, donde las coordenadas giran en sentido horario:
%[3     2      1]
%[4     0      8]
%[5     6      7]
%Si quiero que haga el mapeo hacia la izquierda se debe cambiar las
%coordenadas de la máscara de la siguiente manera para que gire en sentido
%antihorario:
%[1     2      3]
%[8     0      4]
%[7     6      5]

%Coordenadas del vector que almacena los valores de la distancia R, que
%representa la separación entre el centroide de la figura y todos los
%puntos de su contorno.
n = 1;
while(1)
    %La distancia del centroide a los distintos puntos del contorno se
    %obtiene con la fórmula:
    %R = √((xc-i)^2+(yc-j)^2)
    R(n) = sqrt((xc-i).^2+(yc-j).^2);
    n = n+1; %Aumento de la coordenada del vector R para graficar la firma
    
    %Hacemos que las coordenadas donde se haya encontrado con pixeles del
    %contorno se vuelvan cero, esto irá borrando del figure los puntos del
    %contorno:
    f(i,j) = 0;
    %VECINDAD: En este punto lo que pasa es que los elementos que todavía 
    %no hayan sido analizados aparecerán con las coordenadas de la
    %vecindad.
    V = f(i-1:i+1, j-1:j+1);    %V = Vector vecindad.
    A = V.*M;                   %M = Coordenadas de la matriz vecindad.
    %La dirección de analisis del bucle for irá a analizar el pixel (junto 
    %con su vecindad) que tenga la coordenada mayor.
    d = max(max(A));
    %Esto se repetirá para que el programa analice las coordenadas del 
    %contorno de la figura.

    switch(d)
        case 1
            i = i-1;
            j = j+1;
        case 2
            i = i-1;
            %j = j;
        case 3
            i = i-1;
            j = j-1;
        case 4
            %i = i;
            j = j-1;
        case 5
            i = i+1;
            j = j-1;
        case 6
            i = i+1;
            %j = j;
        case 7
            i = i+1;
            j = j+1;
        case 8
            %i = i;
            j = j+1;
        otherwise
            break;
    end

    figure(1), imshow(uint8(255*f))
    title('Obtención de distancias R - Triángulo - Matriz 2D Binarizada')
end
%Para parar el código se debe dar clic en las teclas CTRL + C dentro del
%command window

figure(2), plot(R)
axis([1 n 0 filas])
title('Firma del Triángulo - Gráfica')