% Skrypt testujacy BGS (backwards Gauss-Seidel)
% Ax = b
% A - macierz trojdiagonalna rozmiaru (n x n) o elementach zespolonych
% b - wektor rozmiaru n o elementach zespolonych

% Konfiguracja
% Wielkosc ukladu rownan
N = 5;
% Elementy z ukladu (odpowiednio R - czesc rzeczywista, I - czesc zespolona)
% Przedzial na elementy pod i nad diagonala
przedzialR = [0 100];
przedzialI = [0 100];
% Przedzial na elementy na diagonali
przedzialDiagR = [200 400];
przedzialDiagI = [0 0];
% Przedzial na wektor b
przedzialBR = [0 100];
przedzialBI = [0 100];
% Przedzial na wektor x0
przedzialX0R = [0 100];
przedzialX0I = [0 100];

% Parametry stopu
epsilon = eps;
delta = 0;
maxIteracji = 10000;



% Generowanie wektorow
% Wszystkie powinny byc tej samej dlugosci (N), stad dodajemy odpowiednio
% zera
upp = [randComplex(przedzialR, przedzialI, 1, N-1) 0];
dia = randComplex(przedzialDiagR, przedzialDiagI, 1, N);
low = [0 randComplex(przedzialR, przedzialI, 1, N-1)];
% Zrekonstruowanie macierzy A
A = diag(dia) + diag(upp(1:end-1), 1) + diag(low(2:end), -1);

% Generowanie wektora b
b = randComplex(przedzialBR, przedzialBI, 1, N);
% Generowanie przyblizenia poczatkowego x0
x0 = randComplex(przedzialX0R, przedzialX0I, 1, N);

% Rozwiazywanie ukladu
tic;
[x, liczbaIteracji] = bgs(low, dia, upp, b, x0, epsilon, delta, maxIteracji);
czasDzialania = toc;

if all(isnan(x))
    fprintf('Nie mozna obliczyc rozwiazania. Osiagnieto maksymalna liczbe iteracji, a wynik nie jest liczba.\n');
else
    % Obliczenie bledu
    bladBGS = norm(A*reshape(x, N, 1) - reshape(b, N, 1));
    rzadBleduBGS = round(log10(bladBGS));

    fprintf('Obliczono rozwiazanie w ciagu %d iteracji.\n', liczbaIteracji);
    fprintf('Rzad bledu BGS: %d\n', rzadBleduBGS);
end
fprintf('Czas dzialania BGS: %f ms\n', czasDzialania*1000);


% Obliczenie rozwiazania niezalezna metoda linsolve
fprintf('\nPorownanie z funkcja linsolve\n');
tic;
xLinsolve = linsolve(A, reshape(b, N, 1));
czasLinsolve = toc;

if all(isnan(xLinsolve))
    fprintf('Linsolve tez nie dalo dobrych rozwiazan.\n');
else
    % Obliczenie bledu
    bladLinsolve = norm(A*xLinsolve - b);
    rzadBleduLinsolve = round(log10(bladLinsolve));
    fprintf('Rzad bledu linsolve: %d\n', rzadBleduLinsolve);
end
fprintf('Czas dzialania linsolve: %f ms\n', czasLinsolve*1000);
