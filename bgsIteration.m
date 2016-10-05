% x = BGSITERATION(a, b, c, d, x0) - wykonuje jeden krok iteracji
% rozwi�zuj�c uk�ad r�wna� liniowych metod� Gaussa-Seidla w ty�.
%
% Funkcja wewn�trznie wykorzystywana przez funkcj� bgs. Parametry wej�cia
% i wyj�cia analogiczne jak w tamtej funkcji (wpisz "help bgs" po wi�cej
% szczeg��w).
%
% Autor: Grzegorz Rozdzialik (grupa dzieka�ska D4, na laboratorium grupa 2)

function x = bgsIteration(a, b, c, d, x0)
x = zeros(size(d));
n = length(d);

% Pierwszy oraz ostatni krok musz� by� zdefiniowane oddzielnie
x(n) = (d(n) - a(n) * x0(n-1)) / b(n);
for i=(n-1):-1:2
    % W ka�dym kroku wykorzystywane jest k-i przybli�e� i-tego stopnia oraz
    % n-i-1 przybli�e� (i+1)-szego stopnia
    x(i) = (d(i) - a(i) * x0(i-1) - c(i) * x(i+1)) / b(i);
end
x(1) = (d(1) - c(1) * x(2)) / b(1);


end

