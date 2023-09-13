%FILTRO DE CANNY: Para aplicar este filtro primero se debió haber 
%aplicado el filtro Gaussiano que realiza un suavizado de la imagen y da 
%como resultado una función h que recibe también como parámetro al tamaño T 
%del filtro que debe ser impar siempre y una variable sigma que afecta la 
%falda de la función gaussiana, haciendo su curva más angosta mientras 
%menor sea su valor y más ancha mientras mayor sea su valor.
function J = s1_FILTRO_CANNY(I, h)
    %Se puede determinar el tamaño del filtro T a partir de la función h,
    %que es resultado del filtro de Gauss.
    [T, a] = size(h);

    %size(): Comando que devuelve el número de filas y columnas de una 
    %matriz en ese orden.
    [filas, columnas] = size(I);

    %Bucle for para la aplicación del Gradiente Gaussiano.
    for i=(T+1)/2:filas-(T-1)/2
        for j=(T+1)/2:columnas-(T-1)/2
            J(i-(T-1)/2,j-(T-1)/2)=sum(sum(h.*I(i-(T-1)/2:i+(T-1)/2,j-(T-1)/2:j+(T-1)/2)));
        end
    end
end