% Skrypt testujacy BGS (backwards Gauss-Seidel)
% Ax = b
% A - macierz 

% Konfiguracja
% Wielkosc ukladu rownant
N = 10;
% Elementy z ukladu (odpowiednio R - czesc rzeczywista, I - czesc zespolona)
% Przedzial na elementy pod i nad diagonala
przedzialR = [0 100];
przedzialI = [0 100];
% Przedzial na elementy na diagonali
przedzialDiagR = [150 200];
przedzialDiagI = [150 200];
% Przedzial na wektor b
przedzialBR = [0 100];
przedzialBI = [0 100];
% Przedzial na wektor x0
przedzialX0R = [0 100];
przedzialX0I = [0 100];

% Parametry stopu
epsilon = eps;
delta = eps/2;
maxIteracji = 1000;



% Generowanie wektorow
% Wszystkie powinny byc tej samej dlugosci (N), stad dodajemy odpowiednio
% zera
upp = [randComplex(przedzialR, przedzialI, 1, N-1) 0];
dia = randComplex(przedzialDiagR, przedzialDiagI, N, 1);
low = [0 randComplex(przedzialR, przedzialI, 1, N-1)];
% Zrekonstruowanie macierzy A
A = diag(dia) + diag(upp(1:end-1), 1) + diag(low(2:end), -1);

% Generowanie wektora b
b = randComplex(przedzialBR, przedzialBI, 1, N);
% Generowanie przyblizenia poczatkowego x0
x0 = randComplex(przedzialX0R, przedzialX0I, 1, N);


% Obliczenie prawdziwego rozwiazania niezalezna metoda
xNiezalezne = linsolve(A, b')';

% Rozwiazywanie ukladu
[x, liczbaIteracji] = bgs(low, dia, upp, b, x0, epsilon, delta, maxIteracji);

% Obliczenie bledu
blad = norm(x-xNiezalezne);
rzadBledu = round(log10(blad));

disp(sprintf('Obliczono rozwiazanie w ciagu %d iteracji. Rzad bledu: %d', liczbaIteracji, rzadBledu));