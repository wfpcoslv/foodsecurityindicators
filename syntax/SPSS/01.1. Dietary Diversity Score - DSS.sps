
*******************************************
** DDS (Diet Diversity Score). 
*Se contruye a partir de los grupos de alimentos utilizados para el FCS. 
*WFP uses the following IFPRI thresholds for interpretation. 6+ = good dietary diversity; 4.5�6 = medium dietary diversity; <4.5 = low dietary diversity.
COMPUTE FCS_UNCAP=sum(P050104,P050105,P050106,P050107,P050108,P050109,P050110,P050111,P050112,P050113).
EXECUTE.

**PASO 1: Consolidaci�n a grupos de alimentos a variables DDS. 
COMPUTE FGDDS_certub=sum(P050101,P050102).
VARIABLE LABELS  FGDDS_certub 'Cereales, granos, raices y tuberculos'.
EXECUTE.

COMPUTE FGDDS_legfru=sum(P050103).
VARIABLE LABELS  FGDDS_legfru 'Legumbres y frutos secos'.
EXECUTE.

COMPUTE FGDDS_veg=sum(P050104,P050105,P050106).
VARIABLE LABELS  FGDDS_veg 'Vegetales anaranjados, hojas verdes y otros'.
EXECUTE.

COMPUTE FGDDS_frutas=sum(P050107,P050108).
VARIABLE LABELS  FGDDS_frutas 'Frutas anaranjadas y otras frutas'.
EXECUTE.

COMPUTE FGDDS_carhue=sum(P050109,P050110,P050111,P050112).
VARIABLE LABELS  FGDDS_carhue 'Carnes, viceras y huevos'.
EXECUTE.

COMPUTE FGDDS_leche=sum(P050113).
VARIABLE LABELS  FGDDS_leche 'Leche y otros productos lacteos'.
EXECUTE.

COMPUTE FGDDS_aceite=sum(P050114).
VARIABLE LABELS  FGDDS_aceite 'Aceite, grasa y mantequilla'.
EXECUTE.

**PASO 2: Recodificar para obtener el conteo. 
RECODE
   FGDDS_certub FGDDS_legfru FGDDS_veg FGDDS_frutas FGDDS_carhue FGDDS_leche FGDDS_aceite (1 thru Highest=1)  .
EXECUTE .

**Paso 3: Calcular DDS.
COMPUTE DDS = FGDDS_certub + FGDDS_legfru + FGDDS_veg + FGDDS_frutas + FGDDS_carhue + FGDDS_leche + FGDDS_aceite.
VARIABLE LABELS DDS 'DDS numero de grupos consumidos'.
EXECUTE .

RECODE DDS (0 thru 4.5=1)  (4.6 thru 6=2)  (7 thru Highest=3)  INTO  DDSgroups .
VARIABLE LABELS DDSgroups 'DDS groupos'.
ADD VALUE LABELS DDSgroups 1 "DDS bajo (<4.5)" 2 "DDS medio (4.5-6)" 3 "DDS alto (>6)". 
EXECUTE .

** Paso 4: Resultados
DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=DDSgroups
  /STATISTICS=MEAN MEDIAN MODE
  /HISTOGRAM NORMAL
  /ORDER=VARIABLE.
