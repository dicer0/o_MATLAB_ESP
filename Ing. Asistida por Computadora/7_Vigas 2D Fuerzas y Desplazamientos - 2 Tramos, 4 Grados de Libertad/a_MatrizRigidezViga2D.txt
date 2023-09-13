%MATRIZ DE RIGIDEZ EN ESTRUCTURA 2D
%Esta función devuelve la matriz de rigidez del elemento para una viga con 
%módulo de elasticidad E, momento de inercia I y longitud L. 
%El tamaño de la matriz de rigidez del elemento es 4 x 4, osea que es para
%asignar sus propiedades mecánicas a una viga en 2D.
%Normalmente esto se usa para resolver vigas con dos distintos módulos de 
%Elasticidad y/o Momentos de inercia.
function y = a_MatrizRigidezViga2D(E,I,L)
y = E*I/(L*L*L)*[12 6*L -12 6*L ; 6*L 4*L*L -6*L 2*L*L ;
                -12 -6*L 12 -6*L ; 6*L 2*L*L -6*L 4*L*L];