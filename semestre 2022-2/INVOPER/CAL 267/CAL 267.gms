SETS					
					
t periodos	/Mar,Abr,May,Jun,Jul,Ago,Sep,Oct,Nov,Dic/				
l niveles	/1,2,3,4/;				
					
PARAMETERS					
					
d(t) La demanda pronosticada en cada periodo en Giga-Btu para cada periodo					
					
/Mar	517				
Abr	339				
May	209				
Jun	396				
Jul	476				
Ago	531				
Sep	807				
Oct	956				
Nov	1000				
Dic	1195/				
					
b(t) La produccion pronosticada en cada periodo en G-Btu para cada periodo					
					
/Mar	699				
Abr	700				
May	602				
Jun	301				
Jul	692				
Ago	690				
Sep	414				
Oct	896				
Nov	897				
Dic	907/				
					
					
p(t) El costo de iniciar de la producción en dólares para los meses del 2016					
					
/Mar	1000				
Abr	1300				
May	1300				
Jun	1700				
Jul	1200				
Ago	1200				
Sep	1400				
Oct	1000				
Nov	900				
Dic	900/;				
					
TABLE					
					
h(t,l) El costo de sostenimiento inventarial por un periodo en cada nivel en dólares por G-BTU para 2016

          1    2    3      4

 Mar      1    1.5  1      2
 Abr      1    1.5  1      2
 May      1.3  1.5  1      2
 Jun      1.3  1.5  1      2
 Jul      1.3  1.5  1.2    2
 Ago      1.3  1.5  1.2    2
 Sep      1.3  1.5  1.2    2
 Oct      2    1.5  1.2    2
 Nov      2    1.5  1.2    2
 Dic      2    1.5  1.2    2
 ;


TABLE

c(t,l) El costo de transporte en cada nivel en dólares por G-BTU para el 2016

            1      2     3

 Mar        1     1.5    3
 Abr        1     1.5    3
 May        1     1.5    3
 Jun        1     1.5    3
 Jul        1     1.5    3
 Ago        1     1.5    3
 Sep        1     1.5    3
 Oct        1.2   1.8    3
 Nov        1.2   1.8    3
 Dic        1.2   1.8    3;	
					
					
VARIABLES					
					
y(t) Cantidad de gas natural (Giga BTU) a producir en el periodo t					
x(t,l) Cantidad de gas natural (Giga BTU) a enviar desde el nivel  l al nivel  l+1 en el periodo t					
I(t,l) Cantidad de gas natural (Giga BTU) a almacenar en el nivel l al final del periodo t					
z Función objetivo: Costo total de transporte;					
					
POSITIVE VARIABLE					
					
y,x,I;					
					
					
EQUATIONS					
					
objetivo Valor de la función objetivo					
entrada Balance de entrada					
inventario1 Balance de inventario					
inventario2 Balance de inventario					
salida Balance de salida					
produccion Capacidad de producción;					
					
objetivo.. z=E= sum(t,p(t)*y(t))+sum(t,sum(l,c(t,l-1)*x(t,l-1)))+sum(t,sum(l,h(t,l)*I(t,l)));					
entrada(t,l).. x(t,'1')+I(t,'1') =e= y(t)+I(t-1,'1');					
inventario1(t,l).. x(t,'2')+I(t,'2') =e= x(t,'1')+I(t-1,'2');					
inventario2(t,l).. x(t,'3')+I(t,'3') =e= x(t,'2')+I(t-1,'3');					
salida(t,l).. (d(t)+ I(t,'4'))=e=(x(t,'3')+I(t-1,'4'));					
produccion(t).. y(t)=l=b(t);					
					
					
MODEL	Modelo	/All/;			
SOLVE	Modelo	USING	LP	MINIMIZING	z;
