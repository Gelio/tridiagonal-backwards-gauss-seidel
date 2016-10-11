% Skrypt testujacy BGS (backwards Gauss-Seidel)
% Ax = b
% A - macierz 

% Konfiguracja
% Wielkosc ukladu rownant
N = 10;
% Parametry stopu
epsilon = eps;
delta = eps/2;
maxIteracji = 1000;



% Generowanie macierzy pomocniczej z ktorej wyluskane zostana elementy z
% diagonali
pomocniczaMacierz = complex(rand(N), rand(N));
% Pobranie elementow z diagonali do wektorow
% Wszystkie powinny byc tej samej dlugosci (N), stad dodajemy odpowiednio
% zera
upp = [diag(pomocniczaMacierz, 1); 0];
dia = diag(pomocniczaMacierz) + 0.5;
low = [0; diag(pomocniczaMacierz, -1)];
% Zrekonstruowanie macierzy A
A = diag(dia) + diag(upp(1:end-1), 1) + diag(low(2:end), -1);

% Generowanie wektora b
b = complex(rand(1, N), rand(1, N));
% Generowanie przyblizenia poczatkowego x0
x0 = complex(rand(1, N), rand(1, N));


% Obliczenie prawdziwego rozwiazania niezalezna metoda
xNiezalezne = linsolve(A, b')';

% Rozwiazywanie ukladu
[x, liczbaIteracji] = bgs(low, dia, upp, b, x0, epsilon, delta, maxIteracji);

% Obliczenie bledu
blad = norm(x-xNiezalezne);
rzadBledu = log(blad);