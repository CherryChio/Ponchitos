clear;
clc;
x = linspace(-1,4,100);
y = linspace(-2,3,100);
k = 9e9;
[X, Y] = meshgrid(x, y);
q=-1;
limite_superior=2;
limite_inferior=-2;
longitud=4;
xv=2;


funcion_campo_en_x_superior=@(x,y) ((-k.*q*(y-limite_superior))./(longitud*(x-xv)*sqrt(((x-xv).^2)+((y-limite_superior).^2))))-((-k.*q*(y-0))./(longitud*(x-xv)*sqrt((x-xv).^2)+((y-0).^2)));
funcion_campo_en_x_inferior=@(x,y) ((-k.*q*(y-0))./(longitud*(x-xv)*sqrt(((x-xv).^2)+((y-0).^2))))-((-k.*q*(y-limite_inferior))./(longitud*(x-xv)*sqrt((x-xv).^2)+((y-limite_inferior).^2)));
funcion_campo_en_y=@(x,y) ((k.*q)./(longitud.*(sqrt(((x-xv).^2)+((y-limite_superior).^2)))))-((k.*q)./(longitud.*(sqrt(((x-xv).^2)+((y-limite_inferior).^2)))));

f=funcion_campo_en_x_superior(-1,-2)+funcion_campo_en_x_inferior(-1,-2)
Ey=funcion_campo_en_y(X,Y);
Ex=funcion_campo_en_x(X,Y);

figure;
% Graficar las flechas con quiver
streamslice(X, Y, Ex, Ey);
title('Campo Electrico de una Carga Puntual')
xlabel('x (m)')
ylabel('y (m)')