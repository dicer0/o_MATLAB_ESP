clc
clear all
close all

%ALGORITMO DE HARRIS: Método matemático para la detección de esquinas en 
%una figura, hace lo mismo que el detector de Beaudet o Kitchen Rosenfeld 
%pero dependiendo de la imagen, puede servir mejor un detector o el otro.
IMA = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\4_Firmas_de_Figuras_Simples\firma estrella.bmp');

%rgb2gray(): Comando que extrae el cubo matricial de la imagen obtenida con 
%imread y hace un tipo de promedio con todos los colores para obtener una 
%escala de grises que no le da prioridad a ningún color R, G o B en 
%específico.
image = rgb2gray(IMA);

%size(): Comando que devuelve el número de filas y columnas de una matriz 
%en ese orden, dimensionamiento de la matriz.
[filas, columnas] = size(image);

%zeros(filas, columnas): Método que crea una matriz vacía, llenándola de 
%puros ceros, para crear con ellas las máscaras de Harris y Gauss.
U = zeros(size(image));
S = zeros(size(image));

%PROCESADO DE UNA IMAGEN PARA LA OBTENCIÓN DE BORDES:
%1.	Se suaviza la imagen por medio del filtro promediador: 
%Para ello se crea una matriz 3X3 de puros unos con el método ones y se
%multiplica por 1/9, a esa matriz y a la imagen en escala de grises se le
%aplica el método imfilter() que sirve para aplicar filtros a imagenes
%Se convierte a double para que se pueda realizar operaciones con él.
Hp = ones(3,3)*(1/9);
Img = double(image);
%Filtro aplicado para obtener esquinas en la imagen
Img_Fil = imfilter(Img, Hp); %I'= I_original * Hp
%Filtro aplicado para mostrar el suavizado en un figure
Img_Fil1 = imfilter(image, Hp);

%Para mostrar las imagenes procesadas en pantalla, con la palabra reservada
%figure se muestra la ventana con la que se enseñarán las imagenes, con el
%método subplot se indica el número de filas, columnas y la posición de
%cada elemento que se va a mostrar en cada posición con el método imshow()
figure(1)
subplot(1,2,1) %1 fila, 2 columnas, posición 1
imshow(image)
title('Imagen Original - Matriz 3D')
subplot(1,2,2) %1 fila, 2 columnas, posición 2
imshow(Img_Fil1)
title('Imagen Con Filtro 1/9 - Matriz 2D')

%2.	Se calcula la imagen con respecto a las coordenadas xy:
Hx = [-0.5,0,0.5]; %Máscara Hx, dirección horizontal
Hy = [-0.5;
       0;
       0.5]; %Máscara Hy, dirección vertical
Img_x = imfilter(Img_Fil, Hx); %Ix = I' * Hx
Img_y = imfilter(Img_Fil, Hy); %Iy = I' * Hx

%3. Ya teniendo las matrices de Harris xy se calcula la matriz de Harris HE:
HE12 = Img_x .* Img_y; %HE12 = HE21 = Ix*Iy
%En estas dos ecuaciones se realiza la función cuadrada porque se tiene un 
%comportamiento parabólico, que identifica cambios abruptos en la matriz, 
%porque un pixel vale 255 y de repente 0 en la escala de grises, esto para 
%aplicar una derivada en la imagen e identificar bordes.
HE11 = Img_x .* Img_x; %HE11 = Ix^2
HE22 = Img_y .* Img_y; %HE22 = Iy^2

%4.	Después de haber aplicado el filtro de Harris, se debe aplicar el 
%filtro de Gauss, para mejorar así la identificación de bordes.
Hg = [0,1,2,1,0;
      1,3,5,3,1;
      2,5,9,5,2;
      1,3,5,3,1;
      0,1,2,1,0];
%Se divide toda la matriz entre 157, para obtener la máscara de Gauss
Hg = Hg*(1/57);
%Obtención de los factores A, B y C de la matriz Gaussiana
A = imfilter(HE11, Hg);
B = imfilter(HE22, Hg);
C = imfilter(HE12, Hg);
%α representa la sensibilidad que puede valer 0.02, 0.03, 0.04, algún 
%valor pequeño
alpha = 0.04;

%5.	Después de haber aplicado el filtro de Gauss, se deben obtener los 
%valores propios, estos se refieren a los que representan las esquinas en 
%la imagen. 
%Los valores del umbral como son eigenvalores serán valores altos, 
%alrededor de los 1000, 2000, etc. por lo que se da una condición de 
%umbral, en donde se dice que los valores de umbral están dados siempre 
%que el eigenvalor obtenido sea mayor al umbral th propuesto.
%Eigenvalor = (A*B-C^2 )-α(A+B)^2
Eig = ((A.*B)-(C.*C))- (alpha*((A+B).*(A+B)));
th = 1000; %Umbral th
%El umbral es del mismo valor que el eigenvalor cuando sea mayor al umbral th
U = Eig > th;

%Con el tamaño de la imagen se realiza un bucle for en donde se recorra
%todos los espacios de la matriz y si el umbral vale 1, la identificación
%del punto con el tamaño del vecindario TamVec 
TamVec = 10;
for r=1 : filas
    for c=1 : columnas
        %Si la matriz U en su posición r,c no está vacía, ejecuta lo sig:
        if (U(r,c))
            %Creación de la matriz con una fila (vector), que va a indicar
            %en dónde se encuentra una esquina.
            I1 = [r - TamVec, 1];           %Limite Izquierdo
            I2 = [r + TamVec, filas];       %Limite derecho
            I3 = [c - TamVec, 1];           %Limite Superior
            I4 = [c + TamVec, columnas];    %Limite Inferior
            %Puntos máximos de los límites de las matrices anteriores
            MaxXi = max(I1); %Valor máximo de la matriz del limite Izquierdo
            MaxXd = min(I2); %Valor máximo de la matriz del limite derecho
            MaxYs = max(I3); %Valor máximo de la matriz del limite superior
            MaxYi = min(I4); %Valor máximo de la matriz del limite inferior
            %De los eigenvalores anteriormente obtenidos con el filtro de
            %Gauss, se obtienen ciertos valores, creando una nueva matriz
            bloq = Eig(MaxXi:1:MaxXd, MaxYs:1:MaxYi);
            %De la matriz bloq se obtiene su valor máximo, el máximo que 
            %haya entre sus filas y columnas
            MaxV = max(max(bloq));
            
            %Si la matriz Eig en su posición r,c tiene el valor máximo, 
            %ejecuta lo siguiente:
            if (Eig(r,c) == MaxV)
                %En la matriz S vacías de ceros, asigna un valor de 1 a esa
                %coordenada de la matriz Eig donde tuvo el valor máximo
                S(r,c) = 1;
            end
        end
    end 
end

%Muestra la imagen original, pero espera a que se ejecute el análisis de
%los eigenvalores para que en las esquinas se muestren ciertos tachecitos,
%indicando su posición y cantidad.
figure(2)
imshow(image)
hold on
%Bucle for para mostrar los tachecitos en las esquinas de la imagen
for r=1 : filas
    for c=1 : columnas
        %Si la matriz S en su posición r,c no está vacía, ejecuta lo sig:
        if S(r, c)
            %Muestra un tachecito, para indicar las posiciones donde se
            %encuentran las esquinas en la imagen.
            plot(c, r, '+')
        end
    end
end
title('Imagen Original con Esquinas - Detector Harris - Cubo Matricial 3D')