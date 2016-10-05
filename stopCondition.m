% result = STOPCONDITION(xPrevious, xCurrent, epsilon, delta) - funkcja
% określająca czy dla danych przybliżeń xPrevious oraz xCurrent
% (oznaczających odpowiednio poprzednie i aktualne przybliżenie) został
% spełniony warunek stopu (w tym przypadku warunek Gilla).
%
% Warunek Gilla:
% norm(x(i+1) - x(i)) < epsilon * norm(x(i)) + delta
%
% Wejście:
% * xPrevious - wektor zawierający poprzednie przybliżenie
% * xCurrent - wektor zawierający aktualne przyblizenie
% * epsilon, delta - parametry określające dokładność (skalary)

function result = stopCondition(xPrevious, xCurrent, epsilon, delta)
result = norm(xCurrent - xPrevious) < epsilon * norm(xPrevious) + delta;

end
