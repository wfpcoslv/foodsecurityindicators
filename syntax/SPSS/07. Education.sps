
****  calculate primary school attendance*******

WEIGHT BY hhweight.

USE ALL.
COMPUTE filter_$=((s1q5 > 5) & (s1q5 < 12)).
VARIABLE LABEL filter_$ '(s1q5 > 5) & (s1q5 < 12) (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMAT filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

**all

CROSSTABS
  /TABLES=STRATA region ez EZUrbRur ur FCG.28.42.52 WI_quintiles Livelihood FHH BY s1q8a
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

*** by sex

CROSSTABS
  /TABLES=STRATA region ez EZUrbRur ur FCG.28.42.52 WI_quintiles Livelihood FHH BY s1q8a BY sex
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.


************secondary school attendance**********


WEIGHT BY hhweight.

USE ALL.
COMPUTE filter_$=((s1q5 > 11) & (s1q5 < 15)).
VARIABLE LABEL filter_$ '(s1q5 > 5) & (s1q5 < 12) (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMAT filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

**all

CROSSTABS
  /TABLES=STRATA region ez EZUrbRur ur FCG.28.42.52 WI_quintiles Livelihood FHH BY s1q8a
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

*** by sex

CROSSTABS
  /TABLES=STRATA region ez EZUrbRur ur FCG.28.42.52 WI_quintiles Livelihood FHH BY s1q8a BY sex
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.


