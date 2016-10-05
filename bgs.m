% x = BGS(a, b, c, d, x0, epsilon, delta) - funkcja rozwi¹zuj¹ca uk³ad 
% równañ liniowych Ax = d z macierz¹ trójdiagonaln¹ o wstêgach zapisanych 
% w wektorach a, b oraz c. b zawiera elementy z diagonali macierzy A,
% a jest pasmem poni¿ej, b jest pasmem powy¿ej diagonali.
% Wektor d jest wektorem rozwi¹zañ.
%
% Funkcja wykorzystuje metodê iteracyjn¹ Gaussa-Seidla w ty³.
%
% # Warunek stopu
% Jako warunek stopu wykorzystany jest warunek Gilla:
% norm(x(i+1) - x(i)) < epsilon * norm(x(i)) - delta
% Gdzie x(i), x(i+1) to przybli¿enia rozwi¹zania po odpowiednio i oraz i+1
% krokach iteracji.
%
% # Wejœcie
% * a - wektor o d³ugoœci n sk³adaj¹cy siê z elementów PONI¯EJ diagonali
%      (elementy te powinny wystepowaæ na indeksach od 2 do n wektora)
% * b - wektor o d³ugoœci n sk³adaj¹cy siê z elementów NA diagonali
% * c - wektor o d³ugoœci n sk³adaj¹cy siê z elementów POWY¯EJ diagonali
%      (elementy te powinny wystêpowaæ na indekasach od 1 do n-1 wektora)
% * d - wektor o d³ugoœci n sk³adaj¹cy siê z elementów z prawej strony
%       znaku równoœci
% * x0 - wektor o d³ugoœci n zawieraj¹cy przybli¿enie pocz¹tkowe
% * epsilon, delta - parametry okreœlaj¹ce dok³adnoœæ (zobacz sekcjê "Warunek
%                    stopu")
% 
%
% # Wyjœcie
% * x - wektor o d³ugoœci n zawieraj¹cy przybli¿one rozwi¹zanie uk³adu
% * liczbaIteracji - iloœæ wykonanych iteracji
%
% Autor: Grzegorz Rozdzialik (grupa dziekañska D4, na laboratorium grupa 2)

function [x, liczbaIteracji] = bgs(a, b, c, d, x0, epsilon, delta)

xPoprzednie = x0;
xAktualne = bgsIteration(a, b, c, d, xPoprzednie);
liczbaIteracji = 1;

% Dopóki warunek stopu nie jest spe³niony wykonuj kolejne iteracje
while stopCondition(xPoprzednie, xAktualne, epsilon, delta) == 0
    liczbaIteracji = liczbaIteracji+1;
    xPoprzednie = xAktualne;
    xAktualne = bgsIteration(a, b, c, d, xPoprzednie);
end

% Przepisz wynik na wyjœcie
x = xAktualne;

end
