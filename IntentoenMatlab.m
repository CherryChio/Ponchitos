clear;
clc;
%inputs para el usuario

prompt = {'Ingresa la longitud:','Ingresa el punto incial en Y:', 'Ingresa la posicion en X:','Ingresa la carga:'};
dlgtitle = 'Varilla 1';
fieldsize = [1 45];
definput = {'4','-2','2','1'};
Varilla1 = inputdlg(prompt,dlgtitle,fieldsize,definput);

prompt = {'Ingresa la longitud:','Ingresa el punto incial en Y:','Ingresa la posicion en X:','Ingresa la carga:'};
dlgtitle2 = 'Varilla 2';
fieldsize = [1 45];
definput2 = {'2','-1','3','-1'};
Varilla2 = inputdlg(prompt,dlgtitle2,fieldsize,definput2);

%Creación del espacio y constantes
x = linspace(0,6,100);
y = linspace(-3,3,100);
k = 9e9;
[X, Y] = meshgrid(x, y);
v1 = 0;
v2 = 0;

%parametros varilla 1
q=str2double(Varilla1{4});
lim_inf=str2double(Varilla1{2});
longitud=str2double(Varilla1{1});
lim_sip=lim_inf + longitud;
xv=str2double(Varilla1{3});

%Parametros varilla 2
q2=str2double(Varilla2{4});
lim_inf2=str2double(Varilla2{2});
longitud2=str2double(Varilla2{1});
lim_sup2=lim_inf2 + longitud2;
xv2=str2double(Varilla2{3});

%Calculos para varilla 1
funcion_campo_en_x=@(x,y) ((-k.*q.*(y-lim_sip))./(longitud.*(x-xv).*sqrt(((x-xv).^2)+((y-lim_sip).^2))))-((-k.*q.*(y-lim_inf))./(longitud.*(x-xv).*sqrt(((x-xv).^2)+((y-lim_inf).^2))));
funcion_campo_en_y=@(x,y) ((k.*q)./(longitud.*(sqrt(((x-xv).^2)+((y-lim_sip).^2)))))-((k.*q)./(longitud.*(sqrt(((x-xv).^2)+((y-lim_inf).^2)))));

for i = lim_inf:0.001:lim_sip
    Rn = sqrt((X-xv).^2+(Y-i).^2);
    Vn = k+(q./longitud)./Rn;

  
    v1 = Vn + v1;
end

Ey=funcion_campo_en_y(X,Y);
Ex=funcion_campo_en_x(X,Y);

%Calculos varilla 2
funcion_campo_en_x2=@(x,y) ((-k.*q2.*(y-lim_sup2))./(longitud2.*(x-xv2).*sqrt(((x-xv2).^2)+((y-lim_sup2).^2))))-((-k.*q2.*(y-lim_inf2))./(longitud2.*(x-xv2).*sqrt(((x-xv2).^2)+((y-lim_inf2).^2))));
funcion_campo_en_y2=@(x,y) ((k.*q2)./(longitud2.*(sqrt(((x-xv2).^2)+((y-lim_sup2).^2)))))-((k.*q2)./(longitud2.*(sqrt(((x-xv2).^2)+((y-lim_inf2).^2)))));

for i = lim_inf2:0.001:lim_sup2
    Rn2 = sqrt((X-xv2).^2+(Y-i).^2);
    Vn2 = k+(q2./longitud)./Rn2;

  
    v2 = Vn2 + v2;
end

Ey2=funcion_campo_en_y2(X,Y);
Ex2=funcion_campo_en_x2(X,Y);

%Calculos de superposición
Eyt=Ey+Ey2;
Ext=Ex+Ex2;
V = v1 + v2;


% Graficar las flechas con streamslice
figure;
streamslice(X, Y, Ext, Eyt);
hold on
contour(X,Y,V,100)
axis equal
title('Campo Electrico de 2 placas')
xlabel('x (m)')
ylabel('y (m)')
