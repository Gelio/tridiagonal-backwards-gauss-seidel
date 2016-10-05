% result = STOPCONDITION(xPrevious, xCurrent, epsilon, delta) - funkcja
% okre�laj�ca czy dla danych przybli�e� xPrevious oraz xCurrent
% (oznaczaj�cych odpowiednio poprzednie i aktualne przybli�enie) zosta�
% spe�niony warunek stopu (w tym przypadku warunek Gilla).
%
% Warunek Gilla:
% norm(x(i+1) - x(i)) < epsilon * norm(x(i)) + delta
%
% Wej�cie:
% * xPrevious - wektor zawieraj�cy poprzednie przybli�enie
% * xCurrent - wektor zawieraj�cy aktualne przyblizenie
% * epsilon, delta - parametry okre�laj�ce dok�adno�� (skalary)

function result = stopCondition(xPrevious, xCurrent, epsilon, delta)
result = norm(xCurrent - xPrevious) < epsilon * norm(xPrevious) + delta;

end
