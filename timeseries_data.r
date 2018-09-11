#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#DATA PROCESING DENUNCIAS SECRETARIADO DE ENE 2015 HASTA JULIO 2018 -V1-
#ROSA MARTHA PERALTA BLANCO

#~~~~~~~~~~~~~~~~~~~~~~~~ESTRUCTURA DE INPUT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#year          AÑO DE DENUNCIA
#clv           CLAVE DE ESTADO
#location_code CLAVE DE MUNICIPIO
#municipio     NOMBRE DE MUNICIPIO
#good_legal    BUEN JURIDICO AFECTADO
#typess        TIPO DE DELITO
#subtype       SUBTIPO DE DELITO
#modality      MODALIDAD DEL DELITO
#cfinal        CLAVE DEL DELITO
#tipoz         TIPO DE MUNICIPIO: URBANO-CENTRAL, URBANO-EXTERIOR, RURAL - "URBANIDAD"
#              (Delimitación de las zonas metropolitanas de México 2010 http://www.conapo.gob.mx/es/CONAPO/Zonas_metropolitanas_2010)
#ene-dic       CANTIDAD DE DENUNCIAS CONSIDERADAS POR MES

#~~~~~~~~~~~~~~~~~~~~~~~NOTAS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#DESPUES DEL SCRIPT SE PROCESAN DATOS
#(1)SI limsup Y liminf SON "NA" SE LES ASIGNA EL VALOR de mean
#(2)EN EL CASO LOS "NA" DE AGOSTO-DICIEMBRE DE 2018 SE REMPLAZAN POR VALORES VACIOS
#(3)ELIMINAR LOS CAMPOS DE CONCATENACION (conca e id) - SE DEJAN PARA COMPROBACION
#(4)CALCULAR TOTAL DE DENUNCIAS DE ENERO A DICIEMBRE (A INTEGRAR PROCESO EN V2)
#(5)PENDIENTE SUSTITUIR VALORES NEGATIVOS

#~~~~~~~~~~~~~~~~~~~~~~~RESUMEN~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#EL CODIGO CALCULA EL PROMEDIO Y LOS LIMITES DE "NORMALIDAD" PARA SERIES DE TIEMPO DE DELITOS ANUALES
#LOS DATOS SE AGRUPAN POR AÑO,MUNICIPIO,TIPO DE DELITO Y "URBANIDAD"
#UNA VEZ OBTENIDOS SE OBTIENE EL PROMEDIO Y LOS LIMITES, LOS CUALES SE OBTIENEN SUMANDO/RESTANDO AL PROMEDIO 3 DESVIACIONES ESTANDAR (ES DECIR Z-SCORES)
# LIMITE SUPERIOR = MEAN + (3 * SD)
# LIMITE INFERIOR = MEAN - (3 * SD)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

library(ggplot2)
library(pscl)
library(boot)
library(lattice)
library(Hmisc)
library(dplyr)
library(plyr)

zmetrop <- read.csv("/home/rosa/Documentos/Proyecto_Seguridad/DELITOS HASTA JUNIO2018/EjercicioSeptiembre/base_zmR.csv")
attach(zmetrop)

#CONSTRUYE campo de concatenacion
#conca<-paste(year,location_code,municipio,typess,tipoz)
conca<-paste(year,typess,tipoz)

#CONSTRUYE EL DATA FRAME
x<-data.frame(conca,year,clv,location_code,municipio,good_legal,typess,subtype,modality,cfinal,tipoz,ene,feb,mar,abr,may,jun,jul,ago,sep,oct,nov,dic)
#write.csv(x, file = "/home/rosa/Documentos/Proyecto_Seguridad/DELITOS HASTA JUNIO2018/EjercicioSeptiembre/x.csv", row.names = TRUE)

#CALCULA EL PROMEDIO
tablemean<-aggregate(x[12:23], by=list(conca), FUN=mean)
head(tablemean,3)

#CALCULA LA DESVIACIÓN ESTANDAR
tablesd<-aggregate(x[12:23], by=list(conca), FUN=sd)
head(tablesd,3)

#CALCULA numero de registros
#ASEGURARSE DE QUE LOS REGISTROS SEAN IGUALES
tablelength<-aggregate(x[12:23], by=list(conca), FUN=length)
head(tablelength,3)

#UNE TABLAS MEAN Y SD
join<-merge(x = tablemean, y = tablesd, by = "Group.1", all = TRUE)
join<-merge(x = join, y = tablelength, by = "Group.1", all = TRUE)

head(join,5)
#ORGANIZA EL DataFrame JOIN
join<-data.frame(join$Group.1,join$ene,join$ene.x,join$ene.y,join$feb.x,join$feb.y,join$mar.x,join$mar.y,join$abr.x,join$abr.y,join$may.x,join$may.y,join$jun.x,join$jun.y,join$jul.x,join$jul.y,join$ago.x,join$ago.y,join$sep.x,join$sep.y,join$oct.x,join$oct.y,join$nov.x,join$nov.y,join$dic.x,join$dic.y)
colnames(join)<-c("conca","recurrencia","enemean","enesd","febmean","febsd","marmean","marsd","abrmean","abrsd","maymean","maysd","junmean","junsd","julmean","julsd","agomean","agosd","sepmean","sepsd","octmean","octsd","novmean","novsd","dicmean","dicsd")

#GENERA Y UNE ID
id<-c(1:nrow(join))
join<-data.frame(id,join)

#ARMA UNA MATRIZ CON LOS VALORES DE PROMEDIO, LIMITE SUPERIOR, LIMITE INFERIOR
sq<- c(26,24,22,20,18,16,14,12,10,8,6,4)

#GENERA EL DATAFRAME Y MATRIZ INICIAL CON EL ID
concajoin<-data.frame(join$id,join$recurrencia)
limitesjoin<-data.matrix(concajoin)

for (i in sq)
{
  promedio<-data.frame(join[i])
  sd<-data.frame(join[i+1])
  
  limsup<-promedio + (3*sd)
  colnames(limsup)<-"limsup"
  liminf<-promedio - (3*sd)
  colnames(liminf)<-"liminf"
  
  #promedio<-head(promedio,20)#EJEMPLO DE 20
  #limsup<-head(limsup,20)#EJEMPLO DE 20
  #liminf<-head(liminf,20)#EJEMPLO DE 20
  
  limites<-data.frame(promedio,limsup,liminf)
  limitesmatrix<-data.matrix(limites)
  limitesjoin<-cbind(limitesmatrix,limitesjoin)
  print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~READY~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
}

#union de datos de limites con la base de todos los registros
bdura<-as.data.frame(limitesjoin)
#names(bdura)
colnames(bdura)<-c("enemean","enelimsup","eneliminf","febmean","feblimsup","febliminf","marmean","marlimsup","marliminf","abrmean","abrlimsup","abrliminf","maymean","maylimsup","mayliminf","junmean","junlimsup","junliminf","julmean","jullimsup","julliminf","agomean","agolimsup","agoliminf","sepmean","seplimsup","sepliminf","octmean","octlimsup","octliminf","novmean","novlimsup","novliminf","dicmean","diclimsup","dicliminf","id","recurrencia")
join2<-data.frame(join$id,join$conca)
colnames(join2)<-c("id","conca")
jrs<-merge(x =join2, y = bdura, by = "id", all = TRUE)
jrs<-merge(x =x, y = jrs, by = "conca", all = TRUE)

jrs$conca<-NULL
#id<-jrs$ene+jrs$feb+jrs$mar+jrs$abr+jrs$may+jrs$jun+jrs$jul+jrs$ago+jrs$sep+jrs$oct+jrs$nov+jrs$dic

head(jrs,5)
write.csv(jrs, file = "/home/rosa/Documentos/Proyecto_Seguridad/DELITOS HASTA JUNIO2018/EjercicioSeptiembre/jrs_final7k.csv", row.names = TRUE)
