%MATRIZ DE RIGIDEZ EN ESTRUCTURA 2D
%Esta función devuelve la matriz de rigidez del elemento para un elemento 
%de armadura 2D con módulo de elasticidad E, área de sección transversal 
%A, longitud L y ángulo theta (en grados). 
%El tamaño de la matriz de rigidez del elemento es 4 x 4, osea que es para
%asignar sus propiedades mecánicas a cada barra de una estructura 2D.
function y = a_MatrizRigidezEstructura2D(E, A, L, theta)
x = theta*pi/180;           %Convierte el ángulo de inclinación a radianes
C = cos(x);                 %Componente horizontal del elemento
S = sin(x);                 %Componente vertical del elemento
y = E*A/L*[C*C C*S -C*C -C*S ; 
           C*S S*S -C*S -S*S ;
           -C*C -C*S C*C C*S ; 
           -C*S -S*S C*S S*S];