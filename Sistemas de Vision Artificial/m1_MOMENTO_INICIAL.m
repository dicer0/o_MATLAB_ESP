%Momento Inicial: Se le pasa como argumento una función f que es una imagen 
%en escala de grises, además se le introducen los factores p y q que 
%indican las potencias de las variables xy del Momento Inicial, el cual es 
%una integral doble pero aplicada de forma digital, por lo que se convierte 
%en una sumatoria doble, este es solo el primer paso para obtener el 
%momento invariante de la imagen, aplicado para el reconocimiento de 
%figuras, que pueden ser rostros, personajes, etc.
function mpq = m1_MOMENTO_INICIAL(f, p, q)
    %Momento Inicial = Mpq = ΣΣ(x^p)*(y^q)*f(x,y)
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
    
    %El momento inicial se obtiene al multiplicar las coordenadas XY de la
    %imagen en escala de grises por unas potencias llamadas p y q, estas 
    %variables indican el órden del momento y pueden tener valores de 0 a 
    %∞, pero usualmente adoptan valores de 0 a 1 para después con ellos 
    %obtener el Momento Central. En la fórmula original lo que se aplica es 
    %una integral doble de área con las variables xy elevadas a la potencia 
    %"p" y "q" multiplicadas por la función f(x,y) que representa la escala 
    %de grises, pero como las imágenes son digitales, en cambio se realiza 
    %una sumatoria doble.
    %Momento Inicial = mpq = ΣΣ(x^p)*(y^q)*f(x,y)
    mpq = sum(sum((X.^p).*(Y.^q).*f));
end