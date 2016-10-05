% x = BGS(a, b, c, d, x0, epsilon, delta) - funkcja rozwi�zuj�ca uk�ad 
% r�wna� liniowych Ax = d z macierz� tr�jdiagonaln� o wst�gach zapisanych 
% w wektorach a, b oraz c. b zawiera elementy z diagonali macierzy A,
% a jest pasmem poni�ej, b jest pasmem powy�ej diagonali.
% Wektor d jest wektorem rozwi�za�.
%
% Funkcja wykorzystuje metod� iteracyjn� Gaussa-Seidla w ty�.
%
% # Warunek stopu
% Jako warunek stopu wykorzystany jest warunek Gilla:
% norm(x(i+1) - x(i)) < epsilon * norm(x(i)) - delta
% Gdzie x(i), x(i+1) to przybli�enia rozwi�zania po odpowiednio i oraz i+1
% krokach iteracji.
%
% # Wej�cie
% * a - wektor o d�ugo�ci n sk�adaj�cy si� z element�w PONI�EJ diagonali
%      (elementy te powinny wystepowa� na indeksach od 2 do n wektora)
% * b - wektor o d�ugo�ci n sk�adaj�cy si� z element�w NA diagonali
% * c - wektor o d�ugo�ci n sk�adaj�cy si� z element�w POWY�EJ diagonali
%      (elementy te powinny wyst�powa� na indekasach od 1 do n-1 wektora)
% * d - wektor o d�ugo�ci n sk�adaj�cy si� z element�w z prawej strony
%       znaku r�wno�ci
% * x0 - wektor o d�ugo�ci n zawieraj�cy przybli�enie pocz�tkowe
% * epsilon, delta - parametry okre�laj�ce dok�adno�� (zobacz sekcj� "Warunek
%                    stopu")
% 
%
% # Wyj�cie
% * x - wektor o d�ugo�ci n zawieraj�cy przybli�one rozwi�zanie uk�adu
% * liczbaIteracji - ilo�� wykonanych iteracji
%
% Autor: Grzegorz Rozdzialik (grupa dzieka�ska D4, na laboratorium grupa 2)

function [x, liczbaIteracji] = bgs(a, b, c, d, x0, epsilon, delta)

xPoprzednie = x0;
xAktualne = bgsIteration(a, b, c, d, xPoprzednie);
liczbaIteracji = 1;

% Dop�ki warunek stopu nie jest spe�niony wykonuj kolejne iteracje
while stopCondition(xPoprzednie, xAktualne, epsilon, delta) == 0
    liczbaIteracji = liczbaIteracji+1;
    xPoprzednie = xAktualne;
    xAktualne = bgsIteration(a, b, c, d, xPoprzednie);
end

% Przepisz wynik na wyj�cie
x = xAktualne;

end
