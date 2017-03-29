**Annex B: Food consumption score –annotated syntax
**********FOOD CONSUMPTION SCORE ------Variable names:
Cereal_Freq7d Consumption past 7 days (Cereal and grain)
Tuber_Freq7d Consumption past 7 days (Roots and tubers)
Legumbre1_Freq7d Consumption past 7 days (Legumes/nuts)
VegNaranja_Freq7d Consumption past 7 days (Orange vegetables)
VegVerde_Freq7d Consumption past 7 days (Green leafy vegetables)
VegOtro_Freq7d Consumption past 7 days (Other vegetables)
FrutaNaranja_Freq7d Consumption past 7 days (Orange fruits)
FrutaOtra_Freq7d Consumption past 7 days (Other fruits)
Carnes_Freq7d Consumption past 7 days (Meat)
Pescado_Freq7d Consumption past 7 days (Fish)
Huevos_Freq7d Consumption past 7 days (Egg)
Visceras_Freq7d Consumption past 7 days (liver, kidney other meats)
Lactosa_Freq7d Consumption past 7 days (Milk and other dairy products)
Aceite_Freq7d Consumption past 7 days (oil, fat butter)
Azucar_Freq7d Consumption past 7 days (sugar or sweet)
Condimentos_Freq7d Consumption past 7 days (condiments, spices)
************************Food Consumption Score (FCS_1) sum days*****************************************.

COMPUTE FC_main_staple_days_1=sum(P050101,P050102).
EXECUTE.

COMPUTE FC_pulses_days_1=P050103.
EXECUTE.

COMPUTE FC_vegetable_days_1=sum(P050104,P050105,P050106).
EXECUTE.

COMPUTE FC_fruit_days_1=sum(P050107,P050108).
EXECUTE.

COMPUTE FC_meat_days_1=sum(P050109,P050110,P050111,P050112).
EXECUTE.

COMPUTE FC_milk_dairies_days_1=P050113.
EXECUTE.

COMPUTE FC_sugar_days_1=P050115.
EXECUTE.

COMPUTE FC_oil_days_1=P050114.
EXECUTE.

RECODE FC_main_staple_days_1 FC_pulses_days_1 FC_vegetable_days_1 FC_fruit_days_1 FC_meat_days_1
FC_milk_dairies_days_1 FC_sugar_days_1 FC_oil_days_1 (7 thru Highest=7).
EXECUTE.

COMPUTE FCS_1=sum((FC_main_staple_days_1*2), (FC_pulses_days_1*3), (FC_vegetable_days_1*1),
(FC_fruit_days_1*1), (FC_meat_days_1*4), (FC_milk_dairies_days_1*4), (FC_oil_days_1*0.5),
(FC_sugar_days_1*0.5)).
EXECUTE.

RECODE FCS_1 (Lowest thru 21.00=1) (21.5 thru 35=2) (35.5 thru Highest=3) INTO FC_group.
EXECUTE.

****************************Recode the food consumption groups into the 4-point scale. ***************************************
*These categories recoded in reverse order from FCS: acceptable (=1), borderline (=3) and poor (=4) .

RECODE FC_group (1=4) (2=3) (3=1) INTO FCS_4pt. 
VARIABLE LABELS FCS_4pt '4pt FCG'. 
EXECUTE.

FREQUENCIES VARIABLES=FCS_4pt 
/ORDER=ANALYSIS. 

* Define Variable Properties. *FCS_4pt.

VALUE LABELS FCS_4pt 
 1.00 'Aceptable' 
 3.00 'Moderado'
 4.00 'Pobre'. 
EXECUTE.

