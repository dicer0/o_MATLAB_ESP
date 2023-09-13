clc
clear all
close all

%SUAVIZADO DE IMÁGENES - Filtro Binomial: Este lo que hace es difuminar, si 
%se aplica a una imagen con una Máscara de Sobel que reconoce bordes, puede 
%elegirse un tamaño de filtro en específico para que solamente se 
%reconozcan los bordes que nos sirvan, en vez de reconocerlos todos.

%imread(): comando para leer una imagen y convertirla a matrices de 3 
%dimensiones, que prácticamente se ve como un cubo, del cubo de colores se 
%obtienen 3 capas, osea 3 matrices una encima de otra, todas con el mismo 
%número de filas y columnas, de este cubo se extraen las distintas capas 
%para obtener los colores RGB.
IMA = imread('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\Yo merengues.jpg');
%rgb2gray(): Comando que extrae el cubo matricial de la imagen obtenida con 
%imread y hace un tipo de promedio con todos los colores para obtener una 
%escala de grises que no le da prioridad a ningún color R, G o B en 
%específico.
f = double(rgb2gray(IMA));

%Dimensionamiento de la matriz obtenida: Con el método size aplicado a una 
%matriz cualquiera, se obtiene primero el número de filas y luego el
%número de columnas.
[filas, columnas] = size(f);

%FILTRO BINOMIAL: Este se basa en el triángulo de Pascal,el cual se usa 
%para desarrollar binomios a la n potencia, es importante mencionar que 
%solo se usan las filas que tengan un número de elementos impares:
%             1              -> 1       ✓
%          1    1            -> 2
%        1    2   1          -> 4       ✓
%      1   3    3   1        -> 8
%    1   4    6   4   1      -> 16      ✓
%  1   5   10  10   5  1     -> 32
%1  6   15  20  15   6   1   -> 64      ✓

%Cuando un pixel llega a presentar una diferencia en comparación con los 
%valores RGB o gris de sus pixeles próximos, se identifica eso como un 
%factor de ruido, el suavizado lo que hace es realizar una convolución de 
%un pixel junto con sus pixeles próximos, que son los pixeles de arriba, 
%abajo, a un lado y a el otro, estos son analizados y llamados vecindad, lo 
%que pasará es que se tratará de corregir y quitar esos pixeles que tienen 
%ruido, esto se aplica a todos los pixeles que conforman la imagen, se hace 
%siguiendo la fórmula descrita a continuación, donde h es el factor del
%filtrado o suavizado de la imagen, para ello se obtiene un factor hp que
%depende de la fila que se tome del triángulo de Pascal y la suma de esa
%fila que se tomó, donde s es la suma de la fila que se tomó y f es la fila
%que se tomó pero en forma de vector:
%hp = (1/s)*(f)
%Por ejemplo, si tomamos la tercera fila del trángulo de Pascal se obtiene: 
%hp = (1/4)*[1,2,1]
%Luego se multiplica hp transpuesta con hp normal y eso se dividide entre 
%la norma de sí misma y como resultado se obtiene la matriz h del filtro:
%h = hp' * hp / norm(hp' * hp)

%Los filtros deben ser de tamaño impar para que el pixel que se está
%analizando quede en el centro de la vecindad.
%Fila del triángulo de Pascal con un número impar de elementos.
b = [1,6,15,20,15,6,1]; 
h = (b'*b)/sum(sum(b'*b))
%El tamaño del filtro indica el número de elementos de la fila obtenida del 
%triángulo de Pascal.
%T = 7; Elementos de la fila del triángulo de Pascal
[filas_TrianguloPascal, T] = size(b);

%Para ello se debe extraer de la matriz f (que es la escala de grises de la
%imagen original) pequeñas partes de 3X3 para poder aplicar el filtro h, se
%indica que parta desde la posición 2 hasta el número de filas y columnas
%-1 porque el número de inicio es el centro de la matriz y de ahí parte a 
%sus demás coordenadas, ya que los demás pixeles que se analizan deben 
%tener el mismo tamaño del filtro, por eso es que se le resta cierto valor 
%a las filas y columnas del bucle, como se ve en los siguientes tamaños de 
%filtro:
%T = 3, inicio:2, final: filas-1
%T = 5, inicio:3, final: filas-2
%T = 7, inicio:4, final: filas-3
%Para obtener esta relación en el inicio y el final se usan las fórmuas:
%T = tamaño filtro, inicio: (T+1)/2, final: (T-1)/2
%Para probar varios filtros se crea un bucle for que pruebe varios valores
%de T y vaya de 2 en 2.

for i = (T+1)/2:filas-(T-1)/2
    for j = (T+1)/2:columnas-(T-1)/2
        %Extracción de las submatrices, esta para que se pueda aplicar a 
        %cualquier tamaño de filtro se hace lo mismo que se hizo en los 
        %límites del bucle, pero solo en las partes donde hay una suma o 
        %resta
        I = f(i-(T-1)/2:i+(T-1)/2, j-(T-1)/2:j+(T-1)/2);
        %De la siguiente manera ya que se hayan obtenido las submatrices de 
        %la matriz original que describe la imagen, simplemente se 
        %multiplica por el filtro h cada una de ellas, a esto se le aplica 
        %convolución para obtener un solo dato de cada pixel.
        g(i-1,j-1) = sum(sum(I.*h));
    end
end

%MÁSCARA DE SOBEL: Obtención de bordes.
%Es importante aplicar la Máscara de Sobel hasta después de haber 
%aplicado el Filtro Promediador para no afectar la resolución del 
%resultado y eliminar de mejor manera el ruido de la imagen original, 
%ya que en la imagen donde ya se aplicó la máscara, el borde es 
%resaltado y puede ser considerado erróneamente como ruido por el 
%filtro.
figure(1), imshow(uint8(n1_MASCARA_SOBEL(g)))
title(strcat('Suavizado - Filtro Binomial: Tamaño T=', num2str(T)))

%Impresión de las capturas para su comparación: Se puede observar que en un
%inicio a la función g que fue la resultante después de haber aplicado el
%filtro, se ve igual pero un poco más borrosa.
figure(2), imshow(uint8(f))
title('Imagen en Escala de Grises - Matriz 2D')

%Si a la imagen que tiene el Filtro Promediador se le aplica la Máscara de 
%Sobel que identifica bordes, el resultado es una imagen donde los bordes 
%ya no se ven tan remarcados en algunas zonas, esto lo que hace es 
%disminuir el ruido y pasa porque las máscaras de Sobel, Prewitt y 
%Gradiente son derivadas, por eso es que ellas exageran razgos de la imagen 
%sin control, pero con el suavizado de imagenes estos razgos se suavizan.
figure(3), imshow(uint8(n1_MASCARA_SOBEL(f)))
title('Bordes - Máscara de Sobel G')

%El filtro binomial tiene como característica no difuminar demasiado los
%bordes de la imagen cuando realiza el filtrado, siendo una buena opción
%para filtrar una imagen aún en comparación contra el filtro gaussiano, el
%problema es que para aplicar tamaños de filtros muy elevados se debe
%obtener su fila correspondiente en el triángulo de Pascal.