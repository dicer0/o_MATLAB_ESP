clc
clear all
close all

%El comando imread lo que hace es almacenar una imagen en una variable 
%llamada IMA, la imagen de Bulbasaur en específico muestra mucho el color 
%VERDE, que es uno de los colores primarios RGB.
IMA=imread('C:\Users\diego\OneDrive\Documents\Instrumentación Virtual\Sistemas de Visión Artificial\Imagenes\Lena2.jpg');
%Con imshow lo que hacemos es mostrar la imagen almacenada en la variable
%IMA en un figure.
figure(1), imshow(IMA)
title('Imagen Original RGB - Cubo Matricial 3D')

%CONTRASTE:
%El contraste no es otra cosa que el efecto que se produce al destacar un 
%elemento visual en comparación con otro en una misma imagen, destacando
%así colores y figuras unos con otros, se hace al multiplicar la imagen 
image2=image1*1.5;
subplot(3,2,2)
imshow(image2)
title('Contraste 50%')


image3=image1+20;
subplot(3,2,3)
imshow(image3)
title('Brillo 20 niveles')

Max_image1=max(max(image1));
image2=Max_image1-image1;
subplot(3,2,4)
imshow(image2)
title('Complemento de imagen')

image4=imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\1.jpg');
image5=rgb2gray(image4);
figure(2)
H=histogram(image5);
Umbral=90;
[N,M]=size(image5);
for i=1:N
    for j=1:M
        if image5(i,j)>=Umbral
            image6(i,j)=1;
        else image6(i,j)=0;
        end
    end
end

figure(3)
subplot(1,2,1)
imshow(image4)
title('Original')

subplot(1,2,2)
imshow(image6)
title('Binaria')