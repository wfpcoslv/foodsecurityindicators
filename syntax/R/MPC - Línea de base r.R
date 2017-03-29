# IMPACTO DE TRANSFERENCIA DE EFECTIVO MULTIPROPÓSITO 
# EN LA SEGURIDAD ALIMENTARIA DE FAMILIAS AFECTADAS POR LA SEQUÍA, EN EL CORREDOR SECO.
# Línea de base
# Enero 2017 

# Cargar librerías
libs <- c("sjPlot", "sjmisc","psych","gmodels", "prettyR","tables","pastecs","car","plyr")
lapply(libs, require, character.only=T)

# Set working directory (Hait Office)
setwd("C:\\Users\\luis.penutt\\Google Drive\\PMA\\MPC\\Claudia") #debo cambiar el working directory. 
getwd()
dir()


## Leer base de datos
# Read from CSV
data <- read.csv(".\\COSLV-LBMPC.csv", header=T, sep=";")
# 1121/283 Original; procesada 1121/316
dim(data)



# Correr antes de seguir
attach(data)


# Aplicando filtro para el tipo de modalidad (ModNum)
# -- Efectivo condicionado = 1 (160/1121)
# -- Efectivo no condicionado = 3 (164/1121)
# -- MPC Condicionado = 2 (159/1121)
# -- MPC no condicionado = 4 (154/1121)
# -- Bono condicionado = 5 (157/1121)
# -- Bono no condicionado = 6 (164/1121)
# -- Grupo control = 7 (163/1121)

count(data$ModNum)
# Aplicando código
data <- data[data$ModNum=="6",]
dim(data)




# Consolidado de resultados
# PCA
# Resultados
pcag <- data.frame(data$pca)
sjt.frq(pcag, var.labels = c("Puntaje de Consumo de Alimentos"))


# DDS
# Results
DDS <- data.frame(data$DDS)
sjt.frq(DDS, var.labels = c("Puntaje de la Diversidad de la Dieta"))
## Average DDS
describe(data$DDS1)
summary(data$DDS1)
stat.desc(data$DDS1, basic = F)
head(data$DDS1, n=40) # Be sure numbers match average. 

# FES
# Final Results
#FES
FESG <- data.frame(data$FESG1)
sjt.frq(FESG, var.labels = c("Porcentaje de Gasto en Alimentos")) # CARI Categories.
# Average food expenditure share
describe(data$FES)
stat.desc(data$FES, basic = F)
summary(data$FES)



# CSI-A
# Final Results
FoodCSI <- data.frame(data$FoodCSI)
sjt.frq(FoodCSI, var.labels = c("Indice de Estrategias de Supervivencia (Alimentos) "))
#Final Results (HouseHold average)
stat.desc(data$ACSIF, basic = F)
summary(data$ACSIF)
describe(data$ACSIF)

# CSI-L
# Final results
## Tables by strategy
data$CSI2 <- recode(data$CSI,"1='Sin estrategias'; 2='Estres';3='Crisis';4='Emergencia'; 5='Sin Estrategias'")
CSI2 <- data.frame(data$CSI2)
sjt.frq(CSI2, var.labels = c("Indice de Estrategias de Superviviencia (Medios de vida)"))
# Final Results (average by household)
summary(data$HAveCSI)
describe(data$HAveCSI)
stat.desc(data$HAveCSI, basic = F)





#$##$# Desarrollo de indicadores #$##$# 

#- Sección III: SEGURIDAD ALIMENTARIA

### PCA-N 

## Recodificando valores perdidos a cero
data$Cc1[is.na(data$Cc1)] <-0 
data$Cc2[is.na(data$Cc2)] <-0 
data$Cc3[is.na(data$Cc3)] <-0  
data$Cc13[is.na(data$Cc13)] <-0  
data$CcA[is.na(data$CcA)] <-0   
data$CcB[is.na(data$CcB)] <-0  
data$CcD[is.na(data$CcD)] <-0  
data$Cc14[is.na(data$Cc14)] <-0  
data$Cc15[is.na(data$Cc15)] <-0  

print(data$Cc1) # How data looks like?
print(data$CcA) # How data looks like?


## Step 1 (GRUPOS PCA)
data$Ncertub <- mapply(sum, Cc1,Cc2, na.rm=T)
data$Npulses <- mapply(sum, Cc3, na.rm=T)
data$Nmilk<- mapply(sum, Cc13, na.rm=T)


# Probar datos
data$Nmilk # Leche
data$Npulses # Legumbres, nueces, y semillas secas
data$Ncertub # Cereales + Tubérculos
data$CcA # Carne, pescado y huevo. 
data$CcB # Vegetales.
data$CcD # Frutas.
data$Cc14 # Aceite, grasas y mantequilla. 
data$Cc15 # Azúcar y dulces. 



# Sumando grupos de alimentos
data$pca1 <- mapply(sum,(data$Ncertub*2),(data$Npulses*3),(data$Nmilk*4),(data$CcA*4),(data$CcB*1),(data$CcD*1),(data$Cc14*0.5),(data$Cc15*0.5))
# Test
data$pca1
# Recodificando las categorías
# usando pca1
data$pca<-recode(data$pca1,"lo:21='Pobre';21.5:35='Al limite';35.5:hi='Aceptable'") # Revisar categorías de clasificación.
# Test
data$pca

#_________________________________________________
# Suma sin incluir variable frijol
data$pca2 <- mapply(sum,(data$Ncertub*2),(data$Nmilk*4),(data$CcA*4),(data$CcB*1),(data$CcD*1),(data$Cc14*0.5),(data$Cc15*0.5))
# Test
data$pca2
# usando pca2 (sin frijol)
data$pca<-recode(data$pca2,"lo:21='Pobre';21.5:35='Al limite';35.5:hi='Aceptable'") # Revisar categorías de clasificación.
# Test
data$pca



# Resultados (Tabla)
pcag <- data.frame(data$pca)
sjt.frq(pcag, var.labels = c("Puntaje de Consumo de Alimentos"))


## PCA promedio por familia
# pc1
describe(data$pca1)
describe(data$pca)
summary(data$pca1)
stat.desc(data$pca1, basic = F)

# pc2
describe(data$pca2)
describe(data$pca)
summary(data$pca2)
stat.desc(data$pca2, basic = F)


# PROMEDIOS POR GRUPO DE ALIMENTOS
describe(data$Ncertub) # Cereales + Tubérculos
describe(data$Cc1) # Cereales y granos 
describe(data$Cc2) # Raíces y tubérculos 


describe(data$Npulses) # Legumbres, nueces, y semillas secas
describe(data$Nmilk)  # Leche

describe(data$CcA)  # Carne, pescado y huevo 
describe(data$Cc9)  # carne
describe(data$Cc10) # Visceras
describe(data$Cc11) # Pescado/Mariscos
describe(data$Cc12) # Huevos

describe(data$CcB) # Vegetales
describe(data$Cc4) #	Días de consumo de - Vegetales anaranjados
describe(data$Cc5) #	Días de consumo de - Vegetales de hojas verdes
describe(data$Cc6) # Días de consumo de - Otros vegetales

describe(data$CcD) # Frutas
describe(data$Cc7) # Días de consumo de - Frutas de color naranja
describe(data$Cc8) #	Días de consumo de - Otras frutas

describe(data$Cc14)#	Días de consumo de - Aceite/ grasas/ mantequilla
describe(data$Cc15)# Días de consumo de - Azúcar o dulce
describe(data$Cc16)#	Días de consumo de - Condimentos/ especias/ bebidas


## Summary for many vars
vars <- cbind(data$Nmilk, data$Npulses, data$Ncertub, data$CcA, data$Cc9, data$Cc10, data$Cc11, data$Cc12, data$CcB, data$CcD, data$Cc14, data$Cc15)
colnames(vars) <- c("Leche", "Legumbres","Cereales+tuberculos", "CarnePesHuevo", "Carne", "viceras","Pescado", "Huevos", "Vegetales", "Frutas", "Aceite", "Azucar")
summary(vars)
describe.matrix(vars) #library(psych)
stat.desc(vars, basic = F)


# Convertir a CARI
# usando pca2 (sin frijol)
data$pcari<-recode(data$pca2,"lo:21='Poor';21.5:35='Borderline';35.5:hi='Acceptable'") # Revisar categorías de clasificación.
# Test
data$pcari
# Resultados
pcagcari <- data.frame(data$pcari)
sjt.frq(pcagcari, var.labels = c("Puntaje de Consumo de Alimentos"))



## DURACIÓN DE LOS ALIMENTOS
df9 <- cbind.data.frame(Ck1,Ck2,Ck3,Ck4,Ck5,Ck6,Ck7,Ck8,Ck9,Ck10,Ck11,Ck12,Ck13,Ck14,Ck15,Ck16)
colnames(df9) <- c("Cereales/Granos","Raices/Tuber","Legumbres","Lacteos","Carne", "viceras","Pescado", "Huevos", "VegeAnaranjados","VegHojasverdes","OtrosVeg","FrutasAnaranjadas", "OtrasFrutas", "Aceite", "Azucar", "Condimentos")
summary(df9)
stat.desc(df9)
# Se debe elaborar más sintáxis sobre este análisis.





### DDS (Diet Diversity Score) ###
##################################

# Step 1: Food groups to DDS variables
data$DDScertub <- mapply(sum, Cc1,Cc2, na.rm=T)
data$DDSpulses <- mapply(sum, Cc3, na.rm=T)
data$DDSveg <- mapply(sum, Cc4, Cc5, Cc6, na.rm=T)
data$DDSfruit <- mapply(sum, Cc7, Cc8, na.rm=T)
data$DDSmeatfish <- mapply(sum, Cc9, Cc10, Cc11, Cc12, na.rm=T)
data$DDSmilk<- mapply(sum, Cc13, na.rm=T)
data$DDSoil <- mapply(sum, Cc14, na.rm=T)
# Test
names(data) # New vars are included?
print(data$DDScertub) # How data looks like?


# Recode zero to missing values
data$DDScertub[data$DDScertub==0] = NA 
data$DDSpulses[data$DDSpulses==0] = NA
data$DDSveg[data$DDSveg==0] = NA 
data$DDSfruit[data$DDSfruit==0] = NA 
data$DDSmeatfish[data$DDSmeatfish==0] = NA 
data$DDSmilk[data$DDSmilk==0] = NA 
data$DDSoil[data$DDSoil==0] = NA 
# Test
print(data$DDScertub) # How data looks like?


# Step 2: Recode to highest 1
data$DDScertub1 <- recode(data$DDScertub, "lo:hi=1")
data$DDSpulses1<- recode(data$DDSpulses, "lo:hi=1")
data$DDSveg1 <- recode(data$DDSveg, "lo:hi=1")
data$DDSfruit1 <- recode(data$DDSfruit, "lo:hi=1")
data$DDSmeatfish1 <- recode(data$DDSmeatfish, "lo:hi=1")
data$DDSmilk1 <- recode(data$DDSmilk, "lo:hi=1")
data$DDSoil1 <- recode(data$DDSoil, "lo:hi=1")
# Test
print(data$DDScertub1) # How data looks like?

# Step 3: Compute DDS
data$DDS1 <- mapply(sum,data$DDScertub1,data$DDSpulses1,data$DDSveg1,data$DDSfruit1,data$DDSmeatfish1,data$DDSmilk1,data$DDSoil1, na.rm=T)
data$DDS <- recode(data$DDS1,"lo:4.5='DDS bajo(<4.5)';4.6:6='DDS medio(4.6-6)';7:hi='DDS alto(>6)'")
data$DDS

# Results
DDS <- data.frame(data$DDS)
sjt.frq(DDS, var.labels = c("Puntaje de la Diversidad de la Dieta"))

## Average DDS
describe(data$DDS1)
summary(data$DDS1)
stat.desc(data$DDS1, basic = F)
head(data$DDS1, n=40) # Be sure numbers match average. 









### Food Basket Value ###
##################################
# Food Expenditure Share (FES)


# Verificando variables a usar
## Summary for many vars
vars <- cbind(Ch1,Ch2,Ch3,Ch13,Ch4,Ch5,Ch6,Ch7,Ch8,Ch9,Ch10,Ch11,Ch12,Ch14,Ch15,Ch16,Cj1,Cj2,Cj3,Cj4,Cj5,Cj6,Cj7,Cj8,Cj9,Cj10,Cj11,Cj12,Cj13,Cj14,Cj15,Cj16)
summary(vars)
describe.matrix(vars) #library(psych)
stat.desc(vars, basic = F)


# Step 1: Seven Days Expenditure (Food Items)
data$FoodMesa <- mapply(sum, Ch1,Ch2,Ch3,Ch4,Ch5,Ch6,Ch7,Ch8,Ch9,Ch10,Ch11,Ch12,Ch13,Ch14,Ch15,Ch16,Cj1,Cj2,Cj3,Cj4,Cj5,Cj6,Cj7,Cj8,Cj9,Cj10,Cj11,Cj12,Cj13,Cj14,Cj15,Cj16,na.rm=T)

## Multiply by 4 (Montly basis)
data$FoodMes1 <- data$FoodMesa*4
### Test results (for outliers)
View(as.data.frame(data$FoodMes1))
hist(data$FoodMes1, xlab="title",main = "graph name",col="cornflowerblue", breaks=20)
boxplot(data$FoodMes1)
summary(data$FoodMes1)
describe(data$FoodMes1)
fix(data)


# Step 2: Montly Expenditure (None food items)
data$EXPMes2 <- mapply(sum,data$D3E1,data$D3E2,data$D3E3,data$D3E4,data$D3E5,data$D3E6,data$D3E7,data$D3E8, na.rm=T)
### Test results (for outliers)
View(as.data.frame(data$EXPMes2))
hist(data$EXPMes2, xlab="title",main = "graph name",col="cornflowerblue", breaks=20)
summary(data$EXPMes2)


# Step 3: Six Months Expenditure (None food items)
data$EXPMes3a <- mapply(sum,data$D4E1,data$D4E2,data$D4E3,data$D4E4,data$D4E5,data$D4E6,data$D4E7,data$D4E8,na.rm=T)
## Devide by 6 (Montly basis)
data$EXPMes3 <- data$EXPMes3a/6
### Test results (for outliers)
data$EXPMes3
hist(data$EXPMes3, xlab="title",main = "graph name",col="cornflowerblue", breaks=8)
boxplot(data$EXPMes3)
summary(data$EXPMes3)
describe(data$EXPMes3)


# Step 4: FES
data$FESa <- mapply(sum, data$FoodMes1,data$EXPMes2,data$EXPMes3)
data$FES <- (data$FoodMes1/data$FESa)

# Test
hist(data$FES, xlab="title",main = "graph name",col="cornflowerblue", breaks=12)
data$FES # Be sure data match the suggested average. 
summary(data$FES)

# Step 5: Applying FES categories
# For Baseline
data$FES <- round(data$FES, digits=2) # Round to 2 digits max
data$FESG1 <- recode(data$FES,"lo:0.49='Seguridad Alimentaria';0.50:0.64='Inseguridad Marginal';0.65:0.74='Inseguridad Moderada';0.75:hi='Inseguridad Severa'")

# For Endline
data2$FES <- round(data2$FES, digits=2) # Round to 2 digits max
data2$FESG1 <- recode(data2$FES,"lo:0.49='Inseguridad Severa';0.50:0.64='Inseguridad Moderada';0.65:0.74='Inseguridad Marginal';0.75:hi='Seguridad Alimentaria'")

# Final Results
#FES
FESG <- data.frame(data$FESG1)
sjt.frq(FESG, var.labels = c("Porcentaje de Gasto en Alimentos")) # CARI Categories.
# Average food expenditure share
describe(data$FES)
stat.desc(data$FES, basic = F)
summary(data$FES)




### Coping Strategy Index ###
##################################

## Food Coping Strategy Index

# Step 1: Adding variables
data$FCSI <- mapply(sum,data$E1A,data$E1B,data$E1D,data$E1C,data$E1E,data$E1F,na.rm=T)
### Test results (for outliers)
data$FCSI
hist(data$FCSI, xlab="title",main = "graph name",col="cornflowerblue", breaks=12)
summary(data$FCSI)

# Step 2: Adding categories
data$FoodCSI <- recode(data$FCSI,"lo:23='Bajo';23.1:46='Medio';46.1:hi='Alto'")

# Final Results
FoodCSI <- data.frame(data$FoodCSI)
sjt.frq(FoodCSI, var.labels = c("Indice de Estrategias de Supervivencia (Alimentos) "))


## Food Coping Strategy Index Household Average
# Weighing variables
data$ACSIF <- mapply(sum,(data$E1A*1),(data$E1B*1),(data$E1C*2),(data$E1D*1),(data$E1E*3),na.rm=T)# ACSIF = Average CSI Food
# Test
View(data.frame(data$ACSIF)) # How data looks like? whole numbers only. 

#Final Results (averages)
stat.desc(data$ACSIF, basic = F)
summary(data$ACSIF)
describe(data$ACSIF)





#######

## Livelihood Coping Strategy Index
# Step 1: Recode Stress Strategies (EE1 was removed, it had not equal on RB questionaire)
data$StressCSI <- ifelse(data$EE2<4|data$EE3<4|data$EE4<4|data$EE5<4|data$EE6<4,2,1)
## Test results
data$StressCSI
hist(data$StressCSI, xlab="title",main = "graph name",col="cornflowerblue", breaks=12)

# Step 2: Recode Crysis Strategies
data$CrysisCSI <- ifelse(data$EC1<4|data$EC2<4|data$EC3<4|data$EC4<4|data$EC5<4,3,1)
## Test results
data$CrysisCSI
hist(data$CrysisCSI, xlab="title",main = "graph name",col="cornflowerblue", breaks=12)

# Step 3: Recode Emergency Strategies
data$EmergencyCSI <- ifelse(data$EG1<4|data$EG3<4|data$EG4<4,4,1)
## Test results
data$EmergencyCSI
hist(data$EmergencyCSI, xlab="title",main = "graph name",col="cornflowerblue", breaks=12)

##### Step 4 (Optional): Recode Other Strategies
data$OtherCSI <- ifelse(data$OE1<4|data$OE2<4,5,1)
## Test results
data$OtherCSI
hist(data$OtherCSI, xlab="title",main = "graph name",col="cornflowerblue", breaks=12)


# Step 5: Recode for classification
data$CSI <- data.frame(data$StressCSI,data$CrysisCSI,data$EmergencyCSI)
data$CSI <- apply(data$CSI,1,max)
# Test results
test <- data.frame(data$StressCSI,data$CrysisCSI,data$EmergencyCSI,data$CSI)
head(test, n=15)
sjt.frq(test)


# Final results
## Tables by strategy
data$CSI2 <- recode(data$CSI,"1='Sin estrategias'; 2='Estres';3='Crisis';4='Emergencia'; 5='Sin Estrategias'")
CSI2 <- data.frame(data$CSI2)
sjt.frq(CSI2, var.labels = c("Indice de Estrategias de Superviviencia (Medios de vida)"))




## I am not sure about what this ones really mean. 
sjt.frq(data$StressCSI, var.labels = c("Estrategias de Estrés"), value.labels = c("El hogar no ha utilizado estrategias","Estrategias de estrés"))
sjt.frq(data$CrysisCSI,var.labels = c("Estrategias de Crisis"), value.labels = c("El hogar no ha utilizado estrategias","Estrategias de crisis"))
sjt.frq(data$EmergencyCSI, var.labels = c("Estrategias de Emergencia"), value.labels = c("El hogar no ha utilizado estrategias","Estrategias de emergencia"))


## Tables by strategy detail
### Stress Strategies
str1<- data.frame(data$EE1,data$EE2,data$EE3,data$EE4,data$EE5,data$EE6)
df01 <- c("Depender de la ayuda de familiares o amigos","Comprar a crédito o prestarse alimentos","Pedir prestado dinero","Gastar ahorros","Vender animales menores, si no es su fuente habitual de ingresos","Vender activos domésticos") 
sjt.frq(data.frame(sapply(str1, factor, levels=c(1,2,3,4),labels=c("Sí, frecuentemente","Sí, ocasionalmente","No, porque agotó los recursos para realizarla","No la he aplicado en lo absoluto"))),variableLabels = df01)

### Crysis Strategies
str2<- data.frame(data$EC1,data$EC2,data$EC3,data$EC4,data$EC5)
df02 <- c("Sacar a los niños de la escuela","Disminuir los gastos en salud y educación","Vender activos productivos", "Consumir las  reservas de semillas que tenían para la próxima siembra","Disminuir los gastos para los insumos de agricultura y/o ganado") 
sjt.frq(data.frame(sapply(str2, factor, levels=c(1,2,3,4),labels=c("Sí, frecuentemente","Sí, ocasionalmente","No, porque agotó los recursos para realizarla","No la he aplicado en lo absoluto"))),variableLabels = df02)

### Emergency Strategies
str3<- data.frame(data$EG1,data$EG2,data$EG3,data$EG4)
df03 <- c("Pedir Limosna","Abandono del hogar de todos los miebros familiares","Vender los animales reproductores hembras","Vender la tierra") 
sjt.frq(data.frame(sapply(str3, factor, levels=c(1,2,3,4),labels=c("Sí, frecuentemente","Sí, ocasionalmente","No, porque agotó los recursos para realizarla","No la he aplicado en lo absoluto"))),variableLabels = df03)



### Livelihoods Coping Strategy Index (average by household)
data$EE1a <- ifelse(data$EE1<4,1,0)
data$EE2b <- ifelse(data$EE2<4,1,0)
data$EE3c <- ifelse(data$EE3<4,1,0)
data$EE6d <- ifelse(data$EE6<4,1,0)

data$EC2a <- ifelse(data$EC2<4,1,0)
data$EC3b <- ifelse(data$EC3<4,1,0)
data$EC4d <- ifelse(data$EC4<4,1,0)

data$EG1a <- ifelse(data$EG1<4,1,0)
data$EG3b <- ifelse(data$EG3<4,1,0)
data$EG4c <- ifelse(data$EG4<4,1,0)

data$OE1a <- ifelse(data$OE1<4,1,0)
data$OE2b <- ifelse(data$OE2<4,1,0)
data$OE3c <- ifelse(data$OE3<4,1,0)

# Weighing variables
data$HAveCSI <- mapply(sum,(data$EE1a*2),(data$EE2b*2),(data$EE3c*2),(data$EE6d*2),(data$EC2a*3),(data$EC3b*3),(data$EC4d*3),(data$EG1a*4),(data$EG3b*4),(data$EG4c*3),(data$OE1a*1),(data$OE2b*1),(data$OE3c*1),na.rm=T)# HAveCSI = Household Average CSI
# Test
View(data.frame(data$HAveCSI)) # How data looks like? whole numbers only. 

# Final Results (average by household)
summary(data$HAveCSI)
describe(data$HAveCSI)
stat.desc(data$HAveCSI, basic = F)




#$#$#$#$#$%%%%%%$#$#$#$#$#$#$#
# Save the new dataSet with new variables included. 
# Export the data set into csv
write.csv (data, ".\\COSLV-LBMPC.csv")
dim(data)
