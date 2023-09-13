%FILTRO GAUSSIANO: El filtro gaussiano lo que hace es aplicar una función 
%Gaussiana discreta, donde se busca que el punto más alto de la campana de 
%Gauss (su curva) se encuentre justo en donde está el pixel central de la 
%imagen que se quiere analizar, recordemos que el tamaño T del filtro debe 
%ser impar siempre.
%La variable sigma afecta la falda de la función gaussiana, haciendo su
%curva más angosta mientras menor sea el valor de sigma y más ancha 
%mientras mayor sea el valor de sigma.
function h = p1_FILTRO_GAUSSIANO(T, sig)
    for i = 1:T
        for j = 1:T
            %Es importante mencionar que para que el Filtro Gaussiano
            %funcione, la curva de la función gaussiana debe interseccionar
            %con el pixel principal que se analiza, no con la vecindad sino
            %con el central, para que esto pase se debe considerar el
            %tamaño T del filtro, teniendo así la función gaussiana 3D 
            %centrada en un punto.
            %Además se debe considerar que el plano xy de la campana 
            %Gaussiana se encuentre sobre la matriz donde se encuentra la 
            %imagen y la dirección z de la campana Gaussiana es donde se 
            %encuentra su curva, ya que esta es 3D.
            h(i,j) = exp(-((i-T/2-1/2)^2+(j-T/2-1/2)^2)/(2*(sig^2)));
        end
    end
%Al dividir el filtro h entre la norma de si mismo se obtiene el filtro
%gaussiano:
%h = h / norm(h) = h / sum(sum(h))
h = h/sum(sum(h));