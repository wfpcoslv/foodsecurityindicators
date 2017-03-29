
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

* Promedio de consumo de cada grupo de alimento (16 grupos) por clasificaci�n de DDS. 
* Custom Tables
CTABLES
  /VLABELS VARIABLES=@1_16Cerealesygranos @2_16Ra�cesytub�rculos @3_16Legumbresofrutossecos 
    @4_16Vegetalesanaranjados @5_16Vegetalesdehojasverdes @6_16Otrosvegetales @7_16Frutasdecolornaranja 
    @8_16Otrasfrutas @9_16Carnes @10_16V�sceras @11_16Pescado_Mariscos @12_16Huevos 
    @13_16Lecheyotrosprod.l�cteos @14_16Aceite_Grasas_Mantequilla @15_16Az�carodulces DDSgroups 
    DISPLAY=LABEL
  /TABLE @1_16Cerealesygranos [S][MEAN] + @2_16Ra�cesytub�rculos [S][MEAN] + 
    @3_16Legumbresofrutossecos [S][MEAN] + @4_16Vegetalesanaranjados [S][MEAN] + 
    @5_16Vegetalesdehojasverdes [S][MEAN] + @6_16Otrosvegetales [S][MEAN] + @7_16Frutasdecolornaranja 
    [S][MEAN] + @8_16Otrasfrutas [S][MEAN] + @9_16Carnes [S][MEAN] + @10_16V�sceras [S][MEAN] + 
    @11_16Pescado_Mariscos [S][MEAN] + @12_16Huevos [S][MEAN] + @13_16Lecheyotrosprod.l�cteos [S][MEAN] 
    + @14_16Aceite_Grasas_Mantequilla [S][MEAN] + @15_16Az�carodulces [S][MEAN] BY DDSgroups
  /CATEGORIES VARIABLES=DDSgroups ORDER=A KEY=VALUE EMPTY=INCLUDE.

* Gr�fico. 
* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=DDSgroups MEAN(FGDDS_certub) MEAN(FGDDS_legfru) 
    MEAN(FGDDS_veg) MEAN(FGDDS_frutas) MEAN(FGDDS_carhue) MEAN(FGDDS_leche) MEAN(FGDDS_aceite) MISSING=LISTWISE 
    REPORTMISSING=NO
    TRANSFORM=VARSTOCASES(SUMMARY="#SUMMARY" INDEX="#INDEX")
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: DDSgroups=col(source(s), name("DDSgroups"), unit.category())
  DATA: SUMMARY=col(source(s), name("#SUMMARY"))
  DATA: INDEX=col(source(s), name("#INDEX"), unit.category())
  COORD: rect(dim(1,2), cluster(3,0))
  GUIDE: axis(dim(3), label("DDS groupos"))
  GUIDE: axis(dim(2), label("Mean"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label(""))
  SCALE: cat(dim(3), include("1.00", "2.00", "3.00"))
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), include("0", "1", "2", "3", "4", "5", "6"))
  SCALE: cat(dim(1), include("0", "1", "2", "3", "4", "5", "6"))
  ELEMENT: interval(position(INDEX*SUMMARY*DDSgroups), color.interior(INDEX), 
    shape.interior(shape.square))
END GPL.