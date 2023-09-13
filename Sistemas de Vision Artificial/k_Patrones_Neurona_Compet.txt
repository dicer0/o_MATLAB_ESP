clc
clear all
close all

%RECONOCIMIENTO DE PATRONES CON NEURONAS: Se realiza por medio del comando 
%compet() y para ello se declaran ciertos puntos con valores dentro del 
%plano cartesiano XY. 
%En la visión artificial, se emplean técnicas de RECONOCIMIENTO DE PATRONES 
%SUPERVISADO para el reconocimiento óptico de caracteres (OCR), la 
%detección facial, el reconocimiento facial, la detección de objetos y la 
%clasificación de objetos. 
%En el procesamiento de imágenes y la visión artificial, se emplean 
%técnicas de RECONOCIMIENTO DE PATRONES NO SUPERVISADO para la detección de 
%objetos y la segmentación de imágenes.
%REDES NEURONALES COMPETITIVAS (COMPET): Este tipo de redes a diferencia de
%los demás tipos donde las neuronas colaboran entre sí para que a través 
%del aprendizaje se pueda dar una representación al patrón de entrada, en 
%el caso de una red competitiva, las neuronas compiten unas con otras de 
%manera que solo una se activará al final, dicho de otra manera, solo esta 
%neurona será capaz de representar el patrón de entrada.
P1 = [1;1];
P2 = [-1;1];
P3 = [-1;-1];
P4 = [1;-1];

%Patrón de prueba de la neurona, debe ser un vector que solo tenga 1
%columna y varias filas:
PP = [-0.5;-0.3];

%En esta variable P se adjuntan todas las coordenadas de los puntos XY,
%esto para poder encotrar el patrón entre ellas.
P = [P1 P2 P3 P4]

%Se tratará de encontrar el patrón de los puntos midiendo el ángulo entre
%los vectores, para ello se usa la expresión del producto punto:
%P1.PP = |P1||PP|cosθ
%El producto punto da 0 cuando el angulo θ = 90° o 270°
%El producto punto da 1 cuando el angulo θ = 0°
%El producto punto da -1 cuando el angulo θ = 180°
%Esta teoría se considera solo cuando se convierte el vector a vector
%unitario, analizándose por medio de redes neuronales competitivas.
%El comando size devuelve el número de filas y columnas de una matriz en
%ese orden.
[NE, NP] = size(P);
%NE = Cantidad de elementos, osea el número de filas.
%NP = Cantidad de patrones, osea el número de columnas.

for i = 1:NP
    %De esta forma se obtiene el vector en su forma unitaria de cada uno de
    %los vectores descritos en la matriz P.
    
    %W: Es una matriz que guarda los valores unitarios de la matriz y
    %representa el peso (weight) de la conexión neuronal, los pesos son 
    %parámetros importantes en una red neuronal, ya que se multiplicarán 
    %con los datos de entrada "X" y con las salidas de las neuronas de la 
    %capa anterior "A", cada parametro W es diferente para cada neurona ya 
    %que en estos parametros se guardan los patrones que la neurona 
    %aprendió sobre los datos introducidos anteriormente.
    
    %norm(): El método norm devuelve la magnitud de un vector, donde la
    %fórmula es: %norma_vector = √Σv1^2+...+vn^2
    W(:,i) = P(:,i)/norm(P(:,i));
end

%De esta manera se obtiene el valor de los pesos de la neurona:
PP = PP/norm(PP);

%Ahora para obtener los patrones se pone W transpuesta y se multiplica por
%PP que es el valor de los pesos de la neurona.
%compet(): Función de transferencia neuronal que busca de toda la columna 
%del vector el valor más alto de todos y lo vuelve 1, los demás valores los 
%vuelve cero.
%La neurona compet se basa en el producto punto, donde busca la que más se 
%parezca a cierto valor PP dado.
a = compet(W'*PP)      %A la variable "a" se le llama axon neuronal.

%max(): Comando que devuelve el valor que sea mayor y la posición donde se
%encuentra.
[b,c] = max(a)