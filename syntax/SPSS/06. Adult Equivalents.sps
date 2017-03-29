
********calculating the adult equivalent based on the the kcal requirements adult equivalent, 'patterns and trends in poverty in country a''********

***** convert based on age and sex*****

IF  (s1q5 = 0) Adult_eq=.255.
EXECUTE.

IF  ((s1q5<4)  & (s1q5 >0)) Adult_eq=.45.
EXECUTE.

IF  ((s1q5<7)  & (s1q5 >3)) Adult_eq=.62.
EXECUTE.

IF  ((s1q5<11)  & (s1q5 >6)) Adult_eq=.69.
EXECUTE.


IF  ((s1q5>10)  & (s1q5<15) & (sex=1)) Adult_eq=.86.
EXECUTE.
IF  ((s1q5>14)  & (s1q5<19) & (sex=1)) Adult_eq=1.03.
EXECUTE.
IF  ((s1q5>18)  & (s1q5<51) & (sex=1)) Adult_eq=1.
EXECUTE.
IF  ((s1q5>50) &   (sex=1)) Adult_eq=.79.
EXECUTE.

IF  ((s1q5>10)  & (s1q5<51) & (sex=2)) Adult_eq=.76.
EXECUTE.
IF  ((s1q5>50)  & (sex=2)) Adult_eq=.66.
EXECUTE.