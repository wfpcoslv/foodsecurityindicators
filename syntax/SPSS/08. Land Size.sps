
*** ACRES... standard unit.  ***
***HECTARES ....   1 hectare is 2.5 acres***
** POLES    1pole is 210feet by 210 feet, so 70 yards by 70 yards, so 4,900 square yards.  1 pole = 1.01 acres   **
*** one ROPE  1 rope is 75 feet by 75 feet, or 25 yards by 25 yards... so 625 square yards.  1 rope =  0.12913
*** one plot...  we don't know... it's only a few, so we'll just equate it to an acre for now....   
***** for 'other' it is always 'very small land', one says 6 meters squared (36 square meters), so about .01 acres... 


IF  (s4q3b=1) LandAvailable=s4q3a*2.5.
EXECUTE.

IF  (s4q3b=2) LandAvailable=s4q3a.
EXECUTE.

IF  (s4q3b=3) LandAvailable=s4q3a*1.01.
EXECUTE.

IF  (s4q3b=4) LandAvailable=s4q3a* 0.12913.
EXECUTE.

IF  (s4q3b=5) LandAvailable=s4q3a .
EXECUTE.

IF  (s4q3b=6) LandAvailable=.01.
EXECUTE.

****** land cultivated 2008 ag season*****

IF  (s4q4b=1) LandCultivated=s4q4a*2.5.
EXECUTE.

IF  (s4q4b=2) LandCultivated=s4q4a.
EXECUTE.

IF  (s4q4b=3) LandCultivated=s4q4a*1.01.
EXECUTE.

IF  (s4q4b=4) LandCultivated=s4q4a* 0.12913.
EXECUTE.

IF  (s4q4b=5) LandCultivated=s4q4a .
EXECUTE.

IF  (s4q4b=6) LandCultivated=.01.
EXECUTE.

**** land harvested 2008 ag season ***

IF  (s4q5b=1) LandHarvested=s4q5a*2.5.
EXECUTE.

IF  (s4q5b=2) LandHarvested=s4q5a.
EXECUTE.

IF  (s4q5b=3) LandHarvested=s4q5a*1.01.
EXECUTE.

IF  (s4q5b=4) LandHarvested=s4q5a* 0.12913.
EXECUTE.

IF  (s4q5b=5) LandHarvested=s4q5a .
EXECUTE.

IF  (s4q5b=6) LandHarvested=.01.
EXECUTE.





******************************************************  looking at agricultural land only***********

USE ALL.
COMPUTE filter_$=(s4q1 = 1).
VARIABLE LABEL filter_$ 's4q1 = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMAT filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.


CROSSTABS
  /TABLES=STRATA region ez EZUrbRur FCG.28.42.52 WI_quintiles Livelihood FHH BY s4q2
  /FORMAT=AVALUE TABLES
  /CELLS=row 
  /COUNT ROUND CELL.
