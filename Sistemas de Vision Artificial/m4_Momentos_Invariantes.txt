clc
clear all
close all

%MOMENTOS INVARIANTES DE HU: Estos sirven para identificar un rostro en una
%imagen, no importando si este se encuentra de cerca en una imagen, en 
%tamaño pequeño, tamaño grande, volteado o no. Si se coloca un umbral para 
%identificar al un rostro o personaje en la imagen, se podrá identificar
%siempre, para ello se usan los llamados Momentos invariantes de Hu, pero
%para poder obtenerlos primero se deben obtener los momentos iniciales,
%centrales y normalizados de la imagen.

%zeros(): Método que en este caso crea una matriz vacía para mostrar los 
%valores de los momentos invariantes con 3 filas y 25 columnas, cada 
%columna representa una imagen y cada fila representa el valor de algún 
%momento invariante.
resultados = zeros(3,25);

for i = 1:25
    %strcat(): Método que permite concatenar horizontalmente el texto en 
    %sus argumentos de entrada.
    ruta = strcat('C:\Users\diego\OneDrive\Documents\MATLAB\Sistemas de Vision Artificial\img\3_Momentos Invariantes de Hu\', num2str(i), '.bmp');
    %imread(): comando para leer una imagen y convertirla a matrices de 3 
    %dimensiones, que prácticamente se ve como un cubo, del cubo de colores 
    %se obtienen 3 capas, osea 3 matrices una encima de otra, todas con el 
    %mismo número de filas y columnas, de este cubo se extraen las 
    %distintas capas para obtener los colores RGB.
    IMA = imread(ruta);    
    %rgb2gray(): Comando que extrae el cubo matricial de la imagen obtenida 
    %con imread y hace un tipo de promedio con todos los colores para 
    %obtener una escala de grises que no le da prioridad a ningún color 
    %R, G o B en específico.
    GRIS = rgb2gray(IMA);

    %UMBRAL Y MOMENTOS INICIALES:
    %En la variable f se hace una comparación aplicada a los valores de
    %gris obtenidos después de utilizar el comando rgb2gray, con esto se
    %obtiene una configuración de imagen. El número de comparación puede ir 
    %de 1 a 256 y se le llama umbral.
    f = double(GRIS < 200);    
    %Momento inicial = mpq = ΣΣ(x^p)*(y^q)*f(x,y), este se obtiene a partir
    %de una función creada en MATLAB llamada m1_MOMENTO_INICIAL, de esta
    %manera se pueden obtener los momentos iniciales elevados a varias
    %potencias distintas dadas por "p" (que es el segundo parámetro) y "q"
    %(que es el tercer parámetro), donde debido a que las imágenes son
    %bidimensionales, normalmente adoptan valores de 0 a 2 máximo, ya que
    %de esa forma se conserva que la integración sea de área y además son
    %las que se utilizan para obtener los Momentos centrales, normalizados
    %e invariantes.
    m00 = m1_MOMENTO_INICIAL(f, 0, 0);
    m01 = m1_MOMENTO_INICIAL(f, 0, 1);
    m10 = m1_MOMENTO_INICIAL(f, 1, 0);
    %Momento central/inicial: Se obtiene al dividir puntos específicos del 
    %momento inicial obtenido de la imagen f, esta tiene dos coordenadas 
    %X̄, Ȳ; donde sus fórmulas son las siguientes:
    xc = m10/m00;       %X̄ = m10/m00 
    yc = m01/m00;       %Ȳ = m01/m00
    
    %MOMENTOS CENTRALES:
    %Momento central = μpq = ΣΣ((x-X̄)^p)*((y-Ȳ)^q)*f(x,y)
    u00 = m2_MOMENTO_CENTRAL(f, 0, 0, xc, yc);%Para los momentos normalizados
    u20 = m2_MOMENTO_CENTRAL(f, 2, 0, xc, yc);
    u02 = m2_MOMENTO_CENTRAL(f, 0, 2, xc, yc);%M1 = η20+η02
    u11 = m2_MOMENTO_CENTRAL(f, 1, 1, xc, yc);%M2 = ((η20+η02)^2)+4η11
    u30 = m2_MOMENTO_CENTRAL(f, 3, 0, xc, yc);
    u03 = m2_MOMENTO_CENTRAL(f, 0, 3, xc, yc);
    u12 = m2_MOMENTO_CENTRAL(f, 1, 2, xc, yc);
    u21 = m2_MOMENTO_CENTRAL(f, 2, 1, xc, yc);%M3 = ((η30-3η12)^2)+((3η21-η03)^2)
    
    %MOMENTOS NORMALIZADOS:
    %Momento normalizado = ηpq = μpq/μ00^δ, donde:
    %δ = ((p+q)/2)+1, si p+q > 1, osea 2,3,..
    %δ = 1, si p+q <= 1, osea 0 o 1.
    %M1 = η20+η02
    n20 = m3_MOMENTO_NORMALIZADO(u20, u00, 2, 0);
    n02 = m3_MOMENTO_NORMALIZADO(u02, u00, 0, 2);
    %M2 = ((η20+η02)^2)+4η11
    n11 = m3_MOMENTO_NORMALIZADO(u11, u00, 1, 1);
    %M3 = ((η30-3η12)^2)+((3η21-η03)^2)
    n30 = m3_MOMENTO_NORMALIZADO(u30, u00, 3, 0);
    n03 = m3_MOMENTO_NORMALIZADO(u03, u00, 0, 3);
    n12 = m3_MOMENTO_NORMALIZADO(u12, u00, 1, 2);
    n21 = m3_MOMENTO_NORMALIZADO(u21, u00, 2, 1);
    
    %MOMENTOS INVARIANTES DE HU: Se obtienen a partir de ciertas ecuaciones
    %que utilizan los Momentos Normalizados, que se obtienen a partir de
    %los Momentos Centrales, que a su vez se obtienen a partir de los 
    %Momentos Iniciales.
    mhi1 = n20+n02;                         %M1 = η20+η02
    mhi2 = ((n20-n02)^2)+4*n11;             %M2 = ((η20+η02)^2)+4η11
    mhi3 = ((n30-3*n12)^2)+((3*n21-n03)^2); %M3 = ((η30-3η12)^2)+((3η21-η03)^2)
    
    %subplot(filas, columnas, posición): Método que crea una ventana con
    %múltiples elementos que puedo acomodar al gusto.
    subplot(5,5,i), imshow(uint8(255*f))
    title(strcat(num2str(mhi1), ',  ', num2str(mhi2), ',  ', num2str(mhi3)))
    resultados(1, i) = mhi1;
    resultados(2, i) = mhi2;
    resultados(3, i) = mhi3;
end

objetos1 = resultados(1:3,1:5)
objetos2 = resultados(1:3,6:10)
objetos3 = resultados(1:3,11:15)
objetos4 = resultados(1:3,16:20)
objetos5 = resultados(1:3,21:25)
