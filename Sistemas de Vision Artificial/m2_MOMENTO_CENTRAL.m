%Momento Central: Se le pasa como argumento una función f con la imagen en 
%escala de grises, además se le introducen los factores p y q que indican 
%las potencias de las variables xy del Momento Central, el cual es una 
%integral doble pero aplicada de forma digital, por lo que se convierte en 
%una sumatoria doble y por último se le introducen las coordenadas "xc" y 
%"yc", obtenidas a partir del cálculo del Momento Inicial.
%Momento central/inicial: Se obtiene al dividir puntos específicos del 
%Momento Inicial obtenido de la imagen f, esta tiene dos coordenadas: 
%X̄ = xc = m10/m00; Ȳ = yc = m01/m00
function upq = m2_MOMENTO_CENTRAL(f, p, q, xc, yc)
    %Momento Central = μpq = ΣΣ((x-X̄)^p)*((y-Ȳ)^q)*f(x,y)
    %size(): Método que obtiene la cantidad de filas y columnas de la 
    %imagen en escala de grises (f).
    [filas, columnas] = size(f);
    
    %meshgrid(): Comando que obtiene submatrices de una matriz muy grande, 
    %de esta manera se crea una matriz que parta desde 1 hasta el número de 
    %columnas de la imagen en escala de grises, yendo de izquierda a 
    %derecha para el caso de "X" y para el caso de "Y" pasa lo mismo pero 
    %partiendo de 1 hasta el número de filas contadas de arriba hacia 
    %abajo.
    [X, Y] = meshgrid(1:columnas, 1:filas);
    
    %El momento central se obtiene al multiplicar las coordenadas (X-xc) y 
    %(Y-yc) de la imagen en escala de grises por unas potencias llamadas p 
    %y q, estas variables indican el órden del momento y pueden tener 
    %valores de 0 a ∞, pero usualmente adoptan valores de 0 a 3 para 
    %después con ellos obtener los Momentos Normalizados e Invariantes de 
    %Hu. En la fórmula original lo que se aplica es una integral doble de 
    %área con las variables xy elevadas a la potencia %"p" y "q" 
    %multiplicadas por la función f(x,y) que representa la escala de 
    %grises, pero como las imágenes son digitales, en cambio se realiza 
    %una sumatoria doble.
    %Momento Central = μpq = ΣΣ((x-X̄)^p)*((y-Ȳ)^q)*f(x,y) 
    upq = sum(sum(((X-xc).^p).*((Y-yc).^q).*f));
end