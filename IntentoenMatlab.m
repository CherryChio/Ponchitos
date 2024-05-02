clear;
clc;
%inputs para el usuario

prompt = {'Ingresa la longitud:','Ingresa el punto incial en Y:', 'Ingresa la posicion en X:','Ingresa la carga:'};
dlgtitle = 'Varilla 1';
fieldsize = [1 45];
definput = {'4','-2','2','1'};
Varilla1 = inputdlg(prompt,dlgtitle,fieldsize,definput);

prompt = {'Ingresa la longitud:','Ingresa el punto incial en Y:', 'Ingresa la posicion en X:','Ingresa la carga:'};
dlgtitle2 = 'Varilla 2';
fieldsize = [1 45];
definput2 = {'2','-1','3','-1'};
Varilla2 = inputdlg(prompt,dlgtitle2,fieldsize,definput2);

%parametros varilla 1
q=str2double(Varilla1{4});
lim_inf=str2double(Varilla1{2});
longitud=str2double(Varilla1{1});
lim_sup=lim_inf + longitud;
xv=str2double(Varilla1{3});

%Parametros varilla 2
q2=str2double(Varilla2{4});
lim_inf2=str2double(Varilla2{2});
longitud2=str2double(Varilla2{1});
lim_sup2=lim_inf2 + longitud2;
xv2=str2double(Varilla2{3});

%Creación del espacio y constantes
x = linspace(min([xv,xv2])-2,max([xv,xv2])+2,100);
y = linspace(min([lim_inf,lim_inf2])-1,max([lim_sup,lim_sup2])+1,100);
k = 9e9;
[X, Y] = meshgrid(x, y);

%Calculos para varilla 1
FcX=@(x,y) ((-k.*q.*(y-lim_sup))./(longitud.*(x-xv).*sqrt(((x-xv).^2)+((y-lim_sup).^2))))-((-k.*q.*(y-lim_inf))./(longitud.*(x-xv).*sqrt(((x-xv).^2)+((y-lim_inf).^2))));
FcY=@(x,y) ((k.*q)./(longitud.*(sqrt(((x-xv).^2)+((y-lim_sup).^2)))))-((k.*q)./(longitud.*(sqrt(((x-xv).^2)+((y-lim_inf).^2)))));

% for i = lim_inf:0.01:lim_sip
%     Rn = sqrt((X-xv).^2+(Y-i).^2);
%     Vn = k+(q./longitud)./Rn;
%     v1 = Vn + v1;
% end
v1 = Calculo_voltaje(X,Y,lim_sup,lim_inf,longitud,k,q,xv);
Ey=FcY(X,Y);
Ex=FcX(X,Y);

%Calculos varilla 2
FcX2=@(x,y) ((-k.*q2.*(y-lim_sup2))./(longitud2.*(x-xv2).*sqrt(((x-xv2).^2)+((y-lim_sup2).^2))))-((-k.*q2.*(y-lim_inf2))./(longitud2.*(x-xv2).*sqrt(((x-xv2).^2)+((y-lim_inf2).^2))));
FcY2=@(x,y) ((k.*q2)./(longitud2.*(sqrt(((x-xv2).^2)+((y-lim_sup2).^2)))))-((k.*q2)./(longitud2.*(sqrt(((x-xv2).^2)+((y-lim_inf2).^2)))));

% for i = lim_inf2:0.01:lim_sup2
%     Rn2 = sqrt((X-xv2).^2+(Y-i).^2);
%     Vn2 = k+(q2./longitud)./Rn2;
%     v2 = Vn2 + v2;
% end

v2 = Calculo_voltaje(X,Y,lim_sup2,lim_inf2,longitud,k,q2,xv2);
Ey2=FcY2(X,Y);
Ex2=FcX2(X,Y);

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

function [voltaje] = Calculo_voltaje(x,y,lim_sip,lim_inf,longitud,k,q,xv)
    voltaje=((k.*q)./longitud).*log(abs((sqrt(((x-xv).^2)+((y-lim_sip).^2))+(y-lim_sip))./(x-xv)))-((k.*q)./longitud).*log(abs((sqrt(((x-xv).^2)+((y-lim_inf).^2))+(y-lim_inf))./(x-xv)));
end
