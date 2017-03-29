s7q1b01	Maize, millet Number of days eaten in past 7 days	
s7q1b02	Rice Number of days eaten in past 7 days	
s7q1b03	wheat, bread, oth cereals Number of days eaten in past 7 days	
s7q1b04	Cassave Number of days eaten in past 7 days	
s7q1b05	roots and tubers (other) Number of days eaten in past 7 days	
s7q1b06	Plantain Number of days eaten in past 7 days	
s7q1b07	Fish/seafood Number of days eaten in past 7 days	
s7q1b08	Poultry Number of days eaten in past 7 days	
s7q1b09	Red meat Number of days eaten in past 7 days	
s7q1b10	Wild meat Number of days eaten in past 7 days	
s7q1b11	Eggs Number of days eaten in past 7 days	
s7q1b12	Pulses, beans, nuts Number of days eaten in past 7 days	
s7q1b13	Vegetables Number of days eaten in past 7 days	
s7q1b14	Oil/butter/shea Number of days eaten in past 7 days	
s7q1b15	Fruits Number of days eaten in past 7 days	
s7q1b16	Sugar/sweets Number of days eaten in past 7 days	
s7q1b17	Milk/dairy Number of days eaten in past 7 days	
s7q1b18	Condiments Number of days eaten in past 7 days	

**  only a few missing here and there... so ok to convert the missing to 0

RECODE
  s7q1b01 s7q1b02 s7q1b03 s7q1b04 s7q1b05 s7q1b06 s7q1b07 s7q1b08 s7q1b09 s7q1b10
  s7q1b11 s7q1b12 s7q1b13 s7q1b14 s7q1b15 s7q1b16 s7q1b17 s7q1b18  (SYSMIS=0)
  .
EXECUTE .


**  then make the groups

Compute starches = 
s7q1b01+
s7q1b02+
s7q1b03+
s7q1b04+
s7q1b05+
s7q1b06.
execute. 

compute pulses = 
s7q1b12.
execute.

Compute meat =
s7q1b07+
s7q1b08+
s7q1b09+
s7q1b10+
s7q1b11.
execute. 

compute veg = 
s7q1b13.
execute. 

compute fruits = 
s7q1b15.
execute. 

compute diary = 
s7q1b17.
execute. 

compute oil = 
s7q1b14.
execute. 

compute sugar = 
s7q1b16.
execute. 

**  then recode above 7 days to 7

RECODE
  starches pulses meat veg fruits diary oil sugar  (7 thru Highest=7)  .
EXECUTE .

**  create the score

compute FCS = (2 * starches) + (3*pulses)+ (4*meat) + veg + fruits + (4*diary) + (0.5*oil) + (0.5*sugar).
execute. 



*** create FCGs (a few different cut-offs...)

RECODE
  FCS
  (Lowest thru 21=1)  (21.5 thru 35=2)  (35.5 thru Highest=3)  INTO
  FCG.21.35 .
EXECUTE .


RECODE
  FCS
  (Lowest thru 28=1)  (28.5 thru 42=2)  (42.5 thru Highest=3)  INTO
  FCG.28.42 .
EXECUTE .

RECODE
  FCS
  (Lowest thru 28=1)  (28.5 thru 42=2)  (42.5 thru 52=3) (52.5 thru highest=4)  INTO
  FCG.28.42.52 .
EXECUTE .

*****************************************************************
** no fish calculations ***

compute meatnofish = 
s7q1b08+
s7q1b09+
s7q1b10+
s7q1b11.
execute. 

RECODE
  meatnofish (7 thru Highest=7)  .
EXECUTE .

compute FCSnofish = (2 * starches) + (3*pulses)+ (4*meatnofish) + veg + fruits + (4*diary) + (0.5*oil) + (0.5*sugar).
execute. 

RECODE
  FCSnofish
  (Lowest thru 21=1)  (21.5 thru 35=2)  (35.5 thru Highest=3)  INTO
  FCGnofish.21.35 .
EXECUTE .

RECODE
  FCSnofish
  (Lowest thru 28=1)  (28.5 thru 42=2)  (42.5 thru Highest=3)  INTO
  FCGnofish.28.42 .
EXECUTE .

RECODE
  FCS
  (Lowest thru 28=1)  (28.5 thru 42=2)  (42.5 thru 56 =3) (56.5 thru Highest=4)  INTO
  FCG.28.42fourgrps .
EXECUTE .



