clc
clear all
close all

%OBTENCIÓN DE BORDES: La obtención de bordes de una imagen se realiza a
%través de su derivación, esto se puede realizar porque las imagenes se
%pueden considerar como funciones de dos variables f(x,y).

%imread(ruta): Comando para leer una imagen y convertirla a matrices de 3
%dimensiones, que prácticamente se ve como un cubo, del cubo de colores se 
%tienen 3 capas, osea 3 matrices una encima de otra, todas con el mismo
%número de filas y columnas, de este cubo se extraen las distintas capas
%para obtener los colores RGB.
IMA = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\Iron Man bullet.jpg');
figure(1), imshow(IMA)
title('Imagen Original RGB - Cubo Matricial 3D')

%La derivación de imágenes se lleva a cabo respecto a los ejes xy de la
%imagen, los valores positivos del eje x si van hacia la derecha como
%normalmente se acostumbra pero los valores positivos del eje y van hacia
%abajo, teniendo su punto inicial en la esquina superior izquierda. Es
%posible realizar la derivación porque la imagen se considera como una
%función de dos variables f(x,y), para ello se realiza el gradiente de la
%función por medio de la siguiente fórmula:
%Gx = f(x+Δx,y(cte))-f(x-Δx,y(cte))/Δx
%Para poder llevar a cabo la fórmula, primero se lleva la imagen al dominio
%de los grises, convirtiéndola en valores decimales (double) y llamándola
%f, en este caso el dominio de los grises que se extrae es la capa R de la
%imagen, que es un cubo 3D de 3 matrices R, G y B sobrepuestas una encima
%de la otra, esta es la función que depende de dos variables f(x,y).
f = double(IMA(:,:,1)); %Capa (matriz) R extraida del cubo matricial RGB.

%Dimensionamiento de la matriz obtenida, solo se saca de una de las
%capas de la imagen porque estas deben ser del mismo tamaño todas y se
%guardan en las variables filas y columnas obtenidas con el método size()
%aplicado a la matriz R que primero devuelve el número de filas y luego el
%número de columnas, todas las capas RGB son matrices de cierto tamaño
%obtenidas de la imagen con el método imread, el cual depende 100% de la
%resolución de la imagen original.
[filas, columnas] = size(f);

%OBTENCIÓN DE BORDES DE LA IMAGEN:
%Solo se barre el elemento x, que son las columnas de la matriz porque como
%se explicó en la fórmula del gradiente Gx, "y" se deja como cte y se hace 
%el incremento del eje horizontal x, el incremento en las imágenes se da 
%de 1 en 1, donde dx = Δx
dx=1;   %dx = Δx; Incremento de 1 en 1.
for y=1:columnas
    %Se indica que x empiece desde 2 para que al hacer la resta de la
    %derivada el resultado no sea cero cuando x = 1, además se pone el
    %límite superior de filas-1 porque al llegar a la última posición de la
    %imagen el programa le estará pidiendo que llegue a una posición extra
    %y esta no existe, además se pone la división entre 2dx porque como en
    %la función se analiza f(x+dx) y f(x-dx) y el incremento dx es igual a
    %1, se están analizando los pixeles anterior y posterior del que se
    %quiere derivar, por lo tanto el espacio entre los extremos es de 2
    %pixeles, por eso se pone 2dx.
    for x=2:filas-1
        %Por lo tanto en código la fórmula: 
        %Gx = f(x+Δx,y(cte))-f(x-Δx,y(cte))/Δx
        %Se transforma en lo siguiente para que almacene un dato por cada
        %uno de los pixeles que se haya recorrido, que tiene 1 fila menos
        %que las de la capa R extraida de la imagen.
        Gx(x,y) = (f(x+dx,y)-f(x-dx,y))/(2*dx);
    end
end
%La función Gx(x,y) de dos variables se grafica en 3D con el método mesh(),
%esto muestra una gráfica 3D que al moverla podemos ver que es la misma
%imagen original
figure(2), mesh(Gx)
title('Bordes - Derivación Gx - Visión 3D con Comando mesh')

%Con el comando imshow mostramos las capas de la imagen en forma de una
%nueva imagen considerando sus colores RGB y convertimos los elementos
%decimales de la matriz en enteros de 8 bits, osea que va de 0 a 2^8 = 256,
%esto lo que hará es eliminar todos los valores negativos, dejando solo los
%positivos de la gráfica 3D original mostrada con el comando mesh, el
%resultado de esta operación a la imagen es que se hace una detección de
%bordes en la imagen, poniendo los bordes de blanco y lo demás de color
%negro, identificando donde existen fronteras en la imagen, esto porque la
%derivada identifica los cambios en la imagen de grises y resalta solo
%donde haya un cambio, osea los bordes, por eso era importante extraer la
%capa de grises.
figure(3), imshow(uint8(Gx))
title('Bordes - Derivación Gx - Visión Plana')

%Cuando apenas va a entrar a un borde se crea la parte positiva de la
%gráfica 3D Gx, pero cuando sale de ese borde y continúa con la imagen se
%crea la parte negativa de la función 3D Gx, para poder ver ambos valores
%en vez de eliminar la parte negativa se debe aplicar el método abs() para
%aplicar el absoluto de la función Gx, que se le llama borde doble en
%visión artificial, en donde se ven más remarcados los bordes.
figure(4), imshow(uint8(abs(Gx)))
title('Bordes Dobles abs() - Derivación Gx - Visión Plana')

%DETECCIÓN DE BORDES EN Y:
%Si ahora se repite el mismo proceso de derivación pero dejando ahora
%constante a x se obtiene Gy, con un incremento de 1 y se repite la misma
%condición a los límites pero ahora aplicados a y.
dy=1;     %dy = Δy; Incremento de 1 en 1.
for y=2:columnas-1
    for x=1:filas
        %Gy = f(x(cte),y+Δy)-f(x(cte),y-Δy)/Δx
        Gy(x,y) = (f(x,y+dy)-f(x,y-dy))/(2*dy);
    end
end
figure(5), mesh(Gy)
title('Bordes - Derivación Gy - Visión 3D con Comando mesh')
figure(6), imshow(uint8(abs(Gy)))
title('Bordes Dobles abs() - Derivación Gy - Visión Plana')


%Las imágenes mostradas con GX y Gy son totalmente distintas ya que Gx
%enfatiza en los bordes horizontales de la imagen y Gy enfatiza en los
%bordes verticales, para poder ver ambos bordes unidos se unifican Gx y Gy
%de una forma vectorial por medio de los dos gradientes:
%G = √Gx^2+Gy^2
for y=2:columnas-1
    for x=2:filas-1        
        %Gx = f(x+Δx,y(cte))-f(x-Δx,y(cte))/Δx
        Gx(x,y) = (f(x+dx,y)-f(x-dx,y))/(2*dx);
        %Gy = f(x(cte),y+Δy)-f(x(cte),y-Δy)/Δx
        Gy(x,y) = (f(x,y+dy)-f(x,y-dy))/(2*dy);
        %G = √Gx^2+Gy^2
        G(x,y) = sqrt(Gx(x,y)^2+Gy(x,y)^2);
    end
end
%En la función G ya no es solo posible ver los bordes sino hasta las
%sombras.
figure(7), mesh(G)
title('Bordes - Derivación G - Visión 3D con Comando mesh')
figure(8), imshow(uint8(G))
title('Bordes - Derivación G - Visión Plana')