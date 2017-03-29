*** Compute CSI**

COMPUTE CSI=(PC41_Acciones_ventas_comer_alimentos_mas_baratos_ultimos_12_mese*1)+
(PC42_Acciones_ventas_prestarse_alimentos_ultimos_12_meses_SI_NO*2)+
(PC46_Acciones_ventas_reducir_numero_comida_ultimos_12_meses_SI_N*1)+
(PC44_Acciones_ventas_reducir_comida_ultimos_12_meses_SI_NO*1)+
(PC45_Acciones_ventas_restringir_consumo_adultos_ultimos_12_meses*3).
EXECUTE.

FREQUENCIES VARIABLES=CSI
  /ORDER=ANALYSIS.
RECODE CSI (0 thru 23=1) (23.1 thru 46=2) (46.1 thru 80=3) INTO CSIterciles.

VARIABLE LABELS  CSIterciles 'Indice de estrategias de sobrevivencia por terciles'.
EXECUTE.

FREQUENCIES VARIABLES=CSIterciles 
  /ORDER=ANALYSIS.