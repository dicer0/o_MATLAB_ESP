%ENSAMBLE DE LA MATRIZ DE RIGIDEZ CON LA MATRIZ GLOBAL K EN VIGA 2D
%Esta función ensambla la matriz de rigidez del elemento k del elemento de 
%una viga 2D con los nodos i y j en la matriz de rigidez global K. Esta 
%función devuelve la matriz de rigidez global K después de ensamblar la 
%matriz de rigidez del elemento k, creando así las barras de cada parte
%de la viga que tenga distinto diámetro, módulo de elasticidas y/o momento
%de inercia.
function y = b_EnsambleMatricesRigidez_y_MatrizGlobal_K_Vigas(K,k,i,j)
K(2*i-1,2*i-1) = K(2*i-1,2*i-1) + k(1,1);
K(2*i-1,2*i) = K(2*i-1,2*i) + k(1,2);
K(2*i-1,2*j-1) = K(2*i-1,2*j-1) + k(1,3);
K(2*i-1,2*j) = K(2*i-1,2*j) + k(1,4);
K(2*i,2*i-1) = K(2*i,2*i-1) + k(2,1);
K(2*i,2*i) = K(2*i,2*i) + k(2,2);
K(2*i,2*j-1) = K(2*i,2*j-1) + k(2,3);
K(2*i,2*j) = K(2*i,2*j) + k(2,4);
K(2*j-1,2*i-1) = K(2*j-1,2*i-1) + k(3,1);
K(2*j-1,2*i) = K(2*j-1,2*i) + k(3,2);
K(2*j-1,2*j-1) = K(2*j-1,2*j-1) + k(3,3);
K(2*j-1,2*j) = K(2*j-1,2*j) + k(3,4);
K(2*j,2*i-1) = K(2*j,2*i-1) + k(4,1);
K(2*j,2*i) = K(2*j,2*i) + k(4,2);
K(2*j,2*j-1) = K(2*j,2*j-1) + k(4,3);
K(2*j,2*j) = K(2*j,2*j) + k(4,4);
y = K;