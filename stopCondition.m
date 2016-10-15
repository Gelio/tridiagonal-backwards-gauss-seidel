% result = STOPCONDITION(xPrevious, xCurrent, epsilon, delta) - funkcja
% okreslajaca czy dla danych przyblizen xPrevious oraz xCurrent
% (oznaczajacych odpowiednio poprzednie i aktualne przyblizenie) zostal
% spelniony warunek stopu (w tym przypadku warunek Gilla).
%
% Warunek Gilla:
% norm(x(i+1) - x(i)) < epsilon * norm(x(i)) + delta
%
% Wejscie:
% * xPrevious - wektor zawierajacy poprzednie przyblizenie
% * xCurrent - wektor zawierajacy aktualne przyblizenie
% * epsilon, delta - parametry okreslajace dokladnosc (skalary)
% * iterationCount - aktualna liczba iteracji
% * maxIteration - maksymalna liczba iteracji. Po jej osiagnieciu uznawane
%                  jest, ze warunek stopu zostal spelniony bez wzgledu na
%                  zawartosc wektorow.
%
% Autor: Grzegorz Rozdzialik (grupa dziekanska D4, na laboratorium grupa 2)

function result = stopCondition(xPrevious, xCurrent, epsilon, delta, iterationCount, maxIteration)

if iterationCount >= maxIteration
    % Osiagnieto maksymalna ilosc iteracji
    result = 1;
    return
end

result = norm(xCurrent - xPrevious) < epsilon * norm(xPrevious) + delta;


end
