% z = randComplex(rangeReal, rangeImag) - generuje losowa macierz n x m o
% elementach zespolonych, czesci rzeczywiste to liczby calkowite z
% przedzialu rangeReal, a czesci urojone to liczby calkowite z przedzialu
% rangeImag.
%
% Wejscie:
% * rangeReal - zakres na czesci rzeczywiste (wektor 2 elementowy)
% * rangeImag - zakres na czesci urojone (wektor 2 elementowy)
% * n - ilosc wierszy
% * m - ilosc kolumn
%
% Wyjscie:
% z - wygenerowana macierz zespolona

function z = randComplex(rangeReal, rangeImag, n, m)

zReal = randi(rangeReal, n, m);
zImag = randi(rangeImag, n, m);
z = complex(zReal, zImag);

end
