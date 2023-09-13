clc
%Para que se pueda realizar el reconocimiento de letras, previamente se 
%debió haber ejecutado el Script: r2_Reconocimiento_Alfabeto_NeuronaCompet.
%En este Script no se borra el Workspace para poder usar el valor de W 
%previamente calculado del Abecedario.

%RECONOCIMIENTO DE LETRAS EN UNA IMAGEN CON NEURONAS COMPET:
%Al ejecutar este archivo en el Command Window se muestra lo siguiente:
%1.- NOMBRE.
%2.- CARACTERES RECONOCIDOS EN LA IMAGEN AGRUPADOS POR PALABRAS CON SUS
%    RESPECTIVOS ESPACIOS Y RENGLONES.
%3.- TRAS EL ÚLTIMO PARRAFO MOSTRAR LA PALABRA "FIN".

%MENSAJE: Variable para imprimir todo el mensaje en el command window.
MENSAJE = 'CERVANTES RODRÍGUEZ DIEGO: di_ce_r0\n';  %Estado inicial.
%fprintf(): Método para imprimir en el Command Window.
fprintf(MENSAJE);

%ALFABETO: Variable para pintar en el Command Window las letras que se haya 
%reconocido de la imagen basándose en el peso W de la neurona compet 
%entrenada previamente al ejecutar el archivo: 
%r2_Reconocimiento_Alfabeto_NeuronaCompet.m
ALFABETO = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

%Lectura de la imagen Poema Mas Que Amor - Letras.bmp
IMA = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\5_FirmaNeuronaCompetLetras\Poema Mas Que Amor - Letras.bmp');

%rgb2gray(): Comando que extrae el cubo matricial de la imagen obtenida con 
%imread y hace un tipo de promedio con todos los colores para obtener una 
%escala de grises que no le da prioridad a ningún color R, G o B en 
%específico.
GRIS = double(rgb2gray(IMA));       %Escala de grises.
%BINARIZAR UNA IMAGEN PARA SEPARAR UNA FIGURA DE SU FONDO:
%El proceso de separar una figura de su fondo en colores blanco y negro se 
%llama binarización, esto se hace considerando un valor de umbral U que 
%puede ir de 0 a 255.
f = (GRIS < 254);                       %Binarizado con umbral U = 155.
figure(1), imshow(IMA)
title('Imagen Original RGB - Cubo Matricial 3D')
figure(2), imshow(uint8(255*f));
title('Escala de Grises Binarizada - Matriz 2D')


%SEGMENTADO DE LA IMAGEN PARA OBTENER SU NÚMERO DE RENGLONES:
%sum(A): El operador lo que hace es sumar todos los números de las columnas
%del vector A, en este caso se aplica a f porque se está analizando la
%imagen binarizada, el segundo parámetro solo se usa cuando se aplica a 
%matrices y se refiere a que dimensión se va a aplicar la suma, 1 se 
%refiere a las columnas de la matriz, osea "x", mientras que 2 se refiere a 
%las filas de la matriz, osea "y".
SX = sum(f, 2);
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
clear FSR FBR
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
for i = 1:n1 - 1        %n1 = Principios de renglón.
    RENGLON = f(FSR(i):FBR(i), :);
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
    for j = 2:length(SY)
        if (SY(j-1) == 0) && (SY(j) == 1)
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
    n = 1;      %Variable que recorre todas las letras del abecedario.
    for j = 1:length(FSL)
        LETRA = f(FSR(i):FBR(i), FSL(j):FBL(j));
        %size(): Comando que devuelve el número de filas y columnas de una 
        %matriz en ese orden.
        [NE,NP] = size(LETRA);      %Dimensionamiento de la letra.
        %NE = Cantidad de elementos, osea el número de filas.
        %NP = Cantidad de patrones, osea el número de columnas.
        %zeros(): Comando que crea matriz una matriz llena de ceros. 
        %Todas las letras identificadas en la imagen se guardan y 
        %sobreponen en esta matrix, todas teniendo el mismo tamaño.
        ESPACIO = zeros(30, 30);
        %Esta instrucción obliga a que cuando se imprima la letra en el 
        %figure, esta se coloque en la esquina superior izquierda.
        ESPACIO(1:NE, 1:NP) = LETRA;
        figure(5), imshow(uint8(255*ESPACIO))
        title('Letras en la imagen')
        %drawnow: Método que muestra una animación de las letras obtenidas.
        drawnow
        
        %P = reshape(ESPACIO, 30*30, 1) crea una nueva variable a partir de 
        %la matriz ESPACIO, cambiando su tamaño a ser de 30*30 (que es el 
        %espacio en pixeles que ocupa cada letra de la imagen para así 
        %definir el tamaño de P, que será un vector de 900 filas con 1 
        %columna.
        %P = Vector que tiene 1 columna el mismo número de filas que 
        %almacena todas las letras de la imagen.
        P = reshape(ESPACIO, 30*30, 1); 
        %De esta forma se obtiene el vector en su forma unitaria, para cada 
        %uno de los vectores descritos en la matriz P, obteniendo así el
        %valor de los pesos W de la neurona compet.
        P=P./norm(P); %Normalización del vector P.
        
        %Ahora para obtener los patrones se pone W transpuesta y se 
        %multiplica por P, que es el valor de los pesos de la neurona.
        %compet(): Busca de toda la columna el valor más alto de todos y lo 
        %vuelve 1, los demás valores los vuelve cero.
        %La neurona compet entonces se basa en el producto punto, donde 
        %busca la que más se parezca a cierto valor P dado.
        %Neurona compet con el peso W calculado en el programa anterior:
        a = compet(W*P);    %A la variable "a" se le llama axon neuronal.
        %max(): Comando que devuelve el valor que sea mayor de un vector y 
        %la posición donde se encuentra.
        [M,I] = max(a);
        
        %Con esta línea de código nos aseguramos que el programa imprima en
        %el Command Window el mensaje obtenido de la imagen una vez por 
        %cada párrafo.
        MENSAJE = ' ';
        
        %strcat(): Método que permite concatenar horizontalmente el texto 
        %en sus argumentos de entrada.
        MENSAJE = strcat(MENSAJE, ALFABETO(I));
        
        %Condicional que asegura que exista una separación entre palabras 
        %dentro del mismo párrafo.
        if (j < length(FSL))
            if (FSL(j+1) - FBL(j) > 8)
                MENSAJE = strcat(MENSAJE, " "); 
            end
        end
        
        %Impresión del Poema Más que Amor en el Command Window.
        fprintf(MENSAJE);
    end
    fprintf('\n');      %Salto de línea entre párrafos.
end
%RECONOCIMIENTO DE LETRAS EN UNA IMAGEN CON NEURONAS COMPET:
%Al ejecutar este archivo en el Command Window se muestra lo siguiente:
%1.- NOMBRE.
%2.- CARACTERES RECONOCIDOS EN LA IMAGEN AGRUPADOS POR PALABRAS CON SUS
%    RESPECTIVOS ESPACIOS Y RENGLONES.
%3.- TRAS EL ÚLTIMO PARRAFO MOSTRAR LA PALABRA "FIN".
fprintf('\nFIN\n');