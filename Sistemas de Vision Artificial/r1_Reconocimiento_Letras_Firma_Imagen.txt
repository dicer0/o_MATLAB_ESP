clc
clear all
close all

%RECONOCIMIENTO DE PÁRRAFOS, PALABRAS Y LETRAS CON SUS FIRMAS: La firma de 
%una imagen es un identificador de figuras simples que se obtiene al 
%encontrar su centroide, generando después una gráfica que identifique la 
%distancia del centro de la figura a sus contornos, graficando esa 
%distancia para cada punto del contorno de esa figura; por ello es que una 
%letra tiene firma distinta a otra.
%Para que la firma de la imagen se pueda graficar se debe contar con 
%perímetros de 1 pixel. La distancia se obtiene de forma radial desde el 
%centro de cada figura para graficarse.
IMA = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\5_FirmaNeuronaCompetLetras\Poema Mas Que Amor - Letras.bmp');
figure(1),
imshow(IMA)
title('Imagen Original RGB - Cubo Matricial 3D')
%Binarizado de la capa B de la imagen.
f = 255-double(IMA(:,:,1));
figure(2),
imshow(uint8(f))
title('Capa B Binarizada - Matriz 2D')


%SEGMENTADO DE LA IMAGEN PARA OBTENER SU NÚMERO DE RENGLONES:
%sum(A): El operador lo que hace es sumar todos los números de las columnas
%del vector A, en este caso se aplica a f porque se está analizando la
%imagen binarizada, el segundo parámetro solo se usa cuando se aplica a 
%matrices y se refiere a que dimensión se va a aplicar la suma, 1 se 
%refiere a las columnas de la matriz, osea "x", mientras que 2 se refiere a 
%las filas de la matriz, osea "y".
SX = sum(f,2);
%BINARIZAR UNA IMAGEN PARA SEPARAR UNA FIGURA DE SU FONDO:
%El proceso de separar una figura de su fondo en colores blanco y negro se 
%llama binarización, esto se hace considerando un valor de umbral U, que en
%este caso será el valor de SX previamente calculado que funciona como 
%filtro de la señal para binarizarla completamente y digitalizarla, el
%valor SX representa la posición en x del centroide de la letra y se toma
%como umbral para encontrar a través de él el valor de la firma de cada
%párrafo, palabra o letra.
SX = (SX>0);


%IDENTIFICACIÓN DE RENGLONES: Se ejecuta un filtro de la señal para
%identificar los flancos de subida y bajada, esto para saber cuando 
%empiezan y acaban los renglones del poema que conforma la imagen.
n1 = 1;     %Número de flancos de subida: Principios de renglón.
n2 = 1;     %Número de flancos de bajada: Finales de renglón.
for i=2:length(SX)
    if (SX(i-1)==0) && (SX(i)==1)
        FSR(n1) = i;    %Flanco de subida de la señal: Inicio del renglón.
        n1 = n1+1;      %Número de flancos de subida.
    end
    
    if (SX(i-1)==1) && (SX(i)==0)
        FBR(n2) = i;	%Flanco de bajada de la señal: Fin del renglón.
        n2 = n2+1;      %Número de flancos de bajada.
    end
end
%Los vectores FSR y FBR transpuestos indican cuando inicia y termina un
%renglón de la imagen.
[FSR', FBR'];
figure(3), plot(SX)
title('Número de renglones en la imagen - Gráfica firma')


%IDENTIFICACIÓN DE PALABRAS: Se ejecuta un filtro de la señal para
%identificar los flancos de subida y bajada en un renglón, esto para saber 
%cuando empiezan y acaban las palabras de las frases de la imagen.
for i = 1: n1-1         %n1 = Principios de renglón.
    RENGLON = f(FSR(i):FBR(i),:);
    %SEGMENTADO DE UNA IMAGEN PARA OBTENER SU NÚMERO DE PALABRAS POR CADA 
    %RENGLÓN: 
    %sum(A): El operador lo que hace es sumar todos los números de una 
    %dimensión en específico de la matriz A, con 1 el comando se refiere a 
    %las columnas de la matriz, con 2 se refiere a las filas y con 3 se
    %refiere al número de matrices sobrepuestas.
    SY = sum(RENGLON, 1);
    %Filtro de la señal para binarizarla con un umbral U = SY:
    SY = (SY>0);
    %Ahora hay que buscar de nuevo flancos de subida y bajada en la
    %gráfica que representa las palabras encontradas en un renglón para 
    %identificar en donde se encuentran las letras.
    n3 = 1;     %Número de flancos de subida: Principios de palabras.
    n4 = 1;     %Número de flancos de subida: Finales de palabras.
    clear FSL FBL
    for j = 2: length(SY)
        if (SY(j-1)==0) && (SY(j)==1)
            FSL(n3) = j;%Flanco de subida de la señal: Inicio de palabra.
            n3 = n3+1;  %Número de flancos de subida.
        end

        if (SY(j-1)==1) && (SY(j)==0)
            FBL(n4) = j;%Flanco de bajada de la señal: Fin de palabra.
            n4 = n4+1;  %Número de flancos de bajada.
        end
    end
    %Los vectores FSL y FBL transpuestos indican cuando inicia y termina
    %una palabra de cada renglón, junto con su posición y espacio que ocupa 
    %dentro de la imagen.
    [FSL', FBL'];
    figure(4), plot(SY)
    title(strcat('Número de palabras del renglón: ', num2str(i)))
    
    
    %SEGMENTADO DE UNA IMAGEN PARA OBTENER SU NÚMERO DE LETRAS POR CADA 
    %PALABRA INCLUIDA EN CADA RENGLÓN: 
    for j=1:length(FSL)
        LETRA = f(FSR(i):FBR(i),FSL(j):FBL(j));
        %size(): Comando que devuelve el número de filas y columnas de una 
        %matriz en ese orden.
        [FI,CO] = size(LETRA);      %Dimensionamiento de la letra.
        %zeros(): Comando que crea matriz una matriz llena de ceros. 
        %Todas las letras identificadas en la imagen se guardan y 
        %sobreponen en esta matrix, todas teniendo el mismo tamaño.
        ESPACIO = zeros(30,30);
        %Esta instrucción obliga a que cuando se imprima la letra en el 
        %figure, esta se coloque en la esquina superior izquierda.
        ESPACIO(1:FI,1:CO)= LETRA;
        LETRA = ESPACIO;
        figure(5), imshow(uint8(LETRA))
        title('Letras en la imagen')
        %drawnow: Método que muestra una animación de las letras obtenidas.
        drawnow
    end
end