clc
clear all
close all

%TRANSFORMADA DE FOURIER:
filas = 600;
columnas = 700;
%Se pone un rango de w1: punto_inicial:intervalo:punto_final
for w1= 0.001:0.1:1
    for i = 1:filas
        for j = 1:columnas
            f(i,j) = ((-1)^(i+j))*(1*sin(w1*i)+1*sin(w1*j))/2;
        end
    end
    %f se va a convertir en una imagen, por lo que se podrá mostrar con el
    %comando imshow, esto se debe multiplicar por 255 porque las imágenes 
    %se muestran con un rango de 0 a 255, por eso se usa el método uint8 
    %para que solo pueda ocupar el rango de un número binario de 8 bits, 
    %2^8 = 256, por eso es que se pone una amplitud de 255/2 con un offset 
    %igual.
    figure(1), imshow(uint8(127.5*f+127.5))
    title('Transformada de Fourier - Visión Plana')
    %Se puede ver lo mismo pero ahora con el comando mesh para mostrar una
    %imagen de la gráfica 3D, que igual se verá como una animación pero 3D
    figure(2), mesh(uint8(127.5*f+127.5))
    title('Transformada de Fourier - Visión 3D con Comando mesh')
    
    %La Transformada de fourier aplicada a la función f que tiene la suma 
    %de senos, en el plano de Fourier se verán las frecuencias altas y 
    %bajas en el plano XYZ del mesh, las altas frecuencias se colocarán en 
    %la parte central de los ejes horizontales y las bajas frecuencias en 
    %las esquinas de los ejes horizontales, esto pasa con la expresión:
    %f(i,j) = (1*sin(w1*i)+1*sin(w1*j))/2;
    %Si queremos que las delta de dirac de la transformada de fourier vaya
    %del centro de la gráfica 3D para que de ahí salgan las bajas
    %frecuencias y hacia fuera sean las altas frecuencias se usa la
    %expresión:
    %f(i,j) = ((-1)^(i+j))*(1*sin(w1*i)+1*sin(w1*j))/2;
    F = fft2(f);
    figure(3), mesh(abs(F))
    title(strcat('Transformada de Fourier: W=', num2str(w1)))
    %drawnow(): Método que se utiliza dentro de un bucle for para mostrar
    %una animación.
    drawnow
end