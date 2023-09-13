%FILTRO DE CANNY: Para aplicar este filtro primero se debió haber 
%aplicado el filtro Gaussiano que realiza un suavizado de la imagen y da 
%como resultado una función h que recibe también como parámetro al tamaño T 
%del filtro que debe ser impar siempre y una variable sigma que afecta la 
%falda de la función gaussiana, haciendo su curva más angosta mientras 
%menor sea su valor y más ancha mientras mayor sea su valor.

%G: Se refiere a la magnitud del gradiente G de Canny.
%phi2: Se refiere al ángulo del gradiente phi2 de Canny.

%GRADIENTE DE CANNY: Sirve para cerrar y adelgazar los bordes de la figura 
%analizada en la imagen, evitando así posibles errores durante la
%identificación de figuras al aplicar visión artificial, ya que mientras
%más delgado sea el borde, mejor lo podrá analizar el programa, de tal
%forma que pueda obtener hasta su firma.
function [G, phi2] = s2_GRADIENTE_CANNY(J)
    %size(): Comando que devuelve el número de filas y columnas de una 
    %matriz en ese orden.
    %El Gradiente Canny se aplica a la matriz J después del suavizado
    %realizado con el Filtro Gaussiano y luego el Filtro Canny.
    [filas, columnas] = size(J);
    for i = 2:filas-1
        for j = 2:columnas-1
            %Gx = f(x+Δx,y(cte))-f(x-Δx,y(cte))/Δx*Sx
            %Gy = f(x(cte),y+Δy)-f(x(cte),y-Δy)/Δx*Sy
            Gx(i-1,j-1) = (J(i+1,j)-J(i-1,j))/2;
            Gy(i-1,j-1) = (J(i,j+1)-J(i,j-1))/2;
            G(i-1,j-1) = sqrt(Gx(i-1,j-1)^2+Gy(i-1,j-1)^2);
            %atand: Resultado de la tangente expresada en grados
            phi1(i-1,j-1) = atand(Gy(i-1,j-1)/Gx(i-1,j-1));
            phi2(i-1,j-1) = atan2d(Gy(i-1,j-1), Gx(i-1,j-1));
        end
    end
end