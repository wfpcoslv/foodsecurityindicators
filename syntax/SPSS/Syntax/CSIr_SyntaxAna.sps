
*stress_coping strategies
*do if (Q.1_3.01= 1 or Q.4_3.01=1 or Q.5_3.01= 1 or Q.10_3.01=1). 
do if (CPAsset1=1 or CPAsset2=1 or CPAsset3=1 or CPAsset4=1 or CPAsset5=1 or CPAsset6=1).
compute stress_coping = 1. 
ELSE.
compute stress_coping = 0. 
end if. 
EXECUTE.


*crisis strategies

*do if (Q.2_3.01= 1 or Q.3_3.01=1 or Q.7_3.01=1). 
do if (CPAsset7=1 or CPAsset8=1 or CPAsset9=1 or CPAsset10=1 or CPAsset11=1).
compute crisiscoping = 1. 
ELSE.
compute crisiscoping = 0. 
end if. 
EXECUTE.


*emergency strategies

*do if (Q.6_3.01= 1 or Q.8_3.01=1 or Q.9_3.01=1). 
do if (CPAsset12=1 or CPAsset13=1 or CPAsset14=1 or CPAsset15=1).
compute emergencycoping = 1. 
ELSE. 
compute emergencycoping = 0.
end if. 
EXECUTE.


* Define Variable Properties.

VARIABLE LABELS stress_coping 'did HH engage in stress coping strategies?'. 
VARIABLE LABELS crisiscoping 'did HH engage in crisis coping strategies?'. 
VARIABLE LABELS emergencycoping 'did HH engage in emergency coping strategies?'. 
EXECUTE.

RECODE stress_coping (0=0) (1=2). 
EXECUTE.

RECODE crisiscoping (0=0) (1=3). 
EXECUTE.

RECODE emergencycoping (0=0) (1=4). 
EXECUTE.

COMPUTE CSIr2=MAX(stress_coping,crisiscoping,emergencycoping). 
EXECUTE. 
RECODE CSIr2 (0=1).
EXECUTE.

Value labels CSIr2 
1 'HH not adopting coping strategies' 
2 'Stress coping strategies ' 
3 'crisis coping strategies ' 
4 'emergencies coping strategies'.
EXECUTE.

Variable Labels CSIr2 'summary of asset depletion'.
