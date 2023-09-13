clc
clear all
close all

%TEXTURA PROCEDURAL
%Una textura procedural es una imagen creada por medio de un algoritmo. 
%Normalmente se utilizan para crear una representación realista de una 
%superficie o un volumen de elementos naturales tales como madera, mármol, 
%granito, metal, piedra, etc.




%Señal senoidal, animación con comando drawnow
t=0:255;
for w=0:0.001:0.1
xt=sin(w*t);
plot(t,xt)
drawnow
end
figure(1)
title('Señal senoidal, Animación con Comando drawnow')




%graficación de una malla 2D con dos for anidados y el comando mesh
%Con el comando imshow se muestra una imagen en una ventana distinta al
%figure donde se muestran los gráficos, esto es porque imshow solo puede
%mostrar rangos de 0 a 255, por eso si ponemos for con valores mayores, no
%saldrá nada en la figure nueva. Además debemos transformarlas al formato
%correcto con el método uint8(f)
%Esto creará una recta gris que es la pendiente del cubo de colores.
%GRAFICACIÓN DE UNA CARA DE COLORES
T=255;
for i=1:T
    for j=1:T
        %Cambiar la ecuación de la función muestra distintas caras del cubo
        %de colores
        f(i,j)=(i+j)/2;
    end
end
figure(2)
mesh(f)
title('Malla 2D, Visión 3D con Comando mesh')
figure(3)
imshow(uint8(f))
title('Malla 2D, Visión Plana')



%LOGO WINDOWS: De esta manera se crean logos donde no se cruzan las
%líneas que lo crean
T=256;
%T = 0 a 255 es el rango porque el código rgb ocupa esos números
f=zeros(256);
%255 = blanco
%0 = negro
for i=1:T
%i = eje vertical, dirección: arriba hacia abajo.
    for j=1:T
    %j = eje horizontal, dirección: izquierda a derecha.
        if (j>103.59)&&(j<117.93)
            f(i,j)=255;
        end
        if (i>119.53)&&(i<133.875)
            f(i,j)=255;
        end
        if (i>0.133*j+219.93)
             f(i,j)=255; 
        end
        if (i<-0.133*j+35.06)
             f(i,j)=255;
        end
    end
end
figure(4), mesh(f)
title('Logo Windows, Visión 3D con Comando mesh')
figure(5), imshow(uint8(f))
title('Logo Windows, Visión Plana')




%LOGO MESSENGER: De esta manera se crean logos donde no sí se cruzan las
%lineas que se utilizan para crear el logo
%T = 0 a 255 es el rango porque el código rgb ocupa esos números
T = 256;
%255 = blanco
%0 = negro

%Fondo blanco
for i = 1:T
    %i = eje vertical, dirección: arriba hacia abajo.
    for j = 1:T
        %j = eje horizontal, dirección: izquierda a derecha.
        f(i,j) = 255;
    end
end
%Valor intermedio de la función f para almacenar el fondo blanco del logo, 
%es necesario declarar este valor aunque no se asigne a ningún figure.

%Elipse del logo
%a y b son la altura y ancho de la elipse que conforma al logo
a = 115;
b = 128;
for i = 1:T
    for j = 1:T
        %Ecuación de la elipse del logo de messenger
        if(((i-(T/2-13))/a)^2+((j-T/2)/b)^2<1)
            f(i,j) = 0;
        end
    end
end
%En el figure 1 solo se crea la elipse del logo de Messenger
figure(6), imshow(uint8(f))
title('Elipse Logo Messenger, Visión Plana')

%Colita del logo de Messenger
for i = 1:T
    for j = 1:T
        %La colita del logo de Messenger se crea a partir de rectas y
        %varias condicionales unidas entre sí.
        if((j>48.16) && (i>200) && (j<-1.47*i + 424.23))
            f(i,j) = 0;
        end
    end
end
%En el figure 2 se crea la colita del logo de Messenger por medio de rectas
%y varias condicionales unidas entre sí, para que funcionen las 
%condiciones en conjunto se debe poner todas entre un gran paréntesis.
figure(7), imshow(uint8(f))
title('Elipse con Colita Logo Messenger, Visión Plana')

%Rayo del logo de Messenger, este se crea a partir de la intersección de 3
%rectas que crean 4 triángulos distintos.
%Triángulo 1
for i = 1:T
    for j = 1:T
        if((j>-0.94*i + 194.84) && (j<-1.81*i+333.56) && (j<0.93*i - 6.62))
            f(i,j) = 255;
        end
    end
end
%Triángulo 2
for i = 1:T
    for j = 1:T
        if((j>-0.94*i+194.84) && (j<-1.81*i+333.56) && (j>0.93*i-6.62) && (j<0.96*i+32.71))
            f(i,j) = 255;
        end
    end
end
%Triángulo 3
for i = 1:T
    for j = 1:T
        if((j>0.93*i-6.62) && (j<0.96*i+32.71) && (j>-1.81*i+333.56) && (j<-1.78*i+359.93))
            f(i,j) = 255;
        end
    end
end
%Triángulo 4
for i = 1:T
    for j = 1:T
        if((j>-1.78*i+359.93) && (j<-0.93*i+289.25) && (j>0.93*i-6.62))
            f(i,j) = 255;
        end
    end
end
%En el último figure es donde se unen todas las formas creadas en la
%función f y los demás figures creados.
figure(8), mesh(f)
title('Logo Messenger Completo, Visión 3D con Comando mesh')
figure(9), imshow(uint8(f))
title('Logo Messenger Completo, Visión Plana')




%LOGO ADIDAS: De esta manera se crean logos donde sí se cruzan las
%lineas que se utilizan para crear el logo.
%T = 0 a 255 es el rango porque el código rgb ocupa esos números
T = 256;
%255 = blanco
%0 = negro

%Fondo blanco
for i = 1:T
    %i = eje vertical, dirección: arriba hacia abajo.
    for j = 1:T
        %j = eje horizontal, dirección: izquierda a derecha.
        f(i,j) = 255;
    end
end
%Valor intermedio de la función f para almacenar el fondo blanco del logo, 
%es necesario declarar este valor aunque no se asigne a ningún figure.

%Franjas del logo de Adidas
for i = 1:T
    %Franja superior
    for j = 1:T
        %Las rayas del logo de Adidas se crea a partir de rectas y
        %varias condicionales unidas entre sí.
        if ((j>-1.68*i+168.53) && (j>0.583*i+100.26) && (j<0.583*i+168.53))
             f(i,j)=0;
        end
    end
    %Franja intermedia
    for j = 1:T
        if ((j>-1.68*i+195.2) && (j>0.583*i+10.66) && (j<0.583*i+76.8))
             f(i,j)=0;
        end
    end
    %Franja inferior
    for j = 1:T
        if ((j>-1.68*i+222.93) && (j>0.583*i-77.73) && (j<0.583*i-13.05))
             f(i,j)=0;
        end
    end
    %Fondo inferior blanco
    for j = 1:T
        if (i>180)
             f(i,j)=255;
        end
    end
end
%En el figure 1 se crea el logo de Adidas por medio de rectas y varias 
%condicionales unidas entre sí, para que funcionen las condiciones en 
%conjunto, se debe poner todas entre un gran paréntesis.
figure(10), mesh(f)
title('Logo Adidas, Visión 3D con Comando mesh')
figure(11), imshow(uint8(f))
title('Logo Adidas, Visión Plana')




%GRAFICACIÓN DE UN CIRCULO CON ORIGEN EN LA ESQUINA SUPERIOR IZQ
T=255;
f=zeros(256);
R=100;
for i=1:T
    for j=1:T
        if(j^2+i^2>R^2)
            %La igualación en el if lo que hace es afectar en la pendiente
            %de lo que se ejecuta en la figure, esto es porque en esta
            %ecuación j=y, i=x, por lo que j==i crea una pendiente de 45°,
            %debido a que y=x, ya que siempre en computación el origen se
            %encuentra en la esquina superior izquierda, por lo que no
            %existe el concepto de las x o y negativas.
            f(i,j)=255;
        end
    end
end
figure(12)
mesh(f)
title('Círculo Origen Esquina Superior Izq, Visión 3D con Comando mesh')
figure(13)
imshow(uint8(f))
title('Círculo Origen Esquina Superior Izq, Visión Plana')




%GRAFICACIÓN DE UN CIRCULO CON ORIGEN EN EL CENTRO DEL FIGURE
T=255;
f=zeros(256);
R=100;
for i=1:T
    for j=1:T
        if((j-T/2)^2+(i-T/2)^2>R^2)
            %La igualación en el if lo que hace es afectar en la pendiente
            %de lo que se ejecuta en la figure, esto es porque en esta
            %ecuación j=y, i=x, por lo que j==i crea una pendiente de 45°,
            %debido a que y=x, ya que siempre en computación el origen se
            %encuentra en la esquina superior izquierda, por lo que no
            %existe el concepto de las x o y negativas.
            f(i,j)=255;
        end
    end
end
figure(14)
mesh(f)
title('Círculo Origen Centro, Visión 3D con Comando mesh')
figure(15)
imshow(uint8(f))
title('Círculo Origen Centro, Visión Plana')




%GRAFICACIÓN DE UNA ELIPSE CON ORIGEN EN EL CENTRO DEL FIGURE
T=255;
f=zeros(256);
a=50;
b=100;
for i=1:T
    for j=1:T
        if(((i-T/2)/a)^2+((j-T/2)/b)^2>1)
            %La igualación en el if lo que hace es afectar en la pendiente
            %de lo que se ejecuta en la figure, esto es porque en esta
            %ecuación j=y, i=x, por lo que j==i crea una pendiente de 45°,
            %debido a que y=x, ya que siempre en computación el origen se
            %encuentra en la esquina superior izquierda, por lo que no
            %existe el concepto de las x o y negativas.
            f(i,j)=255;
        end
    end
end
figure(16)
mesh(f)
title('Elipse Origen Centro, Visión 3D con Comando mesh')
figure(17)
imshow(uint8(f))
title('Elipse Origen Centro, Visión Plana')




%GRAFICACIÓN DE UNA HIPÉRBOLA CON ORIGEN EN EL CENTRO DEL FIGURE
T=255;
f=zeros(256);
a=50;
b=100;
for i=1:T
    for j=1:T
        if(((i-T/2)/a)^2-((j-T/2)/b)^2>1)
            %La igualación en el if lo que hace es afectar en la pendiente
            %de lo que se ejecuta en la figure, esto es porque en esta
            %ecuación j=y, i=x, por lo que j==i crea una pendiente de 45°,
            %debido a que y=x, ya que siempre en computación el origen se
            %encuentra en la esquina superior izquierda, por lo que no
            %existe el concepto de las x o y negativas.
            f(i,j)=255;
        end
    end
end
figure(18)
mesh(f)
title('Hipérbola Origen Centro, Visión 3D con Comando mesh')
figure(19)
imshow(uint8(f))
title('Hipérbola Origen Centro, Visión Plana')




%GRAFICACIÓN DE UNA SEÑAL SENO, CAJA DE HUEVO
%Como el seno va de -1 a 1, debemos amplificar la señal para que se pueda
%ver en el figure, recordemos que i=x, j=y
T=256;
w=0.07;
A=T/2;
offset=T/2;
for i=1:T
    for j=1:T
        %Si aquí pongo i o j multiplicando la señal f, lo que hará es
        %cambiar la dirección en la que se grafica, ya sea vertical (j) u
        %horizontalmente (i)
        f(i,j)=1/2*A*sin(w*i)+offset+1/2*A*sin(w*j)+offset;
    end
end
figure(20)
mesh(f)
title('Señal Seno - Caja de Huevo, Visión 3D con Comando mesh')
figure(21)
imshow(uint8(f))
title('Señal Seno - Caja de Huevo, Visión Plana')




%CUBO DE COLORES RGB:
%CARA INFERIOR DEL CUBO DE COLOR
%Visualización de las capas del cubo de color
T=256;
%valor máximo de cada color rgb
max=255;
for i=1:T
    for j=1:T
        %variación de rojo
        f(i,j,1)=i;
        %variación de verde
        f(i,j,2)=j;
        %variación de azul
        f(i,j,3)=0;
    end
end
figure(22)
imshow(uint8(f))
title('Cara Inferior - Cubo de Color, Visión Plana')

%CARA FRONTAL DEL CUBO DE COLOR
%Visualización de las capas del cubo de color
T=256;
%valor máximo de cada color rgb
max=255;
for i=1:T
    for j=1:T
        %variación de rojo
        f(i,j,1)=max;
        %variación de verde
        f(i,j,2)=i;
        %variación de azul
        f(i,j,3)=j;
    end
end
figure(23)
imshow(uint8(f))
title('Cara Frontal - Cubo de Color, Visión Plana')

%CARA LATERAL IZQUIERDA DEL CUBO DE COLOR
%Visualización de las capas del cubo de color
T=256;
%valor máximo de cada color rgb
max=255;
for i=1:T
    for j=1:T
        %variación de rojo
        f(i,j,1)=i;
        %variación de verde
        f(i,j,2)=max;
        %variación de azul
        f(i,j,3)=j;
    end
end
figure(24)
imshow(uint8(f))
title('Cara Lateral Izq - Cubo de Color, Visión Plana')

%CARA LATERAL DERECHA DEL CUBO DE COLOR
%Visualización de las capas del cubo de color
T=256;
%valor máximo de cada color rgb
max=255;
for i=1:T
    for j=1:T
        %variación de rojo
        f(i,j,1)=i;
        %variación de verde
        f(i,j,2)=0;
        %variación de azul
        f(i,j,3)=j;
    end
end
figure(25)
imshow(uint8(f))
title('Cara Lateral Der - Cubo de Color, Visión Plana')

%CARA TRASERA DEL CUBO DE COLOR
%Visualización de las capas del cubo de color
T=256;
%valor máximo de cada color rgb
max=255;
for i=1:T
    for j=1:T
        %variación de rojo
        f(i,j,1)=0;
        %variación de verde
        f(i,j,2)=i;
        %variación de azul
        f(i,j,3)=j;
    end
end
figure(26)
imshow(uint8(f))
title('Cara Trasera - Cubo de Color, Visión Plana')

%CARA SUPERIOR DEL CUBO DE COLOR
%Visualización de las capas del cubo de color
T=256;
%valor máximo de cada color rgb
max=255;
for i=1:T
    for j=1:T
        %variación de rojo
        f(i,j,1)=i;
        %variación de verde
        f(i,j,2)=j;
        %variación de azul
        f(i,j,3)=max;
    end
end
figure(27)
imshow(uint8(f))
title('Cara Superior - Cubo de Color, Visión Plana')




%CARAS DEL CUBO DE COLOR
%Visualización de las capas del cubo de color con una variación inusual
T=256;
%valor máximo de cada color rgb
max=255;
for i=1:T
    for j=1:T
        %variación de rojo
        f(i,j,1)=i;
        %variación de verde, campana de gauss
        f(i,j,2)=255*exp(-((i-T/2)^2+(j-T/2)^2)/1000);
        %variación de azul
        f(i,j,3)=j;
    end
end
figure(28)
imshow(uint8(f))
title('Variación Gauss - Cubo de Color, Visión Plana')