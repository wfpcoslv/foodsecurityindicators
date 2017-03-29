**Annex D: Food expenditure share–annotated syntax.
*********Food expenditure share:.
********------Variable names:.
ExpCe1     3.01a Cash expenditures on Cereals (maize, rice, sorghum, wheat, bread)
ExpCe2      3.01b Credit expenditures on Cereals (maize, rice, sorghum, wheat, bread)
ExpCe3        3.01c Estimated value of non-purchased Cereals
ExpTu1      3.02a Cash expenditures on Tubers (sweet potatoes, cassava)
ExpTu2      3.02b Credit expenditures on Tubers (sweet potatoes, cassava)
ExpTu3        3.02c Estimated value of non-purchased Tubers
ExpLe1      3.03a Cash expenditures on Pulses (beans, peas, groundnuts)
ExpLe2      3.03b Credit expenditures on Pulses (beans, peas, groundnuts)
ExpLe3        3.03c Estimated value of non-purchased Pulses
ExpVF1      3.04a Cash expenditures on Fruits & vegetables
ExpVF2     3.04b Credit expenditures on Fruits & vegetables
ExpVF3       3.04c Estimated value of non-purchased Fruits and vegetables
ExpCa1     3.05a Cash expenditures on Fish/Meat/Eggs/poultry
ExpCa2     3.05b Credit expenditures on Fish/Meat/Eggs/poultry
ExpCa3     3.05c Estimated value of non-purchased Fish/meat/eggs/poultry
ExpAc1     3.06a Cash expenditures on Oil, fat, butter
ExpAc2     3.06b Credit expenditures on Oil, fat, butter
ExpAc3       3.06c Estimated value of non-purchased oil, fat, butter
ExpLa1     3.07a Cash expenditures on Milk, cheese, yogurt
ExpLa2     3.07b Credit expenditures on Milk, cheese, yogurt
ExpLa3       3.07c Estimated value of non-purchased Milk, cheese, yogurt
ExpO1    3.08a Cash expenditures on Sugar/Salt
ExpO2     3.08b Credit expenditures on Sugar/Salt
ExpO3      3.08c Estimated value of non-purchased sugar/salt
ExpCo1      3.09a Cash expenditures on Food outside home
ExpCo2       3.09b. Credit expenditures on Food outside home
ExpCo3      3.09c Estimated value of non-purchased Tea/coffee

**1 month non-food expenditures.
ExpTabacco_GastoMes   3.05.10 Alcohol/Palma wine & Tobacco
ExpJabon_GastoMes   3.05.11 Soap & HH items
ExpTransport_GastoMes   3.05.12 Transport
ExpCombustible_GastoMes   3.05.13 Fuel (wood, paraffin, etc.)
ExpAgua_GastoMes   3.05.14 Water
ExpLuz_GastoMes   3.05.15 Electricity/Lighting
ExpComun_GastoMes   3.05.16 communication

**6 month non-food expenditures.
ExpMedicos_6meses      3.07.17 Medical expenses, health care
ExpRopa_6meses     3.07.18 Clothing, shoes
ExpEducacion_6meses      3.07.19 Education, school fees, uniform, etc
ExpDeudas_6meses     3.07.20 Debt repayment
ExpCelebracion_6meses     3.07.21 Celebrations / social events
ExpInsumosAgri_6meses     3.07.22 Agricultural inputs
ExpAhorros_6meses     3.07.23 Ahorros
ExpConstruccion_6meses     3.07.24 Constructions/house repairs

*COMPUTE food_monthly=sum(3.01a, 3.01b, 3.01c, 3.02a, 3.02b, 3.02c, 3.03a, 3.03b, 3.03c, 3.04a, 3.04b, 3.04c, 3.05b, 3.05c, 3.06a, 3.06b, 3.06c, 3.07a, 3.07b, 3.07c, 3.08a, 3.08b, 3.08c, 3.09a, 3.09b, 3.09c).
*VARIABLE LABELS food_monthly 'HH food expenditure over month'.
*EXECUTE.

COMPUTE food_monthly=sum(ExpCe1, ExpCe2, ExpCe3, ExpTu1, ExpTu2, ExpTu3, ExpLe1, ExpLe2, ExpLe3, ExpVF1, ExpVF2, ExpVF3, ExpCa1, ExpCa2, ExpCa3, ExpAc1, ExpAc2, ExpAc3, ExpLa1, ExpLa2, ExpLa3, ExpO1, ExpO2, ExpO3, ExpCo1, ExpCo2, ExpCo3).
VARIABLE LABELS food_monthly 'HH food expenditure over month'.
EXECUTE.

COMPUTE nonfood1_monthly=sum(ExpTabacco_GastoMes, ExpJabon_GastoMes, ExpTransport_GastoMes, ExpCombustible_GastoMes,ExpAgua_GastoMes, ExpLuz_GastoMes, ExpComun_GastoMes).
VARIABLE LABELS nonfood1_monthly 'HH nonfood short term expenditures over month, '.
EXECUTE.

COMPUTE nonfood2_monthly=sum(ExpMedicos_6meses, ExpRopa_6meses, ExpEducacion_6meses, ExpDeudas_6meses, ExpCelebracion_6meses, ExpInsumosAgri_6meses, ExpAhorros_6meses,ExpConstruccion_6meses)/6.
VARIABLE LABELS nonfood2_monthly 'HH nonfood short term expenditures over month, '.
EXECUTE.

COMPUTE FoodExp_share= food_monthly/sum(food_monthly, nonfood1_monthly, nonfood2_monthly).
*Compute Ingresos = sum( food_monthly,nonfood1_monthly).
*
RECODE FoodExp_share (Lowest thru 0.49=1) (0.50 thru 0.64=2) (0.65 thru 0.74=3) (0.75 thru Highest=4)
     INTO Foodexp_4pt.
VARIABLE LABELS Foodexp_4pt 'food expenditure share categories'.
EXECUTE.