% x = BGSITERATION(a, b, c, d, x0) - wykonuje jeden krok iteracji
% rozwiazujac uklad rownan liniowych metoda Gaussa-Seidla w tyl.
%
% Funkcja wewnetrznie wykorzystywana przez funkcje bgs. Parametry wejscia
% i wyjscia analogiczne jak w tamtej funkcji (wpisz "help bgs" po wiecej
% szczegolow).
%
% Autor: Grzegorz Rozdzialik (grupa dziekanska D4, na laboratorium grupa 2)

function x = bgsIteration(a, b, c, d, x0)
x = zeros(size(d));
n = length(d);

% Pierwszy oraz ostatni krok musza byc zdefiniowane oddzielnie
x(n) = (d(n) - a(n) * x0(n-1)) / b(n);
for i=(n-1):-1:2
    % W kazdym kroku wykorzystywane jest k-i przyblizen i-tego stopnia oraz
    % n-i-1 przyblizen (i+1)-szego stopnia
    x(i) = (d(i) - a(i) * x0(i-1) - c(i) * x(i+1)) / b(i);
end
x(1) = (d(1) - c(1) * x(2)) / b(1);


end

