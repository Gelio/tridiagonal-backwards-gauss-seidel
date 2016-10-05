% result = STOPCONDITION(xPrevious, xCurrent, epsilon, delta) - funkcja
% okreœlaj¹ca czy dla danych przybli¿eñ xPrevious oraz xCurrent
% (oznaczaj¹cych odpowiednio poprzednie i aktualne przybli¿enie) zosta³
% spe³niony warunek stopu (w tym przypadku warunek Gilla).
%
% Warunek Gilla:
% norm(x(i+1) - x(i)) < epsilon * norm(x(i)) + delta
%
% Wejœcie:
% * xPrevious - wektor zawieraj¹cy poprzednie przybli¿enie
% * xCurrent - wektor zawieraj¹cy aktualne przyblizenie
% * epsilon, delta - parametry okreœlaj¹ce dok³adnoœæ (skalary)

function result = stopCondition(xPrevious, xCurrent, epsilon, delta)
result = norm(xCurrent - xPrevious) < epsilon * norm(xPrevious) + delta;

end
