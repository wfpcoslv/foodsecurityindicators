**Annex E: Food security console–annotated syntaxx
*********Food expenditure share:
********------Variable names:
Max_coping_behaviour 4 point scale indicator measuring asset depletion (constructed in Annex C)
Foodexp_4pt 4 point scale indicator measuring economic vulnerability (constructed in Annex D)
FCS_4pts 4 point scale indicator measuring food consumption (constructed in Annex B)

COMPUTE Mean_CC1=MEAN(CSIr2, Foodexp_4pt). 
EXECUTE.

COMPUTE Mean_FC1=MEAN(FCS_4pt, Mean_CC1). 
EXECUTE.

COMPUTE CARI_Final1=RND(Mean_FC1). 
EXECUTE.

* Define Variable Properties. 
*FS_final.

VALUE LABELS CARI_Final1
1.00 'food secure' 
2.00 'Marginally food secure ' 
3.00 'moderately food insecure' 
4.00 'severely food insecure'. 
EXECUTE.