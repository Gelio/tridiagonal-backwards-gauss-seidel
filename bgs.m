% x = BGS(low, dia, upp, b, x0, epsilon, delta) - funkcja rozwiazujaca uklad
% rownan liniowych Ax = b z macierza trojdiagonalna o wstegach zapisanych 
% w wektorach low, dia oraz upp. dia zawiera elementy z diagonali macierzy A,
% wektor low jest pasmem ponizej, upp jest pasmem powyzej diagonali.
% Wektor b jest wektorem z prawej strony rownosci.
%
% Funkcja wykorzystuje metode iteracyjna Gaussa-Seidla w tyl.
%
% # Warunek stopu
% Jako warunek stopu wykorzystany jest warunek Gilla:
% norm(x(i+1) - x(i)) < epsilon * norm(x(i)) - delta
% Gdzie x(i), x(i+1) to przyblizenia rozwiazania po odpowiednio i oraz i+1
% krokach iteracji.
%
% # Wejscie
% * low - wektor o dlugosci n skladajacy sie z elementow PONIZEJ diagonali
%      (elementy te powinny wystepowac na indeksach od 2 do n wektora)
% * dia - wektor o dlugosci n skladajacy sie z elementow NA diagonali
% * upp - wektor o dlugosci n skladajacy sie z elementow POWYZEJ diagonali
%      (elementy te powinny wystepowac na indekasach od 1 do n-1 wektora)
% * b - wektor o dlugosci n skladajacy sie z elementow z prawej strony
%       znaku rownosci
% * x0 - wektor o dlugosci n zawierajacy przyblizenie poczatkowe
% * epsilon, delta - parametry okreslajace dokladnosc (zobacz sekcje
%                    "Warunek stopu")
% Wektory moga posiadac elementy zespolone.
% 
%
% # Wyjscie
% * x - wektor o dlugosci n zawierajacy przyblizone rozwiazanie ukladu.
%       Moze posiadac elementy zespolone
% * liczbaIteracji - ilosc wykonanych iteracji
%
% Autor: Grzegorz Rozdzialik (grupa dziekanska D4, na laboratorium grupa 2)

function [x, liczbaIteracji] = bgs(low, dia, upp, b, x0, epsilon, delta)

xPoprzednie = x0;
xAktualne = bgsIteration(low, dia, upp, b, xPoprzednie);
liczbaIteracji = 1;

% Dopoki warunek stopu nie jest spelniony wykonuj kolejne iteracje
while stopCondition(xPoprzednie, xAktualne, epsilon, delta) == 0
    liczbaIteracji = liczbaIteracji+1;
    xPoprzednie = xAktualne;
    xAktualne = bgsIteration(low, dia, upp, b, xPoprzednie);
end

% Przepisz wynik na wyjscie
x = xAktualne;

end
