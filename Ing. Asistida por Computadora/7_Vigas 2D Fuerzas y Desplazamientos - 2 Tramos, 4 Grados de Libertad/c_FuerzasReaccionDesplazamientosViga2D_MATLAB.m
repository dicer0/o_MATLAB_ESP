%AN�LISIS DE ELEMENTO FINITO: NODOS DE UNA VIGA 2D
%Fuerzas de Reacci�n y Esfuerzos Axiales en Vigas 2D con MATLAB Ej 1:
%Vigas 2D Esfuerzos y Fuerzas de Reacci�n - 2 Tramos, 4 Grados de Libertad
%TRAMO 1:
E1=210e9;%m�dulo de elasticidad del 1er tramo de la viga
L1=2;%longitud del 1er tramo de la viga
d1=0.05;%di�metro del 1er tramo de la viga
I1=(pi/64)*d1^4;%momento de inercia del 1er tramo de la viga
%TRAMO 2:
E2=180e9;%m�dulo de elasticidad del 2do tramo de la viga
L2=1;%longitud del 2do tramo de la viga
d2=0.04;%di�metro del 2do tramo de la viga
I2=(pi/64)*d2^4;%momento de inercia del 2do tramo de la viga

%CREAR LAS MATRICES DE RIGIDEZ: Esto implica indicar el coeficiente de 
%elasticidad E, momento de inercia I y longitud L de cada uno de los tramos 
%de la viga para despu�s poder crear cada tramo al calcular las matrices 
%globales K.
k1=a_MatrizRigidezViga2D(E1,I1,L1);%Matriz de rigidez del 1er tramo de la viga
k2=a_MatrizRigidezViga2D(E2,I2,L2);%Matriz de rigidez del 2do tramo de la viga
%Crea una Matriz vac�a de 6x6 porque tengo 2 elementos y 3 grados de 
%libertad en cada uno ya que es una viga 2D y en cada uno puedo tener 3 
%grados de libertad, ya sea componentes xy o un momento z, 3*2=6
K=zeros(6,6);
%zeros reserva una matriz vac�a de 6x6 para que meta mi matriz global aqu�

%CREAR LAS MATRICES GLOBALES DE MIS TRAMOS: Esto implica indicar los
%nodos de d�nde a donde va cada una de los tramos de la viga 2D
K=b_EnsambleMatricesRigidez_y_MatrizGlobal_K_Vigas(K,k1,1,2); %Tramo 1: Va del nodo 1 al 2
K=b_EnsambleMatricesRigidez_y_MatrizGlobal_K_Vigas(K,k2,2,3); %Tramo 2: Va del nodo 2 al 3
%Esto se hace para llenar la matriz global con todos los elementos que
%conforman mi viga, creando una gigante matriz Global que incluya todos los 
%tramos de mi viga.

%Q1=Q2=0
%Se hace un subsistema con los grados de libertad que no sean cero, esto 
%se toma en cuenta considerando los nodos donde se encuentren los apoyos 
%de la viga 2D, para ello tomamos las filas y columnas que no hayamos 
%eliminado, osea donde no existan apoyos, en MATLAB as� se extraen:
%Con K(3:10, ...) sacamos de la fila 3 a la 10 de la matriz K
%Con K(..., 1:2) sacamos de las columnas 3 a la 10 de la matriz K
k=K(3:6,3:6);
%Con esto creo un subsistema diciendole al programa que extraiga de la fila 
%3 a la 6 y de la columna 3 a la 6.

%Vector f de fuerzas externas xy en cada uno de los 2 nodos: 
%2 nodos libres con 2 grados de libertad cada uno donde se pueden aplicar
%fuerzas xy, teniendo 4 componentes en total.
f=[-500;0;0;-250];

%Con esto encuentro los desplazamientos e inclinaciones Q3, Q4, Q5 y Q6 de 
%arriba hacia abajo, en las vigas lo que se encuentra es el desplazamiento
%vertical y el �ngulo de inclinaci�n de cada nodo.
q=k\f;

%Para encontrar las reacciones debo usar las filas que elimin� cuando el
%desplazamiento Q era cero y todas las columnas de la matriz global.
%Con esto le digo al programa que extraiga de la matriz global de la fila 
%1 a la 2 y de la columna 1 a la 6
kk=K(1:2,1:6);

%Tambi�n creo un vector que tenga todos los grados de libertad de la viga, 
%incluidos los que val�an cero, obteniendo as� los desplazamientos en los
%nodos, obteniendo primero su desplazamiento vertical y luego su �ngulo de
%inclinaci�n.
Q=[0;0;q(1);q(2);q(3);q(4)]

%Con esta operaci�n ya obtengo el valor de las reacciones en los soportes 
%donde Q=0, obteniendo primero su reacci�n vertical y luego su momento de
%reacci�n (torque) con todo y su signo de direcci�n.
F=kk*Q