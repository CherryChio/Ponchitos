clear;
clc;
k=9e9;
lambda=1/4;
x = linspace(0,6,100);
y = linspace(-3,3,100);
[X_coordenada, Y_coordenada] = meshgrid(x, y);
x_varilla=2;
syms l x_integral y_integral

% Define una pequeña cantidad para evitar división por cero
epsilon = 1e-10;

% Define la fórmula del voltaje con manejo de división por cero
formula_voltaje = (-k * lambda) ./ sqrt((x_integral - x_varilla).^2 + (y_integral - l).^2 + epsilon);

% Calcula la integral del voltaje
integral_voltaje = int(formula_voltaje, l);

% Calcula el gradiente respecto a x_integral
gradiente_x = diff(integral_voltaje, x_integral);

% Evalúa el gradiente en la rejilla de puntos
gradiente_x2 = subs(gradiente_x, {x_integral, y_integral,l}, {X_coordenada, Y_coordenada, 2});
gradiente_x21 = subs(gradiente_x, {x_integral, y_integral,l}, {X_coordenada, Y_coordenada, -2});

% Calcula la diferencia entre los gradientes
resultado = double(gradiente_x2 - gradiente_x21);

% Calcula el gradiente respecto a y_integral
gradiente_y = diff(integral_voltaje, y_integral);

% Evalúa el gradiente en la rejilla de puntos
gradiente_y2 = subs(gradiente_y, {x_integral, y_integral,l}, {X_coordenada, Y_coordenada, 2});
gradiente_y21 = subs(gradiente_y, {x_integral, y_integral,l}, {X_coordenada, Y_coordenada, -2});

% Calcula la diferencia entre los gradientes
resultadoy = double(gradiente_y2 - gradiente_y21);


figure;
% Graficar las flechas con quiver
streamslice(X_coordenada, Y_coordenada, resultado, resultadoy);
title('Campo Electrico de una Carga Puntual')
xlabel('x (m)')
ylabel('y (m)')

