clc;
clear all;

%% Логическая индексация

clc;
clear all;
A = randi(10, 4, 5);
% A = 3:9;
B = (A>6); % возвращает логический массив размером как матрица А
C = A(A>6); % возвращает вектор-столбец из элементов, соответствующих условию
clear A B C

x = linspace(1, 10, 91);
y = cos(x);
y(y<0) = 0; % присваивает значение 0 всем элементам меньше 0 в векторе y
y(x<2.5)=x(x<2.5);
clear x y

a = ones(10); % матрица 10х10
b = a([1,1,4], 2:2:end);
clear a b

% Функция find
% x = 3:9;
x = randi(10, 4, 5);
ind = find(x>6); % (x>6) = [0,0,0,0,1,1,1]; 
a = [5,6,7; 8,9,10; 11,12,13];
b = find(a>8);
[i,j] = find(a>8); % i = [3;2;3;2;3]; j = [1;2;2;3;3];
k = a(2);
l = a(4);

Linear_a = a(:);
d_arr = randi(10, 3, 4, 5);
d_linear = d_arr(:);

%% Графики

clc;
clear all;

x = linspace(-10,10,500);
c = 4;
data_0 = x.^2 + c;

plot(x,data_0);

data_1 = x.^3 + c;
data_2 = x.^4 + c;
% subplot(2, 1, 1), plot(x, data_1);
% subplot(2, 1, 2), plot(x, data_2);

subplot(2, 2, 1), plot(x, data_1, 'LineWidth', 2, 'Color', 'red');
subplot(2, 2, [3,4]), plot(x, data_2);

Data = [data_0; data_1; data_2]; % united plots

plot(x, Data.');
hold on;
extra_data = x;
plot(extra_data);

xlim([-5,10]) % масштаб

ylim([-2,6]) % масштаб

grid on;

legend("data 0", "data 1", "data 2", "data extra")

title("Test name");

xlabel('123123');
ylabel('Y');

close all;

% exportgraphics;
%% Функции

% Анонимная функция
clc;
clear all;
powers = @(x, y) x.^y;
array1 = [3, 5, 6];
array2 = [4, 2, 2];
array3 = powers(array1, array2);

% m-функция, вложенная функция и подфункция
%%
clear all;


array1 = randi(10, 1, 100);
[elementsmore5, disp] = dispersion (array1);
disp
elementsmore5


%% Практическое применение численных методов

%% Решение СЛАУ

% Допустим, у нас имеется система уравнений
% x + 2y + 3z = 4
% 3x - 5y + 1z = -13
% x + 3y - 2z = 12
% Решим её с помощью операторов Matlab

clc;
clear all;

A = [ 1, 2, 3; 3, -5, 1; 1, 3, -2];
% A_virozhd = [ 1, 2, 3; 1, 2, 3; 1, 3, -2]; % пример работы с вырожденной
% матрицей
b = [4; -13; 12];
Decision1 = A\b; % аналогично Decision = A^(-1)*b
% Decision_united_vrzd = A_virozhd\b; % работа с вырожденными матрицами

% Допустим, в правой части у нас будут разные значения. Для них всех можно
% определить решения за 1 операцию, объединив значения в одну матрицу
b1 = [ 9; -3; 6];
b2 = [ 10; 0; 7];
b3 = [ 3; -10; -1];
b_united = [b1, b2, b3];
Decision_united = A\b_united;


% Решение нелинейных уравнений
clear all;
f = @(x)x.^2-2 % функция, ноль которой необходимо найти, задаётся через указатель @
x0 = fzero (f, 1.4); % начальное приближение решения - 1.4, может работать только с уравнениями, где меняется знак в левой части
x1 = fsolve (f, 1.4);

clc;
clear all;
a = 3;
f = @(x)TestEquation(x, a);
x0 = fsolve(f, 1.5);

%% Численное интегрирование и дифференцирование

% Интегрирование
clc;
clear all;
f = @(x) 0.25*x.^3-(1/3)*x.^2
f1 = @(x) exp(-x.^2);
test = integral(f1, 0, Inf);
int_f = integral(f, -5, 5);
%int_f2 = polyint(f);
int_f_appr = integral(f1, 0, 5, 'RelTol', 0, 'AbsTol', 1e-12);

% Дифференцирование

step = 0.01;
x = 0:step:pi;
y = cos(x);
y2 = 4*x.^2 - 5;
dy_dx = gradient(y, step);
% dy_dx2 = polyder(y2);

%% Решение дифференциальных уравнений

% Рассмотрим дифф. уравнение y''+y'+y = sin(3t)
% Начальные условия y(0) = 0, y'(0) = 0
% Метод Рунге-Кутта
% Приведём уравнение к виду, содержащему только первые производные:
% y1'(t)= y2
% y2'(t)= sin(3t)-y1(t)-y2(t)
% y1(t) - исходная функция, y2(t)= dy1(t)/dt - вспомогательная
clc;
clear all;
y0 = [0, 0];
tspan = [0, 30];
[t, y] = ode45(@odefcn, tspan, y0);
plot (t, y(:,1));
solution = ode45(@odefcn, tspan, y0);
t = linspace(0, 30, 1000);
y = deval(solution, t); % определить значение y в определённых точках

%% Интерполяция и аппроксимация

% Интерполяция
clc;
clear all;
xt = 0:10; % дискретные отсчёты данных
yt = cos(xt); % дискретные отсчёты данных
x = linspace(0,10); % точки, в которых вычисляются значения
y = interp1(xt, yt, x, 'spline');

% Аппроксимация
x = linspace(0,3);
y = cos(x) + 0.4*randn(size(x)); % зашумлённые данные
p = polyfit(x,y,4); % аппроксимация полиномом 4 степени
ya = polyval(p,x); % результат аппроксимации

clear all;

x = linspace(0,3);
y = sin(x) + 0.3*randn(size(x));
y1 = ones(size(x));
y2 = exp(-x);
y3 = x;
M = [y1.', y2.', y3.'];
a = M\y.';
ya = a(1)*y1+a(2)*y2+a(3)*y3; % результат аппроксимации

%% Символьные значения

clc;
clear all;
syms x y
z = x.^2*y + cos(x);
a = diff(x^3); % дифференцирование 
b = diff(z,y); % дифференцирование по у
c = int(x^2); % интегрирование
d = int(x^2, 0, 1); % интегрирование от 0 до 1 по х
e = int(z, y, 0, 1); % интегрирование от 0 до 1 по х
f = int(1/x, 0, Inf); % значение равно бесконечности

doubld = double(d); % численные выражения, полученные из символьных, можно преобразовать в числа
zf = matlabFunction(z); % символьные значения в выражении представить в виде double
value = zf(1, 2);
pretty(z)

% close all


function dydt = odefcn(t, y)
dydt = zeros(2,1);
dydt(1)= y(2);
dydt(2)= -y(1)-y(2)+sin(3*t);
end
