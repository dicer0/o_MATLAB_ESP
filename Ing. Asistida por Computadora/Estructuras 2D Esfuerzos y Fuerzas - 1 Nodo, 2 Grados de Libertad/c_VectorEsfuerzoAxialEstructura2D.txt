%VECTOR DE ESFUERZOS EN ESTRUCTURA 2D
%Esta función retorna el esfuerzo del elemento, dado su módulo de
%elasticidad, longitud, ángulo de inclinación en grados y el vector de
%desplazamiento de los grados de libertad de cada nodos (u).
function y = c_VectorEsfuerzoAxialEstructura2D(E, L, theta, u)
x = theta * pi/180;         %Convierte el ángulo de inclinación a radianes
C = cos(x);                 %Componente horizontal del elemento
S = sin(x);                 %Componente vertical del elemento
y = E/L*[-C -S C S]* u;     %Fórmula del esfuerzo axial calculado