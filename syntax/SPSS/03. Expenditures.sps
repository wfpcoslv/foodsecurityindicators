s6q0a	Expenditure in past month on maize, millet (A)
s6q0b	Expenditure in past month on cassava, gari (B)
s6q0c	Expenditure in past month on Other root and tubers (C)
s6q0d	Expenditure in past month on plantain (D)
s6q0e	Expenditure in past month on wheat flour and other grains (E
s6q0f	Expenditure in past month on rice (F)
s6q0g	Expenditure in past month on fresh vetables and fruits (G)
s6q0h	Expenditure in past month on fish (H)
s6q0i	Expenditure in past month on meat (I)
s6q0j	Expenditure in past month on oil/butter (J)
s6q0k	Expenditure in past month on alcohol and tobacco (K)
s6q0l	Expenditure in past month on meals outside home (L)
s6q0m	Expenditure in past month on communication (M)
s6q0n	Expenditure in past month on soap/detergent (N)
s6q0o	Expenditure in past month on transport (O)
s6q1a	Expenditure in past 6 months on farming equipment (A)
s6q1b	Expenditure in past 6 months on hiring labour (B)
s6q1c	Expenditure in past 6 months on health/medical (C)
s6q1d	Expenditure in past 6 months on education (D)
s6q1e	Expenditure in past 6 months on clothing (E)
s6q1f	Expenditure in past 6 months on vetenary (F)
s6q1h	Expenditure in past 6 months on social events (H)
s6q1k	Expenditure in past 6 months on housing (K)
s6q1l	Expenditure in past 6 months on utilities (L)
s6q1m	Expenditure in past 6 months on gifts (M)
s6q1n	Expenditure in past 6 months on business inputs (N)
s6q1o	Expenditure in past 6 months on other - high valued (O)

****************************************************************************************************

Compute TotalExp =s6q0a+
s6q0b+
s6q0c+
s6q0d+
s6q0e+
s6q0f+
s6q0g+
s6q0h+
s6q0i+
s6q0j+
s6q0k+
s6q0l+
s6q0m+
s6q0n+
s6q0o+
((s6q1a+
s6q1b+
s6q1c+
s6q1d+
s6q1e+
s6q1f+
s6q1h+
s6q1k+
s6q1l+
s6q1m+
s6q1n+
s6q1o)/6).
execute. 

Compute ExpFood = 
s6q0a+
s6q0b+
s6q0c+
s6q0d+
s6q0e+
s6q0f+
s6q0g+
s6q0h+
s6q0i+
s6q0j+
s6q0l.
compute. 

compute PerExpFood = ExpFood/TotalExp.
execute.  

**********************************************************************************


compute per.0A = s6q0a/TotalExp.
compute per.0B = s6q0b/TotalExp.
compute per.0C =s6q0c/TotalExp.
compute per.0D = s6q0d/TotalExp.
compute per.0E = s6q0e/TotalExp.
compute per.0F =s6q0f/TotalExp.
compute per.0G = s6q0g/TotalExp.
compute per.0H = s6q0h/TotalExp.
compute per.0I =s6q0i/TotalExp.
compute per.0J = s6q0j/TotalExp.
compute per.0K = s6q0k/TotalExp.
compute per.0L =s6q0l/TotalExp.
compute per.0M = s6q0m/TotalExp.
compute per.0N = s6q0n/TotalExp.
compute per.0O =s6q0o/TotalExp.
execute. 
compute per.1A = (s6q1a/6)/TotalExp.
compute per.1B = (s6q1b/6)/TotalExp.
compute per.1C =(s6q1c/6)/TotalExp.
compute per.1D = (s6q1d/6)/TotalExp.
compute per.1E = (s6q1e/6)/TotalExp.
compute per.1F =(s6q1f/6)/TotalExp.
compute per.1H = (s6q1h/6)/TotalExp.
compute per.1K = (s6q1k/6)/TotalExp.
compute per.1L =(s6q1l/6)/TotalExp.
compute per.1M = (s6q1m/6)/TotalExp.
compute per.1N = (s6q1n/6)/TotalExp.
compute per.1O =(s6q1o/6)/TotalExp.
execute.




