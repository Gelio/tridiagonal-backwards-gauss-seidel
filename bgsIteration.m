% x = BGSITERATION(low, dia, upp, b, x0) - wykonuje jeden krok iteracji
% rozwiazujac uklad rownan liniowych metoda Gaussa-Seidla w tyl.
% Funkcja dziala dla macierzy trojdiagonalnych.
%
% Funkcja wewnetrznie wykorzystywana przez funkcje bgs. Parametry wejscia
% i wyjscia analogiczne jak w tamtej funkcji (wpisz "help bgs" po wiecej
% szczegolow).
%
%
% Autor: Grzegorz Rozdzialik (grupa dziekanska D4, na laboratorium grupa 2)

function x = bgsIteration(low, dia, upp, b, x0)
n = length(b);

% Przygotowanie wektorow pomocniczych
lowR = real(low);
lowI = imag(low);
diaR = real(dia);
diaI = imag(dia);
uppR = real(upp);
uppI = imag(upp);

bR = real(b);
bI = imag(b);
xR = real(x0);
xI = imag(x0);


% Obliczanie pierwszego i ostatniego elementu rozwiazania jest poza petla
% z uwagi na potrzebe oddzielnej implementacji. Sa one powieleniem ciala
% petli z wyrzuceniem odpowiednich wektorow.

% Do obliczenia ostatniego elementu nie mozna uzyc wektora upp
xR(n) = (bR(n) - lowR(n)*xR(n-1) + lowI(n)*xI(n-1) + diaI(n)*xI(n)) / diaR(n);
xI(n) = (bI(n) - lowR(n)*xI(n-1) - lowI(n)*xR(n-1) - diaI(n)*xR(n)) / diaR(n);
for i=(n-1):-1:2
    xR(i) = (bR(i) - lowR(i)*xR(i-1) + lowI(i)*xI(i-1) + diaI(i)*xI(i) - uppR(i)*xR(i+1) + uppI(i)*xI(i+1)) / diaR(i);
    xI(i) = (bI(i) - lowR(i)*xI(n-1) - lowI(i)*xR(i-1) - diaI(i)*xR(i) - uppI(i)*xR(i+1) - uppR(i)*xI(i+1)) / diaR(i);
end
% Do obliczenia pierwszego elementu nie mozna uzyc wektora low
xR(1) = (bR(1) + diaI(1)*xI(1) - uppR(1)*xR(2) + uppI(1)*xI(2)) / diaR(1);
xI(1) = (bI(1) - diaI(1)*xR(1) - uppR(1)*xI(2) - uppI(1)*xR(2)) / diaR(1);

% Przygotowanie wektora wynikowego
x = complex(xR, xI);

end
