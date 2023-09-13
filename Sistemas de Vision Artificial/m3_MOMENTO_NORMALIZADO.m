%Momento Nornalizado: Se le pasa como primer argumento varios resultados 
%upq del Momento Central, el valor u00 que es el resultado del momento 
%central elevado a las potencias u = 0 y q = 0 y los factores "p" y "q" que 
%indicaron las potencias de las variables xy en el Momento Inicial y 
%Central, en este caso existirá una condición importante, en donde se
%evalúa si la suma de p+q es mayor a 1 y si lo es, se le da un valor u otro
%a una nueva variable d (delta) utilizada en la fórmula del Momento
%Normalizado.
function npq = m3_MOMENTO_NORMALIZADO(upq, u00, p, q)
    %Momento Normalizado = ηpq = μpq/μ00^δ, donde: 
    %δ = ((p+q)/2)+1, si p+q > 1, osea 2,3,..
    if (p+q >= 2)
        d = ((p+q)/2)+1;
    %δ = 1, si p+q <= 1, osea 0 o 1.
    else
        d = 1;
    end
    
    %Momento Normalizado = ηpq = μpq/(μ00^δ)
    npq = upq./(u00.^d);
end