
## FICHA TECNICA v1 : DENUNCIAS DELICTIVAS
 __ROSA MARTHA PERALTA BLANCO__
 
  _SECRETARIADO EJECUTIVO_

### Descripción

El código que se muestra a continuación, contiene el procedimiento bajo el cual se trabajaron los datos de denuncias del _Reportes de incidencia delictiva_, los cuales se usaron para obtener datos detallados de los delitos cometidos en México a nivel municipal.

Cabe resaltar que, debido a que la base de datos refleja la cantidad de denuncias y no los delitos ocurridos, los resultados pueden interpretarse como análisis de tendencia, debido al sesgo entre lo real y lo abstracto.

### Carga de librerías


```R
library(stringr)
```

### Inputs

INCLUYE Datos de denuncia del Secretariado Ejecutivo de la Secretaría de Gobernación. La estructura subsecuente, presenta  los campos de la tabla:


```R
#SECRETARIADO
secretariado<- read.csv("/home/rosa/Descargas/BASE_DE_DATOS_ENVIPE_2017_en/secretariado.csv")
```

| Campo|| Descripción|| Tipo || Ejemplo |
| --- | --- | --- | --- | --- | --- | --- |
| __year__  || Año del levantamiento de la denuncia || Entero || 2016 |
| __edo__  || Clave INEGI de la Entidad || Entero || 1 |
| __CVEGEOg__  || Clave INEGI concatenada de la Entidad y Municipio || Entero || 1001 |
| __nommun__  || Nombre del Municipio || Texto || "Aguascalientes" |
| __bienjuridico__  || Bien jurídico afectado|| Texto || "La vida y la integridad corporal" |
| __tipo__  || Tipo de delito || Texto || "Abuso de confianza"|
| __subtipo__  || Subtipo de delito || Texto || "Abuso de confianza" |
| __modalidad__  || Modalidad del delito || Texto || "Abuso de confianza" |
| __clave__  || Clave identificadora del delito|| Texto || "PATabc" |
| __ene__  || Delitos ocurridos en Enero || Entero || 27 |
| __feb__  || Delitos ocurridos en Febrero || Entero || 27 |
| __mar__  || Delitos ocurridos en Marzo || Entero || 27 |
| __abr__  || Delitos ocurridos en Abril || Entero || 27 |
| __may__  || Delitos ocurridos en Mayo || Entero || 27 |
| __jun__  || Delitos ocurridos en Junio || Entero || 27 |
| __jul__  || Delitos ocurridos en Julio || Entero || 27 |
| __ago__  || Delitos ocurridos en Agosto || Entero || 27 |
| __sep__  || Delitos ocurridos en Septiembre || Entero || 27 |
| __oct__  || Delitos ocurridos en Octubre || Entero || 27 |
| __nov__  || Delitos ocurridos en Noviembre || Entero || 27 |
| __dic__  || Delitos ocurridos en Diciembre || Entero || 27 |
| __total__  || Delitos totales ocurridos en el registro, a lo largo del año especificado || Entero || 324 |

### Fórmulas sistematizadas
  
El script para convertir la clave INEGI de la entidad y municipio concatenada, es decir de número (1001) a texto ("01001") es el siguiente:


```R
claveEntMun<-function(x) {
  estmun<-c()
  for (i in 1:length(CVEGEO))
  {
    largo<-nchar(CVEGEO[i])
    if(largo == 4){
      union<-paste("0",CVEGEO[i], sep= "")
      estmun[i]<-rbind(union) }
    else{
      estmun[i]<-rbind(CVEGEO[i]) }
    #if(largo == 1){replace("0",CVE_ENT, sep= "")}
  }
  return(estmun)
}
```

### Preparación de datos
  
Para satisfacer la finalidad de la ficham deben obtenerse dos grupos de delitos:
  1. _Delitos prioritarios_: Establecidos por la Mtra Ana Alegre, los cuales son:
    - Extorsión (PAText)
    - Homicidio doloso (VIChod)
    - Secuestro (LPEsec)
  2. _Delitos reincidentes_: Delitos con el mayor número de denuncias, omitiendo los delitos prioritarios

  - ___Adecuación de tabla___: Deben de optimizarse los datos de entrada según el periodo en el que quiere realizarse el estudio. En este caso como las observaciones son anuales a partir del mes de Julio, deben prepararse bases con este formato.


```R
#Se desagrega la base de datos para poder armar una clave concatenada con año,clave del municipio, clave del delito y tipo
#Posteriormente se arma un data.frame con este campo y todos los meses subsecuentes
attach(secretariado)
CVEGEO<-CVEGEOg
CVEGEO<-claveEntMun(CVEGEO) #CONVERSION A TEXTO DE CAMPO
concatena<-paste(year,CVEGEO,clave,tipo,sep = "-")
secretariado<-data.frame(concatena,ene,feb,mar,abr,may,jun,jul,ago,sep,oct,nov,dic)
```


```R
#Se suman todas las denuncias de un mismo tipo de delito por cada municipio
s2<-aggregate(secretariado[2:13], by=list(concatena), FUN=sum)
#Una vez sumados se desagrega la clave concatenada para obtener los campos
desconca<-str_split_fixed(s2$Group.1,"-",4)
#Se arma un nuevo data frame para agregar a el campo que se fragmentó y los datos de los meses
s3<-data.frame(desconca,s2[2:13])
#Se hace un nuevo campo de concatennación cib clave del municipio, clave de delito y tipo
concatena<-paste(s3$X2,s3$X3,s3$X4,sep = "-")
#Se arma un nuevo data frame, agregando el campo de concatenacion
s3<-data.frame(concatena,s3)
#Se le dan nuevos nombres
colnames(s3)<-c("concatena","year","CVEGEO","clave","tipo","ene","feb","mar","abr","may","jun","jul","ago","sep","oct","nov","dic")
head(s3)
```


<table>
<thead><tr><th scope=col>concatena</th><th scope=col>year</th><th scope=col>CVEGEO</th><th scope=col>clave</th><th scope=col>tipo</th><th scope=col>ene</th><th scope=col>feb</th><th scope=col>mar</th><th scope=col>abr</th><th scope=col>may</th><th scope=col>jun</th><th scope=col>jul</th><th scope=col>ago</th><th scope=col>sep</th><th scope=col>oct</th><th scope=col>nov</th><th scope=col>dic</th></tr></thead>
<tbody>
	<tr><td>01001-FAMiof-Incumplimiento de obligaciones de asistencia familiar</td><td>2016                                                              </td><td>01001                                                             </td><td>FAMiof                                                            </td><td>Incumplimiento de obligaciones de asistencia familiar             </td><td>17                                                                </td><td> 6                                                                </td><td> 1                                                                </td><td> 7                                                                </td><td> 4                                                                </td><td>11                                                                </td><td> 5                                                                </td><td> 6                                                                </td><td>16                                                                </td><td> 6                                                                </td><td> 7                                                                </td><td> 9                                                                </td></tr>
	<tr><td>01001-FAMofa-Otros delitos contra la familia                      </td><td>2016                                                              </td><td>01001                                                             </td><td>FAMofa                                                            </td><td>Otros delitos contra la familia                                   </td><td> 6                                                                </td><td> 4                                                                </td><td> 5                                                                </td><td> 3                                                                </td><td> 5                                                                </td><td> 6                                                                </td><td> 0                                                                </td><td>11                                                                </td><td> 6                                                                </td><td> 8                                                                </td><td> 9                                                                </td><td> 6                                                                </td></tr>
	<tr><td>01001-FAMvfa-Violencia familiar                                   </td><td>2016                                                              </td><td>01001                                                             </td><td>FAMvfa                                                            </td><td>Violencia familiar                                                </td><td>47                                                                </td><td>35                                                                </td><td>45                                                                </td><td>51                                                                </td><td>57                                                                </td><td>37                                                                </td><td>43                                                                </td><td>48                                                                </td><td>50                                                                </td><td>57                                                                </td><td>55                                                                </td><td>39                                                                </td></tr>
	<tr><td>01001-FAMvgt-Violencia de genero distinta a la violencia familiar </td><td>2016                                                              </td><td>01001                                                             </td><td>FAMvgt                                                            </td><td>Violencia de genero distinta a la violencia familiar              </td><td> 0                                                                </td><td> 0                                                                </td><td> 2                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 1                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 0                                                                </td></tr>
	<tr><td>01001-LPEolp-Otros delitos que atentan contra la libertad personal</td><td>2016                                                              </td><td>01001                                                             </td><td>LPEolp                                                            </td><td>Otros delitos que atentan contra la libertad personal             </td><td> 3                                                                </td><td> 3                                                                </td><td> 2                                                                </td><td> 2                                                                </td><td> 3                                                                </td><td> 3                                                                </td><td> 0                                                                </td><td> 2                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 0                                                                </td></tr>
	<tr><td>01001-LPEsec-Secuestro                                            </td><td>2016                                                              </td><td>01001                                                             </td><td>LPEsec                                                            </td><td>Secuestro                                                         </td><td> 0                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 1                                                                </td><td> 0                                                                </td><td> 0                                                                </td><td> 1                                                                </td></tr>
</tbody>
</table>




```R
#Se obtienen conjuntos de datos por años
s3_2016<-subset(s3,s3$year ==2016 )
s3_2017<-subset(s3,s3$year ==2017 )
s3_2018<-subset(s3,s3$year ==2018 )

#Se acomodan los periodos JULIO 2016-2017 y JULIO 2017-2018. 
#Adicionalmente se calcula el total para ese periodo
#Se desagrega el campo de concatenación
s3_1617<- merge(x = s3_2016[c("concatena","jul","ago","sep","oct","nov","dic")], y = s3_2017[c("concatena","ene","feb","mar","abr","may","jun")], by = "concatena", all = TRUE)
s3_1718<- merge(x = s3_2017[c("concatena","jul","ago","sep","oct","nov","dic")], y = s3_2018[c("concatena","ene","feb","mar","abr","may","jun")], by = "concatena", all = TRUE)
s3_1617[is.na(s3_1617)]<- 0
s3_1718[is.na(s3_1718)]<- 0
s3_1617$total<- rowSums(s3_1617[2:13])
s3_1718$total<- rowSums(s3_1718[2:13])
s3_1617<-data.frame(str_split_fixed(s3_1617$concatena,"-",3),s3_1617[14])
s3_1718<-data.frame(str_split_fixed(s3_1718$concatena,"-",3),s3_1718[14])
```


```R
#Se obtienen tabulados por cada año, en el cual cada columna es un delito y el numero de denuncias que tienen. 
#En las filas se encuentran cada uno de los municipios ese año (el ejercicio es para ambos periodos de tiempo)
#JULIO 2016-2017 y JULIO 2017 - 2018

delitos1617<-data.frame(tapply(s3_1617$total,list(s3_1617$X1,s3_1617$X2),sum))
delitos1617<-data.frame(rownames(delitos1617),delitos1617)
delitos1617[is.na(delitos1617)]<- 0

delitos1718<-data.frame(tapply(s3_1718$total,list(s3_1718$X1,s3_1718$X2),sum))
delitos1718<-data.frame(rownames(delitos1718),delitos1718)
delitos1718[is.na(delitos1718)]<- 0

head(delitos1617)
head(delitos1718)
```


<table>
<thead><tr><th></th><th scope=col>rownames.delitos1617.</th><th scope=col>FAMiof</th><th scope=col>FAMofa</th><th scope=col>FAMvfa</th><th scope=col>FAMvgt</th><th scope=col>LPEolp</th><th scope=col>LPErap</th><th scope=col>LPEsec</th><th scope=col>LPEtme</th><th scope=col>LSSabs</th><th scope=col>⋯</th><th scope=col>PATrob</th><th scope=col>SOCcom</th><th scope=col>SOCoso</th><th scope=col>SOCtpe</th><th scope=col>VICabo</th><th scope=col>VICfem</th><th scope=col>VIChod</th><th scope=col>VIChom</th><th scope=col>VICles</th><th scope=col>VICoic</th></tr></thead>
<tbody>
	<tr><th scope=row>01001</th><td>01001</td><td>97   </td><td>70   </td><td>669  </td><td>2    </td><td>43   </td><td>0    </td><td>5    </td><td>0    </td><td>0    </td><td>⋯    </td><td>10378</td><td>44   </td><td>15   </td><td>1    </td><td>5    </td><td>0    </td><td>35   </td><td>111  </td><td>2630 </td><td>19   </td></tr>
	<tr><th scope=row>01002</th><td>01002</td><td> 1   </td><td> 0   </td><td>  9  </td><td>0    </td><td> 2   </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td>⋯    </td><td>  184</td><td> 2   </td><td> 0   </td><td>0    </td><td>0    </td><td>0    </td><td> 4   </td><td> 10  </td><td>  52 </td><td> 0   </td></tr>
	<tr><th scope=row>01003</th><td>01003</td><td> 2   </td><td> 1   </td><td> 13  </td><td>0    </td><td> 0   </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td>⋯    </td><td>  270</td><td> 1   </td><td> 0   </td><td>0    </td><td>0    </td><td>0    </td><td> 1   </td><td>  5  </td><td>  82 </td><td> 0   </td></tr>
	<tr><th scope=row>01004</th><td>01004</td><td> 0   </td><td> 0   </td><td>  0  </td><td>0    </td><td> 0   </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td>⋯    </td><td>   49</td><td> 0   </td><td> 1   </td><td>0    </td><td>0    </td><td>0    </td><td> 2   </td><td>  4  </td><td>  14 </td><td> 0   </td></tr>
	<tr><th scope=row>01005</th><td>01005</td><td> 5   </td><td> 4   </td><td> 62  </td><td>0    </td><td> 5   </td><td>0    </td><td>1    </td><td>0    </td><td>0    </td><td>⋯    </td><td>  632</td><td> 6   </td><td> 0   </td><td>0    </td><td>0    </td><td>0    </td><td> 7   </td><td> 12  </td><td> 186 </td><td> 0   </td></tr>
	<tr><th scope=row>01006</th><td>01006</td><td> 3   </td><td> 1   </td><td>  9  </td><td>1    </td><td> 1   </td><td>0    </td><td>1    </td><td>0    </td><td>0    </td><td>⋯    </td><td>  398</td><td> 3   </td><td> 0   </td><td>0    </td><td>0    </td><td>0    </td><td> 2   </td><td>  8  </td><td> 106 </td><td> 0   </td></tr>
</tbody>
</table>




<table>
<thead><tr><th></th><th scope=col>rownames.delitos1718.</th><th scope=col>FAMiof</th><th scope=col>FAMofa</th><th scope=col>FAMvfa</th><th scope=col>FAMvgt</th><th scope=col>LPEolp</th><th scope=col>LPErap</th><th scope=col>LPEsec</th><th scope=col>LPEtme</th><th scope=col>LSSabs</th><th scope=col>⋯</th><th scope=col>PATrob</th><th scope=col>SOCcom</th><th scope=col>SOCoso</th><th scope=col>SOCtpe</th><th scope=col>VICabo</th><th scope=col>VICfem</th><th scope=col>VIChod</th><th scope=col>VIChom</th><th scope=col>VICles</th><th scope=col>VICoic</th></tr></thead>
<tbody>
	<tr><th scope=row>01001</th><td>01001</td><td>135  </td><td>0    </td><td>986  </td><td>6    </td><td>117  </td><td>0    </td><td>1    </td><td>3    </td><td>0    </td><td>⋯    </td><td>13131</td><td>48   </td><td>0    </td><td>0    </td><td>3    </td><td>1    </td><td>61   </td><td>123  </td><td>3734 </td><td>5    </td></tr>
	<tr><th scope=row>01002</th><td>01002</td><td>  0  </td><td>0    </td><td> 27  </td><td>0    </td><td>  5  </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td>⋯    </td><td>  144</td><td> 0   </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td> 0   </td><td> 14  </td><td>  99 </td><td>0    </td></tr>
	<tr><th scope=row>01003</th><td>01003</td><td>  2  </td><td>0    </td><td> 16  </td><td>0    </td><td>  1  </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td>⋯    </td><td>  432</td><td> 4   </td><td>0    </td><td>1    </td><td>0    </td><td>0    </td><td> 8   </td><td>  8  </td><td> 120 </td><td>1    </td></tr>
	<tr><th scope=row>01004</th><td>01004</td><td>  0  </td><td>0    </td><td>  5  </td><td>0    </td><td>  2  </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td>⋯    </td><td>  114</td><td> 1   </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td> 1   </td><td>  1  </td><td>  28 </td><td>0    </td></tr>
	<tr><th scope=row>01005</th><td>01005</td><td>  4  </td><td>0    </td><td>121  </td><td>0    </td><td> 16  </td><td>0    </td><td>1    </td><td>0    </td><td>0    </td><td>⋯    </td><td> 1314</td><td> 4   </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td> 7   </td><td> 21  </td><td> 355 </td><td>1    </td></tr>
	<tr><th scope=row>01006</th><td>01006</td><td>  4  </td><td>0    </td><td> 43  </td><td>0    </td><td> 10  </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td>⋯    </td><td>  402</td><td> 1   </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td> 2   </td><td>  7  </td><td> 156 </td><td>0    </td></tr>
</tbody>
</table>



### __Delitos reincidentes__

Deben de optimizarse los datos de entrada según el periodo en el que quiere realizarse el estudio. En este caso las observaciones son anuales a partir del mes de Julio. Con base en lo anterior, el código fue escrito para elegir los tres delitos con mayor cantidad de denuncias en el periodo Julio 2017 - 2018, y una vez filtrados, se consultaron los valores que tuvieron estos mismos para el periodo Julio 2016-2017 a modo de comparativo. Finalmente con estos datos se obtuvo la variación entre periodos.

__NOTA__: Aunque el _"Homicidio doloso"_ se considera delito prioritario, en la nueva metodología del Secretariado ejecutivo, este se especifica hasta el nivel de _subdelito_ (es decir lo "doloso"). Por ello fue necesario modificar la clave al nivel de tipo, diferenciando del homicidio culposo cambiando su abreviatura de "hom" a "hod" de forma manual.


```R
#(1) Definir el top de delitos con base en Julio 2017-2018

#Se arman dataframes omitiendo los delitos prioritarios
d2_1617<-data.frame(delitos1617$rownames.delitos1617.,delitos1617$FAMiof,delitos1617$FAMofa,delitos1617$FAMvfa,delitos1617$FAMvgt,delitos1617$LPEolp,delitos1617$LPErap,delitos1617$LPEtme,delitos1617$LSSabs,delitos1617$LSSacs,delitos1617$LSShos,delitos1617$LSSinc,delitos1617$LSSols,delitos1617$LSSveq,delitos1617$LSSvsi,delitos1617$OBJalm,delitos1617$OBJame,delitos1617$OBJcma,delitos1617$OBJdsp,delitos1617$OBJele,delitos1617$OBJevp,delitos1617$OBJfal,delitos1617$OBJfas,delitos1617$OBJnar,delitos1617$OBJofu,delitos1617$PATabc,delitos1617$PATdap,delitos1617$PATdes,delitos1617$PATfra,delitos1617$PATopa,delitos1617$PATrob,delitos1617$SOCcom,delitos1617$SOCoso,delitos1617$SOCtpe,delitos1617$VICabo,delitos1617$VICfem,delitos1617$VIChom,delitos1617$VICles,delitos1617$VICoic)
colnames(d2_1617)<-c("conca","FAMiof","FAMofa","FAMvfa","FAMvgt","LPEolp","LPErap","LPEtme","LSSabs","LSSacs","LSShos","LSSinc","LSSols","LSSveq","LSSvsi","OBJalm","OBJame","OBJcma","OBJdsp","OBJele","OBJevp","OBJfal","OBJfas","OBJnar","OBJofu","PATabc","PATdap","PATdes","PATfra","PATopa","PATrob","SOCcom","SOCoso","SOCtpe","VICabo","VICfem","VIChom","VICles","VICoic"  )
d2_1718<-data.frame(delitos1718$rownames.delitos1718.,delitos1718$FAMiof,delitos1718$FAMofa,delitos1718$FAMvfa,delitos1718$FAMvgt,delitos1718$LPEolp,delitos1718$LPErap,delitos1718$LPEtme,delitos1718$LSSabs,delitos1718$LSSacs,delitos1718$LSShos,delitos1718$LSSinc,delitos1718$LSSols,delitos1718$LSSveq,delitos1718$LSSvsi,delitos1718$OBJalm,delitos1718$OBJame,delitos1718$OBJcma,delitos1718$OBJdsp,delitos1718$OBJele,delitos1718$OBJevp,delitos1718$OBJfal,delitos1718$OBJfas,delitos1718$OBJnar,delitos1718$OBJofu,delitos1718$PATabc,delitos1718$PATdap,delitos1718$PATdes,delitos1718$PATfra,delitos1718$PATopa,delitos1718$PATrob,delitos1718$SOCcom,delitos1718$SOCoso,delitos1718$SOCtpe,delitos1718$VICabo,delitos1718$VICfem,delitos1718$VIChom,delitos1718$VICles,delitos1718$VICoic)
colnames(d2_1718)<-c("conca","FAMiof","FAMofa","FAMvfa","FAMvgt","LPEolp","LPErap","LPEtme","LSSabs","LSSacs","LSShos","LSSinc","LSSols","LSSveq","LSSvsi","OBJalm","OBJame","OBJcma","OBJdsp","OBJele","OBJevp","OBJfal","OBJfas","OBJnar","OBJofu","PATabc","PATdap","PATdes","PATfra","PATopa","PATrob","SOCcom","SOCoso","SOCtpe","VICabo","VICfem","VIChom","VICles","VICoic"  )
```

Inicia el loop para obtener los tres delitos del ___periodo 2017-18___ mas frecuentes.

_Funcionamiento_: Se elige la fila correspondiente a un municipio, donde se obtiene: 
  1. Clave del delito maximo
  2. Valor del maximo
  3. Posición en la tabla del maximo

Estos valores se agregan en un texto para acumular el valor de cada municipio y posteriormente el valor maximo se vuelve cero para que en el proximo loop se detecte el segundo con mayor cantidad.

Finalmente esta cadena se desfragmenta para obtener un data frame con los valores ya mencionados



```R
topdelitos<-data.frame(matrix(0,1,7))
for (i in 1:nrow(d2_1718))
{
  municipio<-d2_1718[i,]
  td<-data.frame(1,2,3)
  for(j in 1:3)
  {
    top<-data.frame(max(municipio[2:39]),which.max(municipio[2:39])) #which.max da la posición delelemento pedido
    top<-data.frame(rownames(top),top)
    colnames(top)<-c("cdelito","denuncias","posicion")
    top<-paste(top$cdelito,top$denuncias,top$posicion,sep="-")
    td[j]<-cbind(top)
    municipio[which.max(municipio[2:39])+1]<-0 #Vuelve cero la cantidad mayor
  }
  td4<-paste(municipio$conca,td$X1,td$X2,td$X3,sep="-")
  topdelitos[i]<-rbind(td4)
}
topdelitos<-data.frame(str_split_fixed(topdelitos,"-",10))
colnames(topdelitos)<-c("conca","del1","del1Num","del1Pos","del2","del2NUm","del2Pos","del3","del3NUm","del3Pos")
head(topdelitos)
```


<table>
<thead><tr><th scope=col>conca</th><th scope=col>del1</th><th scope=col>del1Num</th><th scope=col>del1Pos</th><th scope=col>del2</th><th scope=col>del2NUm</th><th scope=col>del2Pos</th><th scope=col>del3</th><th scope=col>del3NUm</th><th scope=col>del3Pos</th></tr></thead>
<tbody>
	<tr><td>01001 </td><td>PATrob</td><td>13131 </td><td>30    </td><td>VICles</td><td>3734  </td><td>37    </td><td>PATdap</td><td>3222  </td><td>26    </td></tr>
	<tr><td>01002 </td><td>PATrob</td><td>144   </td><td>30    </td><td>VICles</td><td>99    </td><td>37    </td><td>PATdap</td><td>56    </td><td>26    </td></tr>
	<tr><td>01003 </td><td>PATrob</td><td>432   </td><td>30    </td><td>PATdap</td><td>123   </td><td>26    </td><td>VICles</td><td>120   </td><td>37    </td></tr>
	<tr><td>01004 </td><td>PATrob</td><td>114   </td><td>30    </td><td>VICles</td><td>28    </td><td>37    </td><td>PATdap</td><td>20    </td><td>26    </td></tr>
	<tr><td>01005 </td><td>PATrob</td><td>1314  </td><td>30    </td><td>VICles</td><td>355   </td><td>37    </td><td>PATdap</td><td>267   </td><td>26    </td></tr>
	<tr><td>01006 </td><td>PATrob</td><td>402   </td><td>30    </td><td>VICles</td><td>156   </td><td>37    </td><td>OBJnar</td><td>149   </td><td>23    </td></tr>
</tbody>
</table>



Inicia el loop para obtener los valores de los delitos filtrados del periodo 2017-18, pero para el ___periodo 2016-17___


```R
#Obtención de tabla base del periodo 2017-18
top<-data.frame(topdelitos$conca,topdelitos$del1Pos,topdelitos$del2Pos,topdelitos$del3Pos)
colnames(top)<-c("conca","del1Pos","del2Pos","del3Pos")
#Filtrar los municipios de 2016-17 de los que aparecen en el top de 17-18
d2_1617_top<-merge(x = d2_1617, y = top[1] , by = "conca", all = FALSE)
head(d2_1617_top)
```


<table>
<thead><tr><th scope=col>conca</th><th scope=col>FAMiof</th><th scope=col>FAMofa</th><th scope=col>FAMvfa</th><th scope=col>FAMvgt</th><th scope=col>LPEolp</th><th scope=col>LPErap</th><th scope=col>LPEtme</th><th scope=col>LSSabs</th><th scope=col>LSSacs</th><th scope=col>⋯</th><th scope=col>PATopa</th><th scope=col>PATrob</th><th scope=col>SOCcom</th><th scope=col>SOCoso</th><th scope=col>SOCtpe</th><th scope=col>VICabo</th><th scope=col>VICfem</th><th scope=col>VIChom</th><th scope=col>VICles</th><th scope=col>VICoic</th></tr></thead>
<tbody>
	<tr><td>01001</td><td>97   </td><td>70   </td><td>669  </td><td>2    </td><td>43   </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td>⋯    </td><td>0    </td><td>10378</td><td>44   </td><td>15   </td><td>1    </td><td>5    </td><td>0    </td><td>111  </td><td>2630 </td><td>19   </td></tr>
	<tr><td>01002</td><td> 1   </td><td> 0   </td><td>  9  </td><td>0    </td><td> 2   </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td>⋯    </td><td>0    </td><td>  184</td><td> 2   </td><td> 0   </td><td>0    </td><td>0    </td><td>0    </td><td> 10  </td><td>  52 </td><td> 0   </td></tr>
	<tr><td>01003</td><td> 2   </td><td> 1   </td><td> 13  </td><td>0    </td><td> 0   </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td>⋯    </td><td>0    </td><td>  270</td><td> 1   </td><td> 0   </td><td>0    </td><td>0    </td><td>0    </td><td>  5  </td><td>  82 </td><td> 0   </td></tr>
	<tr><td>01004</td><td> 0   </td><td> 0   </td><td>  0  </td><td>0    </td><td> 0   </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td>⋯    </td><td>0    </td><td>   49</td><td> 0   </td><td> 1   </td><td>0    </td><td>0    </td><td>0    </td><td>  4  </td><td>  14 </td><td> 0   </td></tr>
	<tr><td>01005</td><td> 5   </td><td> 4   </td><td> 62  </td><td>0    </td><td> 5   </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td>⋯    </td><td>0    </td><td>  632</td><td> 6   </td><td> 0   </td><td>0    </td><td>0    </td><td>0    </td><td> 12  </td><td> 186 </td><td> 0   </td></tr>
	<tr><td>01006</td><td> 3   </td><td> 1   </td><td>  9  </td><td>1    </td><td> 1   </td><td>0    </td><td>0    </td><td>0    </td><td>0    </td><td>⋯    </td><td>0    </td><td>  398</td><td> 3   </td><td> 0   </td><td>0    </td><td>0    </td><td>0    </td><td>  8  </td><td> 106 </td><td> 0   </td></tr>
</tbody>
</table>



Inicia el loop para obtener los tres delitos del ___periodo 2016-17___ con base en el periodo 2017-18

_Funcionamiento_: Se elige la fila correspondiente a un municipio, donde se obtienen los datos de delitos con base en la posición del delito obtenido en el for anterior


```R
topdelitos1617<-data.frame(matrix(0,1,7))
for (i in 1:nrow(d2_1617_top))
{
  municipio<-d2_1617_top[i,]
  td<-top[i,]
  #print(municipio)
  t1<-municipio[as.numeric(as.character(droplevels.factor(td$del1Pos)))+1]
  t2<-municipio[as.numeric(as.character(droplevels.factor(td$del2Pos)))+1]
  t3<-municipio[as.numeric(as.character(droplevels.factor(td$del3Pos)))+1]  
  
  j<-paste(municipio$conca,t1,t2,t3,sep="-")
  topdelitos1617[i]<-rbind(j)
}
topdelitos1617<-data.frame(str_split_fixed(topdelitos1617,"-",4))
colnames(topdelitos1617)<-c("conca","del1Num","del2NUm","del3NUm")

secret_final<-merge(x = topdelitos, y = topdelitos1617 , by = "conca", all = TRUE)
secret_final<-data.frame(secret_final$conca,secret_final$del1,secret_final$del1Num.y,secret_final$del1Num.x,secret_final$del2,secret_final$del2NUm.y,secret_final$del2NUm.x,secret_final$del3,secret_final$del3NUm.y,secret_final$del3NUm.x)
colnames(secret_final)<-c("conca","d1","d1_1617","d1_1718","d2","d2_1617","d2_1718","d3","d3_1617","d3_1718")
head(secret_final)
```


<table>
<thead><tr><th scope=col>conca</th><th scope=col>d1</th><th scope=col>d1_1617</th><th scope=col>d1_1718</th><th scope=col>d2</th><th scope=col>d2_1617</th><th scope=col>d2_1718</th><th scope=col>d3</th><th scope=col>d3_1617</th><th scope=col>d3_1718</th></tr></thead>
<tbody>
	<tr><td>01001 </td><td>PATrob</td><td>10378 </td><td>13131 </td><td>VICles</td><td>2630  </td><td>3734  </td><td>PATdap</td><td>1817  </td><td>3222  </td></tr>
	<tr><td>01002 </td><td>PATrob</td><td>184   </td><td>144   </td><td>VICles</td><td>52    </td><td>99    </td><td>PATdap</td><td>24    </td><td>56    </td></tr>
	<tr><td>01003 </td><td>PATrob</td><td>270   </td><td>432   </td><td>PATdap</td><td>69    </td><td>123   </td><td>VICles</td><td>82    </td><td>120   </td></tr>
	<tr><td>01004 </td><td>PATrob</td><td>49    </td><td>114   </td><td>VICles</td><td>14    </td><td>28    </td><td>PATdap</td><td>12    </td><td>20    </td></tr>
	<tr><td>01005 </td><td>PATrob</td><td>632   </td><td>1314  </td><td>VICles</td><td>186   </td><td>355   </td><td>PATdap</td><td>106   </td><td>267   </td></tr>
	<tr><td>01006 </td><td>PATrob</td><td>398   </td><td>402   </td><td>VICles</td><td>106   </td><td>156   </td><td>OBJnar</td><td>53    </td><td>149   </td></tr>
</tbody>
</table>



### Delitos prioritarios

Debido a que este tipo de delitos ya se tienen identificados, se seleccionan directamente de los tabulados.


```R
#Se obtienen los datos para ambos periodos, se unen y se arregla la base resultante
prioritarios1617<-data.frame(delitos1617$rownames.delitos1617.,delitos1617$PAText,delitos1617$VIChod,delitos1617$LPEsec)
colnames(prioritarios1617)<-c("conca","PAText1617","VIChod1617","LPEsec1617")
prioritarios1718<-data.frame(delitos1718$rownames.delitos1718.,delitos1718$PAText,delitos1718$VIChod,delitos1718$LPEsec)
colnames(prioritarios1718)<-c("conca","PAText1718","VIChod1718","LPEsec1718")
prioritarios<-merge(x = prioritarios1617, y = prioritarios1718 , by = "conca", all = TRUE)
prioritarios<-data.frame(prioritarios$conca,prioritarios$PAText1617,prioritarios$PAText1718,prioritarios$VIChod1617,prioritarios$VIChod1718,prioritarios$LPEsec1617,prioritarios$LPEsec1718)
colnames(prioritarios)<-c("conca","PAText1617","PAText1718","VIChod1617","VIChod1718","LPEsec1617","LPEsec1718")
#Se une a la base final del secretariado
secret_final<-merge(x = prioritarios, y = secret_final , by = "conca", all = TRUE)
head(secret_final)
```


<table>
<thead><tr><th scope=col>conca</th><th scope=col>PAText1617</th><th scope=col>PAText1718</th><th scope=col>VIChod1617</th><th scope=col>VIChod1718</th><th scope=col>LPEsec1617</th><th scope=col>LPEsec1718</th><th scope=col>d1</th><th scope=col>d1_1617</th><th scope=col>d1_1718</th><th scope=col>d2</th><th scope=col>d2_1617</th><th scope=col>d2_1718</th><th scope=col>d3</th><th scope=col>d3_1617</th><th scope=col>d3_1718</th></tr></thead>
<tbody>
	<tr><td>01001 </td><td>63    </td><td>105   </td><td>35    </td><td>61    </td><td>5     </td><td>1     </td><td>PATrob</td><td>10378 </td><td>13131 </td><td>VICles</td><td>2630  </td><td>3734  </td><td>PATdap</td><td>1817  </td><td>3222  </td></tr>
	<tr><td>01002 </td><td> 0    </td><td>  1   </td><td> 4    </td><td> 0    </td><td>0     </td><td>0     </td><td>PATrob</td><td>184   </td><td>144   </td><td>VICles</td><td>52    </td><td>99    </td><td>PATdap</td><td>24    </td><td>56    </td></tr>
	<tr><td>01003 </td><td> 2    </td><td>  9   </td><td> 1    </td><td> 8    </td><td>0     </td><td>0     </td><td>PATrob</td><td>270   </td><td>432   </td><td>PATdap</td><td>69    </td><td>123   </td><td>VICles</td><td>82    </td><td>120   </td></tr>
	<tr><td>01004 </td><td> 0    </td><td>  1   </td><td> 2    </td><td> 1    </td><td>0     </td><td>0     </td><td>PATrob</td><td>49    </td><td>114   </td><td>VICles</td><td>14    </td><td>28    </td><td>PATdap</td><td>12    </td><td>20    </td></tr>
	<tr><td>01005 </td><td> 6    </td><td> 17   </td><td> 7    </td><td> 7    </td><td>1     </td><td>1     </td><td>PATrob</td><td>632   </td><td>1314  </td><td>VICles</td><td>186   </td><td>355   </td><td>PATdap</td><td>106   </td><td>267   </td></tr>
	<tr><td>01006 </td><td> 2    </td><td>  6   </td><td> 2    </td><td> 2    </td><td>1     </td><td>0     </td><td>PATrob</td><td>398   </td><td>402   </td><td>VICles</td><td>106   </td><td>156   </td><td>OBJnar</td><td>53    </td><td>149   </td></tr>
</tbody>
</table>




```R
#Se calculan las variaciones respectivas
secret_final$PAText_var<-round(((as.numeric(as.character(droplevels.factor(secret_final$PAText1718))) - as.numeric(as.character(droplevels.factor(secret_final$PAText1617)))) * 100) / as.numeric(as.character(droplevels.factor(secret_final$PAText1617))),1)
secret_final$VIChod_var<-round(((as.numeric(as.character(droplevels.factor(secret_final$VIChod1718))) - as.numeric(as.character(droplevels.factor(secret_final$VIChod1617)))) * 100) / as.numeric(as.character(droplevels.factor(secret_final$VIChod1617))),1)
secret_final$LPEsec_var<-round(((as.numeric(as.character(droplevels.factor(secret_final$LPEsec1718))) - as.numeric(as.character(droplevels.factor(secret_final$LPEsec1617)))) * 100) / as.numeric(as.character(droplevels.factor(secret_final$LPEsec1617))),1)
secret_final$d1_var<-round(((as.numeric(as.character(droplevels.factor(secret_final$d1_1718))) - as.numeric(as.character(droplevels.factor(secret_final$d1_1617)))) * 100) / as.numeric(as.character(droplevels.factor(secret_final$d1_1617))),1)
secret_final$d2_var<-round(((as.numeric(as.character(droplevels.factor(secret_final$d2_1718))) - as.numeric(as.character(droplevels.factor(secret_final$d2_1617)))) * 100) / as.numeric(as.character(droplevels.factor(secret_final$d2_1617))),1)
secret_final$d3_var<-round(((as.numeric(as.character(droplevels.factor(secret_final$d3_1718))) - as.numeric(as.character(droplevels.factor(secret_final$d3_1617)))) * 100) / as.numeric(as.character(droplevels.factor(secret_final$d3_1617))),1)

secret_final<-data.frame(secret_final$conca,secret_final$PAText1617,secret_final$PAText1718,secret_final$PAText_var,secret_final$VIChod1617,secret_final$VIChod1718,secret_final$VIChod_var,secret_final$LPEsec1617,secret_final$LPEsec1718,secret_final$LPEsec_var,secret_final$d1,secret_final$d1_1617,secret_final$d1_1718,secret_final$d1_var,secret_final$d2,secret_final$d2_1617,secret_final$d2_1718,secret_final$d2_var,secret_final$d3,secret_final$d3_1617,secret_final$d3_1718,secret_final$d3_var)
colnames(secret_final)<-c("conca","PAText1617","PAText1718","PATextVar","VIChod1617","VIChod1718","VIChodVar","LPEsec1617","LPEsec1718","LPEsecVar","d1","d1_1617","d1_1718","d1Var","d2","d2_1617","d2_1718","d2Var","d3","d3_1617","d3_1718","d3Var")
head(secret_final)
```


<table>
<thead><tr><th scope=col>conca</th><th scope=col>PAText1617</th><th scope=col>PAText1718</th><th scope=col>PATextVar</th><th scope=col>VIChod1617</th><th scope=col>VIChod1718</th><th scope=col>VIChodVar</th><th scope=col>LPEsec1617</th><th scope=col>LPEsec1718</th><th scope=col>LPEsecVar</th><th scope=col>⋯</th><th scope=col>d1_1718</th><th scope=col>d1Var</th><th scope=col>d2</th><th scope=col>d2_1617</th><th scope=col>d2_1718</th><th scope=col>d2Var</th><th scope=col>d3</th><th scope=col>d3_1617</th><th scope=col>d3_1718</th><th scope=col>d3Var</th></tr></thead>
<tbody>
	<tr><td>01001 </td><td>63    </td><td>105   </td><td> 66.7 </td><td>35    </td><td>61    </td><td>  74.3</td><td>5     </td><td>1     </td><td> -80  </td><td>⋯     </td><td>13131 </td><td> 26.5 </td><td>VICles</td><td>2630  </td><td>3734  </td><td> 42.0 </td><td>PATdap</td><td>1817  </td><td>3222  </td><td> 77.3 </td></tr>
	<tr><td>01002 </td><td> 0    </td><td>  1   </td><td>  Inf </td><td> 4    </td><td> 0    </td><td>-100.0</td><td>0     </td><td>0     </td><td> NaN  </td><td>⋯     </td><td>144   </td><td>-21.7 </td><td>VICles</td><td>52    </td><td>99    </td><td> 90.4 </td><td>PATdap</td><td>24    </td><td>56    </td><td>133.3 </td></tr>
	<tr><td>01003 </td><td> 2    </td><td>  9   </td><td>350.0 </td><td> 1    </td><td> 8    </td><td> 700.0</td><td>0     </td><td>0     </td><td> NaN  </td><td>⋯     </td><td>432   </td><td> 60.0 </td><td>PATdap</td><td>69    </td><td>123   </td><td> 78.3 </td><td>VICles</td><td>82    </td><td>120   </td><td> 46.3 </td></tr>
	<tr><td>01004 </td><td> 0    </td><td>  1   </td><td>  Inf </td><td> 2    </td><td> 1    </td><td> -50.0</td><td>0     </td><td>0     </td><td> NaN  </td><td>⋯     </td><td>114   </td><td>132.7 </td><td>VICles</td><td>14    </td><td>28    </td><td>100.0 </td><td>PATdap</td><td>12    </td><td>20    </td><td> 66.7 </td></tr>
	<tr><td>01005 </td><td> 6    </td><td> 17   </td><td>183.3 </td><td> 7    </td><td> 7    </td><td>   0.0</td><td>1     </td><td>1     </td><td>   0  </td><td>⋯     </td><td>1314  </td><td>107.9 </td><td>VICles</td><td>186   </td><td>355   </td><td> 90.9 </td><td>PATdap</td><td>106   </td><td>267   </td><td>151.9 </td></tr>
	<tr><td>01006 </td><td> 2    </td><td>  6   </td><td>200.0 </td><td> 2    </td><td> 2    </td><td>   0.0</td><td>1     </td><td>0     </td><td>-100  </td><td>⋯     </td><td>402   </td><td>  1.0 </td><td>VICles</td><td>106   </td><td>156   </td><td> 47.2 </td><td>OBJnar</td><td>53    </td><td>149   </td><td>181.1 </td></tr>
</tbody>
</table>



### Salva de Output


```R
write.csv(secret_final, file = "/home/rosa/Descargas/BASE_DE_DATOS_ENVIPE_2017_en/tb/tb_secretariado.csv", row.names = TRUE)
```
