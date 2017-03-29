
**  crowding, as the number of people sleeping in the rooms divided by number of rooms for sleeping (higher number is worse).  

COMPUTE crowding = s3q3 / s3q2 .
EXECUTE .


***  recoding roofing, 1 is better, and 0 is worse.  palm bamboo, thatch, mud.earth all worse and the rest good.. several did not show up, so were not considered in the coding of the bad materials...

RECODE
  s3q4
  (1=1)  (2=1)  (3=1)  (10=1)  (12=1)  (13=1)  (14=1)  (16=1)  (ELSE=0)  INTO
   RoofBiv .
VARIABLE LABELS RoofBiv 'Roofing- bivariate variable'.
EXECUTE .


***  recoding floor  1 is better, 0 is worse, includes earth/sand, dung, palm (only one case with palm).  

RECODE
  s3q5
  (6=0)  (7=0)  (9=0)  (ELSE=1)  INTO  FloorBiv .
VARIABLE LABELS FloorBiv 'Floor Bivariate good bad'.
EXECUTE .

***  toilet recoding no facilities is bad, open pit is bad, bucket is bad, else ok....
RECODE
  s3q6
  (7=0) (4 = 0) (5 = 0) (ELSE=1)  INTO  ToiletBiv .
VARIABLE LABELS ToiletBiv 'Toilet- bivariate'.
EXECUTE .


***  lighting recode  electric compan, generator, solar are better, all else worse

RECODE
  s3q8
  (5=1)  (3=1)  (7=1)  (ELSE=0)  INTO  LightingBiv .
VARIABLE LABELS LightingBiv 'lighting bivariate'.
EXECUTE .


***  water recode  surface, unprotected spring, unprotected well worse, all others better....  

RECODE
  s3q9
  (5=0)  (8=0)  (3=0)  (ELSE=1)  INTO  WaterBiv .
VARIABLE LABELS WaterBiv 'Water, drinking bivariate'.
EXECUTE .


**  combined car/truck/motorbike/boat variable (motorized vehicle)

compute 
Motorveh = 0.
execute. 

do if (( s3q16g   = 1) |   ( s3q16h = 1) |  (s3q16j = 1) ).
recode Motorveh (0=1).
end if. 
execute.  


**  combined black and white TV with color TV

compute TV = 0.
execute. 

do if ((  s3q16o   = 1) |   ( s3q16p = 1)).
recode TV (0=1).
end if.
execute. 


*** frequencies of all the variables to be tried out.....


FREQUENCIES
  VARIABLES=RoofBiv FloorBiv ToiletBiv LightingBiv WaterBiv crowding Motorveh
  TV s3q16a s3q16b s3q16c s3q16e s3q16k s3q16l s3q16m s3q16n s3q16r s3q16u
  s3q16aa
  /ORDER=  ANALYSIS .

**** PCA codes, using ALL the above variables....  WI (first)  now in the dataset....   

FACTOR
  /VARIABLES RoofBiv FloorBiv ToiletBiv LightingBiv WaterBiv crowding Motorveh
  TV s3q16a s3q16b s3q16c s3q16e s3q16k s3q16l s3q16m s3q16n s3q16r s3q16u
  s3q16aa
/MISSING LISTWISE /ANALYSIS RoofBiv FloorBiv ToiletBiv LightingBiv WaterBiv crowding Motorveh
  TV s3q16a s3q16b s3q16c s3q16e s3q16k s3q16l s3q16m s3q16n s3q16r s3q16u
  s3q16aa
  /PRINT INITIAL EXTRACTION
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /ROTATION NOROTATE
  /SAVE REG(ALL)
  /METHOD=CORRELATION .

******  PCA, using all the above except for crowding and bicycle...  (this is the FINAL WI)

FACTOR
  /VARIABLES RoofBiv FloorBiv ToiletBiv LightingBiv WaterBiv Motorveh
  TV s3q16a s3q16b s3q16c s3q16e s3q16l s3q16m s3q16n s3q16r s3q16u
  s3q16aa
/MISSING LISTWISE /ANALYSIS RoofBiv FloorBiv ToiletBiv LightingBiv WaterBiv Motorveh
  TV s3q16a s3q16b s3q16c s3q16e s3q16l s3q16m s3q16n s3q16r s3q16u
  s3q16aa
  /PRINT INITIAL EXTRACTION
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /ROTATION NOROTATE
  /SAVE REG(ALL)
  /METHOD=CORRELATION .

***************************************************

RANK
  VARIABLES=FAC1_3  (A) /NTILES (5) /PRINT=YES
  /TIES=MEAN .

***


MEANS
  TABLES=RoofBiv FloorBiv ToiletBiv LightingBiv WaterBiv crowding Motorveh
  TV s3q16a s3q16b s3q16c s3q16e s3q16k s3q16l s3q16m s3q16n s3q16r s3q16u
  s3q16aa
BY NFAC1_1
  /CELLS MEAN .







CROSSTABS
  /TABLES=region BY FCG.28.42.52 BY ur
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT 
  /COUNT ROUND CELL.
