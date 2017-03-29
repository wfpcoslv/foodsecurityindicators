
* Las estrategias de supervivencia miden la gravedad de las acciones utilizadas por los hogares para 
enfrentarse al impacto de un evento
Primero se reclasifican las variables para que sean num?ricas Se toma en consideracion que solo se 
acepta la estrategia de supervivencia si el hogar encuestado respondi? que si la hab?a aplicado
Para referencia de las estrategias revisar boleta de ejemplo
.
*P6.2.a Depender de la ayuda de familiares o amigos [ESTRES].
COMPUTE CPAsset1=0.
EXECUTE.
IF  (P10A = 1) CPAsset1=1.
EXECUTE.

*P6.2.b Comprar a crédito o pedir alimentos prestados [ESTRES].
COMPUTE CPAsset2=0.
EXECUTE.
IF  (P10B  = 1) CPAsset2=1.
EXECUTE.

*P6.2.a Pedir dinero prestado [ESTRES].
COMPUTE CPAsset3=0.
EXECUTE.
IF  (P10C  = 1) CPAsset3=1.
EXECUTE.

*P6.2.a Gastar los ahorros [ESTRES].
COMPUTE CPAsset4=0.
EXECUTE.
IF  (P10D  = 1) CPAsset4=1.
EXECUTE.

*P6.2.a Vender animales menores si no es su fuente habitual de ingresos [ESTRES].
COMPUTE CPAsset5=0.
EXECUTE.
IF  (PC35  = 1) CPAsset5=1.
EXECUTE.

*P6.2.a Vender los activos domésticos [ESTRES].
COMPUTE CPAsset6=0.
EXECUTE.
IF  (PC33 = 1) CPAsset6=1.
EXECUTE.

*P6.2.a Sacar a los niños de la escuela [CRISIS].
COMPUTE CPAsset7=0.
EXECUTE.
IF  (PC37  = 1) CPAsset7=1.
EXECUTE.

*P6.2.a Disminuir gastos de salud y educación [CRISIS].
COMPUTE CPAsset8=0.
EXECUTE.
IF  (PC36  = 1) CPAsset8=1.
EXECUTE.

*P6.2.a Vender activos productivos (herramientas agrícolas, matocicletas, equipo de pesca) [CRISIS].
COMPUTE CPAsset9=0.
EXECUTE.
IF  (PC34  = 1) CPAsset9=1.
EXECUTE.

*P6.2.a Consumir las reservas de semillas que tenían para la próxima siembra [CRISIS].
COMPUTE CPAsset10=0.
EXECUTE.
IF  (PC31  = 1) CPAsset10=1.
EXECUTE.

*P6.2.a Disminuir gastos para los insumos de agricultura y/o ganado [CRISIS].
COMPUTE CPAsset11=0.
EXECUTE.
IF  (PC32  = 1) CPAsset11=1.
EXECUTE.

*P6.2.a Pedir limosna [EMERGENCIA].
COMPUTE CPAsset12=0.
EXECUTE.
IF  (P10E  = 1) CPAsset12=1.
EXECUTE.

*P6.2.a Abandono del hogar de todos los miembros familiares [EMERGENCIA].
COMPUTE CPAsset13=0.
EXECUTE.
IF  (P10F = 1) CPAsset13=1.
EXECUTE.

*P6.2.a Vender los animales reproductores hembra [EMERGENCIA].
COMPUTE CPAsset14=0.
EXECUTE.
IF  (P10G = 1) CPAsset14=1.
EXECUTE.

*P6.2.a Vender las tierras [EMERGENCIA].
COMPUTE CPAsset15=0.
EXECUTE.
IF  (P10H  = 1) CPAsset15=1.
EXECUTE.

*P6.2.a Trabajar solo por alimentos [OTRAS].
COMPUTE CPAsset16=0.
EXECUTE.
IF  (P10I  = 1) CPAsset16=1.
EXECUTE.

*P6.2.a Buscar otros empleos o emprender pequeños negocios [OTRAS].
COMPUTE CPAsset17=0.
EXECUTE.
IF  (PC38  = 1) CPAsset17=1.
EXECUTE.

*P6.2.a Migración de uno o más miembros del hogar [OTRAS].
COMPUTE CPAsset18=0.
EXECUTE.
IF  (PC39  = 1) CPAsset18=1.
EXECUTE.

* Se clasifican las estrategias seg?n el nivel de gravedad Estres, Crisis, Emergencia y Otras.
* Estrategias de estres.
do if (CPAsset1=1 or CPAsset2=1 or CPAsset3=1 or CPAsset4=1 or CPAsset5=1 or CPAsset6=1).
compute stress_coping = 1. 
ELSE.
compute stress_coping = 0. 
end if. 
EXECUTE.

*Estrategias de Crisis.
do if (CPAsset7=1 or CPAsset8=1 or CPAsset9=1 or CPAsset10=1 or CPAsset11=1).
compute crisiscoping = 1. 
ELSE.
compute crisiscoping = 0. 
end if. 
EXECUTE.

*Estrategias de emergencias. 
do if (CPAsset12=1 or CPAsset13=1 or CPAsset14=1 or CPAsset15=1).
compute emergencycoping = 1. 
ELSE. 
compute emergencycoping = 0.
end if. 
EXECUTE.

* Etiquetas para las clasficaciones.
VARIABLE LABELS stress_coping 'did HH engage in stress coping strategies?'. 
VARIABLE LABELS crisiscoping 'did HH engage in crisis coping strategies?'. 
VARIABLE LABELS emergencycoping 'did HH engage in emergency coping strategies?'. 
EXECUTE.

* Re-clasificaci?n de estrategias seg?n nivel de severidad para el CARI.
RECODE stress_coping (0=0) (1=2). 
EXECUTE.

RECODE crisiscoping (0=0) (1=3). 
EXECUTE.

RECODE emergencycoping (0=0) (1=4). 
EXECUTE.

* La clasificaci?n del hogar corresponde a la estrategia m?s grave utilizada.
COMPUTE CSIr2=MAX(stress_coping,crisiscoping,emergencycoping). 
EXECUTE. 
RECODE CSIr2 (0=1).
EXECUTE.

* Etiquetas para el an?lisis.
Value labels CSIr2 
1 'HH not adopting coping strategies' 
2 'Stress coping strategies ' 
3 'crisis coping strategies ' 
4 'emergencies coping strategies'.
EXECUTE.

Variable Labels CSIr2 'summary of asset depletion'.