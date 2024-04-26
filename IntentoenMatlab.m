clear;
clc;
x = linspace(0,6,100);
y = linspace(-3,3,100);
k = 9e9;
[X, Y] = meshgrid(x, y);
q=1;
limite_superior=2;
limite_inferior=-2;
longitud=4;
xv=2;

funcion_campo_en_x=@(x,y) ((-k.*q.*(y-limite_superior))./(longitud.*(x-xv).*sqrt(((x-xv).^2)+((y-limite_superior).^2))))-((-k.*q.*(y-limite_inferior))./(longitud.*(x-xv).*sqrt(((x-xv).^2)+((y-limite_inferior).^2))));
funcion_campo_en_y=@(x,y) ((k.*q)./(longitud.*(sqrt(((x-xv).^2)+((y-limite_superior).^2)))))-((k.*q)./(longitud.*(sqrt(((x-xv).^2)+((y-limite_inferior).^2)))));
funcion_Voltaje = @(x,y) (k.*q.*(x-xv))./(((x-xv).^2 + (y-longitud).^2).^(3/2));

Ey=funcion_campo_en_y(X,Y);
Ex=funcion_campo_en_x(X,Y);
V = funcion_Voltaje(X,Y);

q2=-1;
limite_superior2=1;
limite_inferior2=-1;
longitud2=2;
xv2=3;

funcion_campo_en_x2=@(x,y) ((-k.*q2.*(y-limite_superior2))./(longitud2.*(x-xv2).*sqrt(((x-xv2).^2)+((y-limite_superior2).^2))))-((-k.*q2.*(y-limite_inferior2))./(longitud2.*(x-xv2).*sqrt(((x-xv2).^2)+((y-limite_inferior2).^2))));
funcion_campo_en_y2=@(x,y) ((k.*q2)./(longitud2.*(sqrt(((x-xv2).^2)+((y-limite_superior2).^2)))))-((k.*q2)./(longitud2.*(sqrt(((x-xv2).^2)+((y-limite_inferior2).^2)))));

Ey2=funcion_campo_en_y2(X,Y);
Ex2=funcion_campo_en_x2(X,Y);

Eyt=Ey+Ey2;
Ext=Ex+Ex2;

figure;
% Graficar las flechas con quiver
streamslice(X, Y, Ext, Eyt);
title('Campo Electrico de una Carga Puntual')
xlabel('x (m)')
ylabel('y (m)')
