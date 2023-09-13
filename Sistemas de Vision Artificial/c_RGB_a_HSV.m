clc
clear all
close all

%El método imread lo que hace es leer una imagen y convertirla en sus 3
%capas de color rgb para crear una matriz 3D con ellas.
IMA = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\Iron Man Mark 86.jpg');
%El método rgb2hsv lo que hace es convertir las 3 capas rgb de la imagen
%guardada en la variable IMA por las 3 capas del código de colores hsv, que
%son Hue, Saturation y Value.
HSV = rgb2hsv(IMA);

%Se representa el vector hsv en una escala de grises por medio del método
%uint8, donde se está tomando la capa número 1 que es la H de matiz, la
%cual representa el contorno de colores del cubo RGB, pero se multiplica 
%por un factor de 255 para que se pueda observar la capa de color, para 
%ello el dato debe ser de tipo double:

%HSV: La variable H llamada Hue o matiz empieza en el color rojo y le da un 
%giro completo a la esfera del cono de colores obtenido a partir del cubo 
%de colores, yendo de 0 a 1 y obteniendo con ese valor toda la gama de
%colores obtenidos a partir de los primarios RGB.
% - Rojo puro corresponde al valor de H = 0 o H =1.
% - El color amarillo vale H = 1/6 = 0.16.
% - El verde vale H = 1/3 = 0.33.
% - El color cian (azul cielo) se encuentra a H = 1/2 = 0.5.
% - El color azul (azul rey) se encuentra a H = 2/3 = 0.66.
% - El magenta se encuentra en H = 5/6 = 0.83. 
%El matiz nunca alcanza al color blanco o negro.
%H se convierte a double porque es un número que se encuentra de 0 a 1,
%luego este se multiplica por 255 para que vaya de 0 a 255 y se pueda
%mostrar en una imagen, uint8 se aplica para que sean solamente numeros
%enteros en la matriz de la imagen.
H = uint8(255*double(HSV(:,:,1)));

% HSV: La variable S llamada Saturación empieza del centro del círculo que 
%va del color blanco hacia los extremos del círculo donde se encuentra H 
%(matiz) yendo de 0 a 1.
% - El color blanco puro corresponde al valor de S = 0.
% - El valor de 0 < S < 1 lo que hace es hacer pálidos los matices de 
%colores que se encuentran en el perímetro de la circunferencia obtenidos
%con el Hue o matiz en la capa anterior.
% - El valor de S que muestra el rango de colores en su máxima expresión 
%es S = 1, por lo que muestra colores puros.
%El valor se obtiene de la capa 2, se pone el 1 - porque en un inicio lo 
%que se encuentra más cercano al color blanco dentro de la imagen es lo 
%que se muestra de color negro y el color blanco es lo que más se acerca 
%al matiz de colores puros, que es el contorno del círculo superior del 
%cono de color, esto se corrige con la resta.
S = uint8(255*(1-double(HSV(:,:,2))));

% HSV: La variable V llamada valor empieza desde la base del cono de 
%colores, yendo del color negro hacia el blanco que se encuentra en el 
%centro del círculo superior del cono y asociado al valor de Saturación de 
%la capa anterior, es básicamente la altura en el cono de colores, haciendo 
%referencias a los niveles de grises.
% - El color negro puro corresponde al valor de V = 0.
% - El valor de 0 < V < 1 ocupa todos los niveles de grises.
% - El color blanco puro corresponde al valor de V = 1.
%El valor se obtiene de la capa 3, esta imagen solo se muestra con una gama
%de grises.
V = uint8(255*double(HSV(:,:,3)));

%INTERPRETACION DE LAS CAPAS HSV: El método imshow(matriz) muestra una 
%imagen a partir de una matriz de sus valores hsv o rgb, dependiendo de la
%capa o matriz que se esté tomando para mostrar.
%- En específico para la capa H lo que pasa es que el color negro y blanco 
%de la imagen se representan como la capa ROJA, mientras que los demás 
%tonos de gris se representan como los demás colores del círculo superior 
%del cono de colores obtenido del cubo de colores RGB.
%imshow(H)

%- En específico para la capa S el color blanco es lo que se encuentra más 
%cercano al color blanco dentro de la imagen y el color negro es lo que 
%más se acerca al matiz de colores puros, que es el contorno del círculo 
%superior del cono de color asociado al valor de matiz de la capa anterior, 
%esto da una gran nitidez en la imagen y claridad en sus detalles.
%imshow(S)

%- En específico para la capa V la imagen se muestra simplemente enseñando
%los niveles de obscuridad o claridad de la imagen original.
%imshow(V)

%- El método imshow(matriz) muestra una imagen a partir de una matriz de 
%sus valores rgb si se toma la matriz 3D de la imagen original.
%imshow(IMA)

%Ahora se declara un vector vacío que almacene todos los vectores HSV 
X = [];
%En su primer componente tendrá el vector H de matiz
X(:,:,1) = H;
%En su segundo componente tendrá el vector S de saturación
X(:,:,2) = S;
%En su tercer componente tendrá el vector V de valor
X(:,:,3) = V;

%Se pueden mostrar los 3 vectores a la vez de la imagen HSV
figure(1), imshow(IMA)
title('Imagen Original RGB - Cubo Matricial 3D')
figure(2), imshow([H,S,V])
title('Capas H, S y V - Matrices 2D')
%Si no se convierte a formato entero la imagen, se muestra en forma de gama
%de colores 
figure(3), imshow(HSV)
title('Escala de HSV - Matriz 2D')


%IDENTIFICACIÓN DE UNA PELOTA EN UN FONDO:
Pelota = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\Pelota HSV.PNG');
HSVPelota = rgb2hsv(Pelota);%Conversión rbg a hsv con el método rgb2hsv
%H = matiz, muestra los colores rgb en su forma pura.
HPelota = uint8(255*double(HSVPelota(:,:,1)));
%S = saturación, hace pálidos los colores.
SPelota = uint8(255*(1-double(HSVPelota(:,:,2))));
%V = valor, varía el nivel de obscuridad del color.
VPelota = uint8(255*double(HSVPelota(:,:,3)));
figure(4), imshow(Pelota)%Imagen original
title('Imagen Original RGB - Cubo Matricial 3D')
figure(5), imshow([HPelota,SPelota,VPelota])%Imagen de capas HSV
title('Capas H, S y V - Matrices 2D')

%Al analizar las imágenes podemos ver que el matiz es la que más puede
%diferenciar la pelota del piso y la sombra del árbol, por lo que se debe
%crear una función que analice sus valores de matiz y lo diferencíe de lo
%demás, este analiza el vector H con un rango y devuelve los valores que se
%encuentren en ese rango, luego con el método uint8 se convierten a enteros
%sus términos y se multiplica por 255
f = uint8(((HPelota/255)>0.4) & ((HPelota/255)<0.6));
figure(6), imshow(f)%Imagen con segmentación HSV
title('Escala con Segmentación HSV - Matriz 2D')