* Reemplazar variables según corresponda.
* Cereales, raíces y tubérculos
* Si existen diferentes grupos utilizar SUM para totalizar.
COMPUTE FC_main_staple_days_1=sum(P050101,P050102).
EXECUTE.

* Leguminosas.
COMPUTE FC_pulses_days_1=P050103.
EXECUTE.

* Vegetales.
COMPUTE FC_vegetable_days_1=sum(P050104,P050105,P050106).
EXECUTE.

* Frutas.
COMPUTE FC_fruit_days_1=sum(P050107,P050108).
EXECUTE.

* Carnes (inc. pescado) y huevo.
COMPUTE FC_meat_days_1=sum(P050109,P050110,P050111,P050112).
EXECUTE.

* Lácteos.
COMPUTE FC_milk_dairies_days_1=P050113.
EXECUTE.

* Azúcar.
COMPUTE FC_sugar_days_1=P050115.
EXECUTE.

* Grasas aceite, etc.
COMPUTE FC_oil_days_1=P050114.
EXECUTE.

* Truncar sumas.
RECODE FC_main_staple_days_1 FC_pulses_days_1 FC_vegetable_days_1 FC_fruit_days_1 FC_meat_days_1
FC_milk_dairies_days_1 FC_sugar_days_1 FC_oil_days_1 (7 thru Highest=7).
EXECUTE.

COMPUTE FCS_1=sum((FC_main_staple_days_1*2), (FC_pulses_days_1*3), (FC_vegetable_days_1*1),
(FC_fruit_days_1*1), (FC_meat_days_1*4), (FC_milk_dairies_days_1*4), (FC_oil_days_1*0.5),
(FC_sugar_days_1*0.5)).
EXECUTE.

RECODE FCS_1 (Lowest thru 28.00=1) (28.1 thru 42=2) (42.1 thru Highest=3) INTO FC_group.
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

