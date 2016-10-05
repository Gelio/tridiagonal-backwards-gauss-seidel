% x = BGSITERATION(a, b, c, d, x0) - wykonuje jeden krok iteracji
% rozwi¹zuj¹c uk³ad równañ liniowych metod¹ Gaussa-Seidla w ty³.
%
% Funkcja wewnêtrznie wykorzystywana przez funkcjê bgs. Parametry wejœcia
% i wyjœcia analogiczne jak w tamtej funkcji (wpisz "help bgs" po wiêcej
% szczegó³ów).
%
% Autor: Grzegorz Rozdzialik (grupa dziekañska D4, na laboratorium grupa 2)

function x = bgsIteration(a, b, c, d, x0)
x = zeros(size(d));
n = length(d);

% Pierwszy oraz ostatni krok musz¹ byæ zdefiniowane oddzielnie
x(n) = (d(n) - a(n) * x0(n-1)) / b(n);
for i=(n-1):-1:2
    % W ka¿dym kroku wykorzystywane jest k-i przybli¿eñ i-tego stopnia oraz
    % n-i-1 przybli¿eñ (i+1)-szego stopnia
    x(i) = (d(i) - a(i) * x0(i-1) - c(i) * x(i+1)) / b(i);
end
x(1) = (d(1) - c(1) * x(2)) / b(1);


end

