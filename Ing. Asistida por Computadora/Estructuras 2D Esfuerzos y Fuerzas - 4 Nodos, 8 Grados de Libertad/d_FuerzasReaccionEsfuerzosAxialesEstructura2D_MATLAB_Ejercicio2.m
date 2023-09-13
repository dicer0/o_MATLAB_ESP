%ANÁLISIS DE ELEMENTO FINITO: NODOS DE UNA ESTRUCTURA 2D
%Fuerzas de Reacción y Esfuerzos Axiales en Estructuras 2D con MATLAB Ej 2:
%Estructuras 2D Esfuerzos y Fuerzas - 4 Nodos, 8 Grados de Libertad
E=210e9;    %Módulo de elasticidad
A=0.005;    %Área de sección transversal en todos los elementos
L1=8.6023;  %Longitud barra 1 = 8.6023 m
L2=7;       %Longitud barra 2 = 7 m
L3=5;       %Longitud barra 3 = 5 m
L4=L3;      %Longitud barra 4 = Longitud barra 3 = 5 m
L5=L1;      %Longitud barra 5 = Longitud barra 1 = 8.6023 m
L6=L3;      %Longitud barra 6 = Longitud barra 3 = 5 m
L7=L1;      %Longitud barra 7 = Longitud barra 1 = 8.6023 m
L8=L2;      %Longitud barra 8 = Longitud barra 2 = 7 m
L9=L3;      %Longitud barra 9 = Longitud barra 3 = 5 m

tetha1=54.4623;     %Ángulo de inclinación 1 = 54.4623°
tetha2=90;          %Ángulo de inclinación 2 = 90°          
tetha3=0;           %Ángulo de inclinación 3 = 0°
tetha4=tetha3;      %Ángulo de inclinación 4 = Ángulo de inclinación 3 = 0°
tetha5=125.5370;    %Ángulo de inclinación 5 = 125.5370°
tetha6=tetha3;      %Ángulo de inclinación 6 = Ángulo de inclinación 3 = 0°
tetha7=tetha5;      %Ángulo de inclinación 7 = Ángulo de inclinación 5 = 125.5370°
tetha8=tetha2;      %Ángulo de inclinación 8 = Ángulo de inclinación 2 = 90°
tetha9=tetha3;      %Ángulo de inclinación 9 = Ángulo de inclinación 3 = 0°

%CREAR LAS MATRICES DE RIGIDEZ: Esto implica dar el área de sección
%transversal A, coeficiente de elasticidad E, longitud L y ángulo de
%inclinación theta a cada una de las barras para después poderlas crear al
%calcular las matrices globales K.
k1=a_MatrizRigidezEstructura2D(E,A,L1,tetha1);
k2=a_MatrizRigidezEstructura2D(E,A,L2,tetha2);
k3=a_MatrizRigidezEstructura2D(E,A,L3,tetha3);
k4=a_MatrizRigidezEstructura2D(E,A,L4,tetha4);
k5=a_MatrizRigidezEstructura2D(E,A,L5,tetha5);
k6=a_MatrizRigidezEstructura2D(E,A,L6,tetha6);
k7=a_MatrizRigidezEstructura2D(E,A,L7,tetha7);
k8=a_MatrizRigidezEstructura2D(E,A,L8,tetha8);
k9=a_MatrizRigidezEstructura2D(E,A,L9,tetha9);
%Crea una Matriz de 12x12 esto porque tengo 6 elementos y 2 grados de 
%libertad en cada uno ya que es una estructura 2D y en cada una puede haber 
%componente xy, 6*2=12
K=zeros(12,12);

%CREAR LAS MATRICES GLOBALES DE MIS ELEMENTOS: Esto implica indicar los
%nodos de dónde a donde va cada una de las barras de la estructura 2D
K=b_EnsambleMatricesRigidez_y_MatrizGlobal_K(K,k1,1,2);	%Elemento 1: Va del nodo 1 al 2
K=b_EnsambleMatricesRigidez_y_MatrizGlobal_K(K,k2,3,2); %Elemento 2: Va del nodo 3 al 2
K=b_EnsambleMatricesRigidez_y_MatrizGlobal_K(K,k3,1,3); %Elemento 3: Va del nodo 1 al 3
K=b_EnsambleMatricesRigidez_y_MatrizGlobal_K(K,k4,2,4); %Elemento 4: Va del nodo 2 al 4
K=b_EnsambleMatricesRigidez_y_MatrizGlobal_K(K,k5,5,2); %Elemento 5: Va del nodo 5 al 2
K=b_EnsambleMatricesRigidez_y_MatrizGlobal_K(K,k6,3,5); %Elemento 6: Va del nodo 3 al 5
K=b_EnsambleMatricesRigidez_y_MatrizGlobal_K(K,k7,6,4); %Elemento 7: Va del nodo 6 al 4
K=b_EnsambleMatricesRigidez_y_MatrizGlobal_K(K,k8,5,4); %Elemento 8: Va del nodo 5 al 4
K=b_EnsambleMatricesRigidez_y_MatrizGlobal_K(K,k9,5,6); %Elemento 9: Va del nodo 5 al 6
%Esto se hace para llenar la matriz global con todos los elementos que
%conforman mi estructura, creando una gigante matriz Global que incluya
%todas las barras de mi estructura.

%Q1=Q2=0 Q11=Q12=0
%Se hace un subsistema con los grados de libertad que no sean cero, esto 
%se toma en cuenta considerando los nodos donde se encuentren los apoyos 
%de la estructura 2D, para ello tomamos las filas y columnas que no hayamos 
%eliminado, osea donde no existan apoyos, en MATLAB así se extraen:
%Con K(3:10, ...) sacamos de la fila 3 a la 10 de la matriz K
%Con K(..., 1:2) sacamos de las columnas 3 a la 10 de la matriz K
k=[K(3:10, 3:10)];

%Vector f de fuerzas externas xy en cada uno de los 8 nodos: 
%4 nodos libres con 2 grados de libertad cada uno donde se pueden aplicar
%fuerzas xy, teniendo 8 componentes en total.
f=[20e3;0;0;0;0;0;0;0];

%Con esto se calculan los desplazamientos pero en sus coordenadas xy
q=k\f;
%Desplazamientos en los nodos 2,3,4 y 5; recordando que cada uno tiene 2
%grados de libertad, osea dos coordenadas hacia donde se pueden mover.
desplazamientosNodo2=[q(1);q(2)];
desplazamientosNodo3=[q(3);q(4)];
desplazamientosNodo4=[q(5);q(6)];
desplazamientosNodo5=[q(7);q(8)];

%Este es el vector Q que tiene las que valían cero para poder calcular las reacciones
Q=[0;0;q(1);q(2);q(3);q(4);q(5);q(6);q(7);q(8);0;0]

%Con esto se calculan las reacciones en los apoyos
F=K*Q

%Reacciones nodo 1
R1=[F(1);F(2)];
%Reacciones nodo 6
R2=[F(11);F(12)];

%Así calculo los esfuerzos en todos los elementos
Esfuerzo=F./A;

%El elemento 1 tiene 2 nodos, cada uno con 2 grados de libertad
Q1=[Q(1);Q(2);Q(3);Q(4)];
%Esfuerzo barra 1
%Lo dividimos entre 1e6 para que se vea como MPa el resultado
Esfuerzo1=c_VectorEsfuerzoAxialEstructura2D(E,L1,tetha1,Q1)/1e6
%Esfuerzo barra 2
Q2=[Q(5);Q(6);Q(3);Q(4)];       %Grados de libertad del elemento 2
Esfuerzo2=c_VectorEsfuerzoAxialEstructura2D(E,L2,tetha2,Q2)/1e6
%Esfuerzo barra 3
Q3=[Q(1);Q(2);Q(5);Q(6)];       %Grados de libertad del elemento 3
Esfuerzo3=c_VectorEsfuerzoAxialEstructura2D(E,L3,tetha3,Q3)/1e6
%Esfuerzo barra 4
Q4=[Q(3);Q(4);Q(7);Q(8)];       %Grados de libertad del elemento 4
Esfuerzo4=c_VectorEsfuerzoAxialEstructura2D(E,L4,tetha4,Q4)/1e6
%Esfuerzo barra 5
Q5=[Q(9);Q(10);Q(3);Q(4)];      %Grados de libertad del elemento 5
Esfuerzo5=c_VectorEsfuerzoAxialEstructura2D(E,L5,tetha5,Q5)/1e6
%Esfuerzo barra 6
Q6=[Q(5);Q(6);Q(9);Q(10)];      %Grados de libertad del elemento 6
Esfuerzo6=c_VectorEsfuerzoAxialEstructura2D(E,L6,tetha6,Q6)/1e6
%Esfuerzo barra 7
Q7=[Q(11);Q(12);Q(7);Q(8)];     %Grados de libertad del elemento 7
Esfuerzo7=c_VectorEsfuerzoAxialEstructura2D(E,L7,tetha7,Q7)/1e6
%Esfuerzo barra 8
Q8=[Q(9);Q(10);Q(7);Q(8)];      %Grados de libertad del elemento 8
Esfuerzo8=c_VectorEsfuerzoAxialEstructura2D(E,L8,tetha8,Q8)/1e6
%Esfuerzo barra 9
Q9=[Q(9);Q(10);Q(11);Q(12)];    %Grados de libertad del elemento 9
Esfuerzo9=c_VectorEsfuerzoAxialEstructura2D(E,L9,tetha9,Q9)/1e2