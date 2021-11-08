% 1. Korzystając z własności wartości oczekiwanej i wariancji wygenerować zadane rozkłady
% (wykorzystując odpowiednie funkcje standardowe)

% Korzystając z funkcji Matlaba - rand (do generacji rozkładu
% jednostajnego) oraz - randn (do generacji rozkładu normalnego)
% wygenerować następujące rozkłady:
% 1) jednostajny o wartości oczekiwanej równej 5 i odchyleniu standardowym
% równym 2
% 2) normalny o wartości oczekiwanej równej 3 i odchyleniu standardowym,
% równym 4
% Przyjąć N=[10:10:1000].

% 2. Dla tak wygenerowanych rozkładów wyznaczyć estymatory wartości oczekiwanej i
% odchylenia standardowego (wykorzystując oba wzory) w funkcji liczby próbek. Symulacje
% powtórzyć 100 razy dla każdego N. Dla taka wygenerowanych wyników dla każdego N
% wyznaczyć błąd estymacji oraz wariancję estymacji.



% Dane
N = (10:10:1000);
REPET = 100;
EXu = 5;
SIGu = 2;
EXn = 3;
SIGn = 4;


l = length(N);
% Rozkład jednostajny - pojemnik na wszystkie wyniki
EXu_estim = zeros(l, REPET);
SIGu_estim1 = zeros(l, REPET);
SIGu_estim2 = zeros(l, REPET);

% Rozkład normalny - pojemnik na wszystkie wyniki
EXn_estim = zeros(l, REPET);
SIGn_estim1 = zeros(l, REPET);
SIGn_estim2 = zeros(l, REPET);

% Wyniki dla każdego N - pojemniki
EXu_estim_avg = zeros(l, 1);
SIGu_estim1_avg = zeros(l, 1);
SIGu_estim2_avg = zeros(l, 1);

EXn_estim_avg = zeros(l, 1);
SIGn_estim1_avg = zeros(l, 1);
SIGn_estim2_avg = zeros(l, 1);

EXu_estim_err = zeros(l, 1);
SIGu_estim1_err = zeros(l, 1);
SIGu_estim2_err = zeros(l, 1);

EXn_estim_err = zeros(l, 1);
SIGn_estim1_err = zeros(l, 1);
SIGn_estim2_err = zeros(l, 1);

EXu_estim_var1 = zeros(l, 1);
SIGu_estim1_var1 = zeros(l, 1);
SIGu_estim2_var1 = zeros(l, 1);

EXn_estim_var1 = zeros(l, 1);
SIGn_estim1_var1 = zeros(l, 1);
SIGn_estim2_var1 = zeros(l, 1);

EXu_estim_var2 = zeros(l, 1);
SIGu_estim1_var2 = zeros(l, 1);
SIGu_estim2_var2 = zeros(l, 1);

EXn_estim_var2 = zeros(l, 1);
SIGn_estim1_var2 = zeros(l, 1);
SIGn_estim2_var2 = zeros(l, 1);




% Obliczanie w pętli
for n = 1:l
    for i = 1:REPET
    
        % ROZKŁAD JEDNOSTAJNY

        % na podstawie wzorów:
        % Euab = (a+b)/2
        % Vuab = (b-a)^2/12
        % SIGuab = sqrt(Vuab)
        % obliczamy granice przedziałów:
        b = EXu + SIGu * sqrt(3);
        a = 2 * EXu - b;


        uniform = a + (b-a) .* rand(1, N(n));


        % wzory działające na rozkładzie jednostajnym
        % Euab = (a+b)/2;
        % Vuab = (b-a)^2/12;
        % SIGuab = sqrt(Vuab);

        % Estymaty
        EXu_estim(n, i) = EXestim(uniform);
        SIGu_estim1(n, i) = SIGestim1(uniform);
        SIGu_estim2(n, i) = SIGestim2(uniform);
        
        

        % ROZKŁAD NORMALNY
        normal = EXn + SIGn .* randn(1, N(n));

        % Estymaty
        EXn_estim(n, i) = EXestim(normal);
        SIGn_estim1(n, i) = SIGestim1(normal);
        SIGn_estim2(n, i) = SIGestim2(normal);

    end
    
    EXu_estim_avg(n) = EXestim(EXu_estim(n,:));
    SIGu_estim1_avg(n) = EXestim(SIGu_estim1(n,:));
    SIGu_estim2_avg(n) = EXestim(SIGu_estim2(n,:));

    EXn_estim_avg(n) = EXestim(EXn_estim(n,:));
    SIGn_estim1_avg(n) = EXestim(SIGn_estim1(n,:));
    SIGn_estim2_avg(n) = EXestim(SIGn_estim2(n,:));

    EXu_true = EXu;
    SIGu_true = SIGu;
    EXn_true = EXn;
    SIGn_true = SIGn;
    
    EXu_estim_err(n) = abs(EXu_true - EXu_estim_avg(n));
    SIGu_estim1_err(n) = abs(SIGu_true - SIGu_estim1_avg(n));
    SIGu_estim2_err(n) = abs(SIGu_true - SIGu_estim2_avg(n));

    EXn_estim_err(n) = abs(EXn_true - EXn_estim_avg(n));
    SIGn_estim1_err(n) = abs(SIGn_true - SIGn_estim1_avg(n));
    SIGn_estim2_err(n) = abs(SIGn_true - SIGn_estim2_avg(n));

    EXu_estim_var1(n) = VAR1(EXu_estim(n,:));
    SIGu_estim1_var1(n) = VAR1(SIGu_estim1(n,:));
    SIGu_estim2_var1(n) = VAR1(SIGu_estim2(n,:));

    EXn_estim_var1(n) = VAR1(EXn_estim(n,:));
    SIGn_estim1_var1(n) = VAR1(SIGn_estim1(n,:));
    SIGn_estim2_var1(n) = VAR1(SIGn_estim2(n,:));
    
    EXu_estim_var2(n) = VAR2(EXu_estim(n,:));
    SIGu_estim1_var2(n) = VAR2(SIGu_estim1(n,:));
    SIGu_estim2_var2(n) = VAR2(SIGu_estim2(n,:));

    EXn_estim_var2(n) = VAR2(EXn_estim(n,:));
    SIGn_estim1_var2(n) = VAR2(SIGn_estim1(n,:));
    SIGn_estim2_var2(n) = VAR2(SIGn_estim2(n,:));
    
end


% Wypisanie wyników
EXu_estim_avg
SIGu_estim1_avg
SIGu_estim2_avg

EXn_estim_avg
SIGn_estim1_avg
SIGn_estim2_avg

EXu_true
SIGu_true
EXn_true
SIGn_true

EXu_estim_err
SIGu_estim1_err
SIGu_estim2_err

EXn_estim_err
SIGn_estim1_err
SIGn_estim2_err

EXu_estim_var1
SIGu_estim1_var1
SIGu_estim2_var1

EXn_estim_var1
SIGn_estim1_var1
SIGn_estim2_var1

EXu_estim_var2
SIGu_estim1_var2
SIGu_estim2_var2

EXn_estim_var2
SIGn_estim1_var2
SIGn_estim2_var2


% wykreślenie przykładowych wykresów rozkładów
% N - podaj ręcznie ile chcesz próbek
n = 100;
b = EXu + SIGu * sqrt(3);
a = 2 * EXu - b;
uniform_new = a + (b-a) .* rand(1, n);
normal_new = EXn + SIGn .* randn(1, n);


figure
plot(uniform_new)
title(['rozkład jednostajny, N=', num2str(n), ', EX =', num2str(EXu), ', std div.=', num2str(SIGu)])

figure
plot(normal_new)
title(['rozkład normalny, N=', num2str(n), ', EX =', num2str(EXn), ', std div.=', num2str(SIGn)])


% wykreślenie pozostałych wykresów
figure
plot(EXu_estim_avg)
title('EXu_estim_avg')

figure
plot(SIGu_estim1_avg)
title('SIGu_estim1_avg')

% figure
% plot(SIGu_estim2_avg)
% title('SIGu_estim2_avg')


figure
plot(EXn_estim_avg)
title('EXn_estim_avg')

figure
plot(SIGn_estim1_avg)
title('SIGn_estim1_avg')

% figure
% plot(SIGn_estim2_avg)
% title('SIGn_estim2_avg')


% figure
% plot(EXu_true)
% title('EXu_true')
% 
% figure
% plot(SIGu_true)
% title('SIGu_true')
% 
% figure
% plot(EXn_true)
% title('EXn_true')
% 
% figure
% plot(SIGn_true)
% title('SIGn_true')


figure
plot(EXu_estim_err)
title('EXu_estim_err')

figure
plot(SIGu_estim1_err)
title('SIGu_estim1_err')

figure
plot(SIGu_estim2_err)
title('SIGu_estim2_err')


figure
plot(EXn_estim_err)
title('EXn_estim_err')

figure
plot(SIGn_estim1_err)
title('SIGn_estim1_err')

figure
plot(SIGn_estim2_err)
title('SIGn_estim2_err')


figure
plot(EXu_estim_var1)
title('EXu_estim_var1')

figure
plot(SIGu_estim1_var1)
title('SIGu_estim1_var1')

figure
plot(SIGu_estim2_var1)
title('SIGu_estim2_var1')


figure
plot(EXn_estim_var1)
title('EXn_estim_var1')

figure
plot(SIGn_estim1_var1)
title('SIGn_estim1_var1')

figure
plot(SIGn_estim2_var1)
title('SIGn_estim2_var1')


% figure
% plot(EXu_estim_var2)
% title('EXu_estim_var2')
% 
% figure
% plot(SIGu_estim1_var2)
% title('SIGu_estim1_var2')
% 
% figure
% plot(SIGu_estim2_var2)
% title('SIGu_estim2_var2')
% 
% 
% figure
% plot(EXn_estim_var2)
% title('EXn_estim_var2')
% 
% figure
% plot(SIGn_estim1_var2)
% title('SIGn_estim1_var2')
% 
% figure
% plot(SIGn_estim2_var2)
% title('SIGn_estim2_var2')



% Funkcje służące do estymowania wartości średnich oraz odchyleń
% standardowych
function e = EXestim(x)
    l = length(x);
    e = 1/l * sum(x);
end

function s = SIGestim1(x)
    l = length(x);
    EX = EXestim(x);
    s = sqrt(1/l * sum((x-EX).^2));
end

function s = SIGestim2(x)
    l = length(x);
    EX = EXestim(x);
    s = sqrt(1/(l-1) * sum((x-EX).^2));
end

function v = VAR1(x)
    EX = EXestim(x);
    v = EXestim((x-EX).^2);
end

function v = VAR2(x)
    x_square = x .^ 2;
    v = EXestim(x_square) - (EXestim(x)).^2;
end
