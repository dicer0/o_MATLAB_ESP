clc
clear all
close all

%RECONOCIMIENTO DE LETRAS CON NEURONAS: Se realiza por medio del comando 
%compet() y para ello se declaran ciertos puntos con valores dentro del 
%plano cartesiano XY. 
%En la visi�n artificial, se emplean t�cnicas de RECONOCIMIENTO DE PATRONES 
%SUPERVISADO para el reconocimiento �ptico de caracteres (OCR), la 
%detecci�n facial, el reconocimiento facial, la detecci�n de objetos y la 
%clasificaci�n de objetos.
%REDES NEURONALES COMPETITIVAS (COMPET): Este tipo de redes a diferencia de
%los dem�s tipos donde las neuronas colaboran entre s� para que a trav�s 
%del aprendizaje se pueda dar una representaci�n al patr�n de entrada, en 
%el caso de una red competitiva, las neuronas compiten unas con otras de 
%manera que solo una se activar� al final, dicho de otra manera, solo esta 
%neurona ser� capaz de representar el patr�n de entrada.
IMA=imread("C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\5_FirmaNeuronaCompetLetras\Letras Abecedario.bmp");
%rgb2gray(): Comando que extrae el cubo matricial de la imagen obtenida con 
%imread y hace un tipo de promedio con todos los colores para obtener una 
%escala de grises que no le da prioridad a ning�n color R, G o B en 
%espec�fico.
GRIS = double(rgb2gray(IMA));           %Escala de grises.
%BINARIZAR UNA IMAGEN PARA SEPARAR UNA FIGURA DE SU FONDO:
%El proceso de separar una figura de su fondo en colores blanco y negro se 
%llama binarizaci�n, esto se hace considerando un valor de umbral U que 
%puede ir de 0 a 255.
f = (GRIS < 254);                       %Binarizado con umbral U = 155.
figure(1), imshow(IMA)
title('Imagen Original RGB - Cubo Matricial 3D')
figure(2), imshow(uint8(255*f));
title('Escala de Grises Binarizada - Matriz 2D')


%SEGMENTADO DE LA IMAGEN PARA OBTENER SU N�MERO DE RENGLONES:
%sum(A): El operador lo que hace es sumar todos los n�meros de las columnas
%del vector A, en este caso se aplica a f porque se est� analizando la
%imagen binarizada, el segundo par�metro solo se usa cuando se aplica a 
%matrices y se refiere a que dimensi�n se va a aplicar la suma, 1 se 
%refiere a las columnas de la matriz, osea "x", mientras que 2 se refiere a 
%las filas de la matriz, osea "y".
SX = sum(f, 2);
%BINARIZAR UNA IMAGEN PARA SEPARAR UNA FIGURA DE SU FONDO:
%El proceso de separar una figura de su fondo en colores blanco y negro se 
%llama binarizaci�n, esto se hace considerando un valor de umbral U, que en
%este caso ser� el valor de SX previamente calculado que funciona como 
%filtro de la se�al para binarizarla completamente y digitalizarla, el
%valor SX representa la posici�n en x del centroide de la letra y se toma
%como umbral para encontrar a trav�s de �l el valor de la firma de cada
%p�rrafo, palabra o letra.
SX = (SX>0);


%IDENTIFICACI�N DE RENGLONES: Se ejecuta un filtro de la se�al para
%identificar los flancos de subida y bajada, esto para saber cuando 
%empiezan y acaban los renglones del poema que conforma la imagen.
n1 = 1;     %N�mero de flancos de subida: Principios de rengl�n.
n2 = 1;     %N�mero de flancos de bajada: Finales de rengl�n.
clear FSR FBR
for i=2:length(SX)
    if (SX(i-1)==0) && (SX(i)==1)
        FSR(n1) = i;    %Flanco de subida de la se�al: Inicio del rengl�n.
        n1 = n1+1;      %N�mero de flancos de subida.
    end
    
    if (SX(i-1)==1) && (SX(i)==0)
        FBR(n2) = i;	%Flanco de bajada de la se�al: Fin del rengl�n.
        n2 = n2+1;      %N�mero de flancos de bajada.
    end
end
%Los vectores FSR y FBR transpuestos indican cuando inicia y termina un
%rengl�n de la imagen.
[FSR', FBR'];
figure(3), plot(SX)
title('N�mero de renglones en la imagen - Gr�fica firma')


%IDENTIFICACI�N DE PALABRAS: Se ejecuta un filtro de la se�al para
%identificar los flancos de subida y bajada en un rengl�n, esto para saber 
%cuando empiezan y acaban las palabras de las frases de la imagen.
for i = 1:n1 - 1        %n1 = Principios de rengl�n.
    RENGLON = f(FSR(i):FBR(i), :);
    %SEGMENTADO DE UNA IMAGEN PARA OBTENER SU N�MERO DE PALABRAS POR CADA 
    %RENGL�N: 
    %sum(A): El operador lo que hace es sumar todos los n�meros de una 
    %dimensi�n en espec�fico de la matriz A, con 1 el comando se refiere a 
    %las columnas de la matriz, con 2 se refiere a las filas y con 3 se
    %refiere al n�mero de matrices sobrepuestas.
    SY = sum(RENGLON, 1);
    %Filtro de la se�al para binarizarla con un umbral U = SY:
    SY = (SY>0);
    %Ahora hay que buscar de nuevo flancos de subida y bajada en la
    %gr�fica que representa las palabras encontradas en un rengl�n para 
    %identificar en donde se encuentran las letras.
    n3 = 1;     %N�mero de flancos de subida: Principios de palabras.
    n4 = 1;     %N�mero de flancos de subida: Finales de palabras.
    clear FSL FBL
    for j = 2:length(SY)
        if (SY(j-1) == 0) && (SY(j) == 1)
            FSL(n3) = j;%Flanco de subida de la se�al: Inicio de palabra.
            n3 = n3+1;  %N�mero de flancos de subida.
        end

        if (SY(j-1)==1) && (SY(j)==0)
            FBL(n4) = j;%Flanco de bajada de la se�al: Fin de palabra.
            n4 = n4+1;  %N�mero de flancos de bajada.
        end
    end
    %Los vectores FSL y FBL transpuestos indican cuando inicia y termina
    %una palabra de cada rengl�n, junto con su posici�n y espacio que ocupa 
    %dentro de la imagen.
    [FSL', FBL'];
    figure(4), plot(SY)
    title(strcat('N�mero de palabras del rengl�n: ', num2str(i)))
    
    
    %SEGMENTADO DE UNA IMAGEN PARA OBTENER SU N�MERO DE LETRAS POR CADA 
    %PALABRA INCLUIDA EN CADA RENGL�N:
    n = 1;      %Variable que recorre todas las letras del abecedario.
    for j = 1:length(FSL)
        LETRA = f(FSR(i):FBR(i), FSL(j):FBL(j));
        %size(): Comando que devuelve el n�mero de filas y columnas de una 
        %matriz en ese orden.
        [NE,NP] = size(LETRA);      %Dimensionamiento de la letra.
        %NE = Cantidad de elementos, osea el n�mero de filas.
        %NP = Cantidad de patrones, osea el n�mero de columnas.
        %zeros(): Comando que crea matriz una matriz llena de ceros. 
        %Todas las letras identificadas en la imagen se guardan y 
        %sobreponen en esta matrix, todas teniendo el mismo tama�o.
        ESPACIO = zeros(30, 30);
        %Esta instrucci�n obliga a que cuando se imprima la letra en el 
        %figure, esta se coloque en la esquina superior izquierda.
        ESPACIO(1:NE, 1:NP) = LETRA;
        figure(5), imshow(uint8(255*ESPACIO))
        title('Letras en la imagen')
        %drawnow: M�todo que muestra una animaci�n de las letras obtenidas.
        drawnow
        
        %P = reshape(ESPACIO, 30*30, 1) crea una nueva variable a partir de 
        %la matriz ESPACIO, cambiando su tama�o a ser de 30*30 (que es el 
        %espacio en pixeles que ocupa cada letra de la imagen para as� 
        %definir el tama�o de P, que ser� un vector de 900 filas con 1 
        %columna.
        %P = Vector que tiene 1 columna el mismo n�mero de filas que 
        %almacena todas las letras de la imagen.
        P = reshape(ESPACIO, 30*30, 1); 
        %De esta forma se obtiene el vector en su forma unitaria, para cada 
        %uno de los vectores descritos en la matriz P, obteniendo as� el
        %valor de los pesos W de la neurona compet.
        P=P./norm(P); %Normalizaci�n del vector P.
        %W: Es una matriz que guarda los valores unitarios de la matriz y
        %representa el peso (weight) de la conexi�n neuronal, los pesos 
        %son par�metros importantes en una red neuronal, ya que se 
        %multiplicar�n con los datos de entrada "X" y con las salidas de 
        %las neuronas de la capa anterior "A", cada parametro W es 
        %diferente para cada neurona ya que en estos parametros se guardan 
        %los patrones que la neurona aprendi� sobre los datos introducidos 
        %anteriormente. Esto se debe hacer para todo el n�mero de letras
        %identificadas en la imagen.
        W(n, :)=P;      %Peso de las neuronas.
        n=n+1;          %N�mero total de letras del abecedario + 1.
    end
end