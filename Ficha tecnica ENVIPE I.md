
## FICHA TECNICA v1 : ENVIPE I
 __ROSA MARTHA PERALTA BLANCO__
 
 INEGI

#### Descripción

Este documento contiene el código correspondiente a la obtención de datos referentes a las características del entorno de la vivienda y la condición de delito de las personas entrevistadas en la ENVIPE (las cuales fueron encuestadas completamente)

#### Inputs

Las bases de datos de entrada se divide en dos categorías: (1) la correspondiente a los nombres corregidos de los estados y municipios, y (2) La de las caracteristicas de las viviendas seleccionadas, sus integrantes y los hogares que las conforman. La estructura subsecuente, presenta únicamente los campos de la tabla que son utilizados:

  1a. _Estados_


```R
edo<- read.csv("/home/rosa/Descargas/BASE_DE_DATOS_ENVIPE_2017_en/estados.csv")
```

| Campo|| Descripción|| Tipo || Ejemplo |
| ---------- ||---------- ||---------- |
| __CVE_ENT__  || Clave INEGI del Estado || Entero || 1 |
| __nombreedo__  || Nombre del Estado || Texto || "Aguascalientes" |

1b. _Municipios_


```R
mun<- read.csv("/home/rosa/Descargas/BASE_DE_DATOS_ENVIPE_2017_en/municipios.csv")
```

| Campo|| Descripción|| Tipo || Ejemplo |
| ---------- ||---------- ||---------- |
| __CVEGEO__  || Clave INEGI concatenada del Estado y Municipio || Entero || 1001 |
| __nommun__  || Nombre del Municipio || Texto || "Aguascalientes" |

2. _ENVIPE I - Viviendas_


```R
vivienda<- read.csv("/home/rosa/Descargas/BASE_DE_DATOS_ENVIPE_2017_en/I_TVivienda.csv")
```

| Campo|| Descripción|| Tipo || Ejemplo |
| ---------- ||---------- ||---------- |
| __ID_VIV__  || Identificador de la vivienda || Texto || "0100008.01" |
| __UPM__  || Unidad primaria de muestreo || Texto || "100008" |
| __VIV_SEL__  || Vivienda seleccionada || Texto || "1" |
| __AREAM__  || Área Metropolitana || Entero || 14 |
| __CVE_ENT__  || Clave de la Entidad|| Entero || 1 |
| __NOM_ENT__  || Nombre de la Entidad|| Texto || "Aguascalientes"|
| __CVE_MUN__  || Clave del Municipio || Entero || 1 |
| __NOM_MUN__  || Nombre del Municipio|| Texto || "Aguascalientes" |
| __RESULT_V__  || Resultado de la visita a la vivienda, donde se restringe a dos opciones:|| Entero || 2|
|   ||  __1__ Entrevista completa con victimización ||  || |
|   ||  __2__ Entrevista completa sin victimización ||  || |
| __AP1_1__  || Clase de vivienda particular || Entero || 1|
| __DOMINIO__  || Tipo de entorno, donde hay tres opciones: || Texto || "U"|
|   ||  __U__ : Urbano ||  || |
|   ||  __C__ : Complemento urbano ||  || |
|   ||  __R__ : Rural ||  || |

  - __Fórmulas sistematizadas__
  
  Scripts para convertir la clave INEGI de la entidad de número (1) a texto ("01") y para convertir la clave INEGI del municipio de número (1) a texto ("001")


```R
claveEnt<-function(x) {
  estado<-c()
  for (i in 1:length(CVE_ENT))
  {
    largo<-nchar(CVE_ENT[i])
    if(largo == 1){
      union<-paste("0",CVE_ENT[i], sep= "")
      estado[i]<-rbind(union) }
    else{
      estado[i]<-rbind(CVE_ENT[i]) }
  }
  return(estado)
}

claveMun<-function(x) {
  municipio<-c()
  for (j in 1:length(CVE_MUN))
  {
    largo<-nchar(CVE_MUN[j])
    switch (largo,
            "1" = {union<-paste("00",CVE_MUN[j], sep= "")},
            "2" = {union<-paste("0",CVE_MUN[j], sep= "")},
            "3" = {union<-CVE_MUN[j]}
    )
    municipio[j]<-rbind(union) 
  }
  return(municipio)
}

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

  - __Preparación de datos__
  
  
  1. _Estados y Municipios_: Se prepara la base para que tenga el formato adecuado


```R
colnames(edo)<-c("CVE_ENT","noment")
attach(edo)
CVE_ENT<-claveEnt(CVE_ENT)
edo<-data.frame(CVE_ENT,noment)
rm(CVE_ENT)
detach(edo)

attach(mun)
CVEGEO<-claveEntMun(CVEGEO)
mun<-data.frame(CVEGEO,nommun)
colnames(mun)<-c("conca","NomMun")
rm(CVEGEO)
detach(mun)
```


```R
head(edo)
head(mun)
```


<table>
<thead><tr><th scope=col>CVE_ENT</th><th scope=col>noment</th></tr></thead>
<tbody>
	<tr><td>01                  </td><td>Aguascalientes      </td></tr>
	<tr><td>02                  </td><td>Baja California     </td></tr>
	<tr><td>03                  </td><td>Baja California Sur </td></tr>
	<tr><td>04                  </td><td>Campeche            </td></tr>
	<tr><td>05                  </td><td>Coahuila de Zaragoza</td></tr>
	<tr><td>06                  </td><td>Colima              </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>conca</th><th scope=col>NomMun</th></tr></thead>
<tbody>
	<tr><td>01001              </td><td>Aguascalientes     </td></tr>
	<tr><td>01002              </td><td>Asientos           </td></tr>
	<tr><td>01003              </td><td>Calvillo           </td></tr>
	<tr><td>01004              </td><td>Cosio              </td></tr>
	<tr><td>01005              </td><td>Jesus Maria        </td></tr>
	<tr><td>01006              </td><td>Pabellon de Arteaga</td></tr>
</tbody>
</table>



  2. __Vivienda__: Se aplica FILTRO cuando solo hay encuestas completas tanto de victimas como de no victimas (OPCIONES 1 Y 2 DEL CAMPO RESULT_V) 


```R
vivienda<- subset(vivienda, vivienda$RESULT_V < 3)
attach(vivienda)
CVE_ENT<-claveEnt(CVE_ENT) #CONVERSION A TEXTO DE CAMPO
CVE_MUN<-claveMun(CVE_MUN)
conca<-paste(CVE_ENT, CVE_MUN, sep= "")  #Conforma un identificador llave que une Estado y Municipio
```

Se arma base de datos Input


```R
vivienda<-data.frame(conca,ID_VIV,UPM,VIV_SEL,AREAM,CVE_ENT,NOM_ENT,CVE_MUN,NOM_MUN,RESULT_V,AP1_1,DOMINIO)
head(vivienda)
```


<table>
<thead><tr><th scope=col>conca</th><th scope=col>ID_VIV</th><th scope=col>UPM</th><th scope=col>VIV_SEL</th><th scope=col>AREAM</th><th scope=col>CVE_ENT</th><th scope=col>NOM_ENT</th><th scope=col>CVE_MUN</th><th scope=col>NOM_MUN</th><th scope=col>RESULT_V</th><th scope=col>AP1_1</th><th scope=col>DOMINIO</th></tr></thead>
<tbody>
	<tr><td>01001         </td><td>100008.0      </td><td>100008        </td><td>1             </td><td>14            </td><td>01            </td><td>Aguascalientes</td><td>001           </td><td>Aguascalientes</td><td>2             </td><td>1             </td><td>U             </td></tr>
	<tr><td>01001         </td><td>100008.0      </td><td>100008        </td><td>2             </td><td>14            </td><td>01            </td><td>Aguascalientes</td><td>001           </td><td>Aguascalientes</td><td>2             </td><td>1             </td><td>U             </td></tr>
	<tr><td>01001         </td><td>100008.0      </td><td>100008        </td><td>4             </td><td>14            </td><td>01            </td><td>Aguascalientes</td><td>001           </td><td>Aguascalientes</td><td>2             </td><td>1             </td><td>U             </td></tr>
	<tr><td>01001         </td><td>100008.1      </td><td>100008        </td><td>5             </td><td>14            </td><td>01            </td><td>Aguascalientes</td><td>001           </td><td>Aguascalientes</td><td>1             </td><td>2             </td><td>U             </td></tr>
	<tr><td>01001         </td><td>100022.0      </td><td>100022        </td><td>1             </td><td>14            </td><td>01            </td><td>Aguascalientes</td><td>001           </td><td>Aguascalientes</td><td>1             </td><td>1             </td><td>U             </td></tr>
	<tr><td>01001         </td><td>100022.0      </td><td>100022        </td><td>2             </td><td>14            </td><td>01            </td><td>Aguascalientes</td><td>001           </td><td>Aguascalientes</td><td>1             </td><td>1             </td><td>U             </td></tr>
</tbody>
</table>



  - __Consultas__

  1. CONSULTA PARA OBTENER ENTIDAD, MUNICIPIO Y DOMINIO


```R
vdb<-aggregate(vivienda,by=list(conca,CVE_ENT,CVE_MUN,NOM_MUN,DOMINIO), FUN=length)
vdb<-vdb[1:6]
colnames(vdb)<-c("conca","CVE_ENT","CVE_MUN","NOM_MUN","DOMINIO","CANTIDAD")
head(vdb)
```


<table>
<thead><tr><th scope=col>conca</th><th scope=col>CVE_ENT</th><th scope=col>CVE_MUN</th><th scope=col>NOM_MUN</th><th scope=col>DOMINIO</th><th scope=col>CANTIDAD</th></tr></thead>
<tbody>
	<tr><td>11001             </td><td>11                </td><td>001               </td><td>Abasolo           </td><td>C                 </td><td>20                </td></tr>
	<tr><td>07001             </td><td>07                </td><td>001               </td><td>Acacoyagua        </td><td>C                 </td><td>15                </td></tr>
	<tr><td>11002             </td><td>11                </td><td>002               </td><td>Acámbaro          </td><td>C                 </td><td>35                </td></tr>
	<tr><td>18001             </td><td>18                </td><td>001               </td><td>Acaponeta         </td><td>C                 </td><td>35                </td></tr>
	<tr><td>12001             </td><td>12                </td><td>001               </td><td>Acapulco de Juárez</td><td>C                 </td><td>37                </td></tr>
	<tr><td>14002             </td><td>14                </td><td>002               </td><td>Acatlán de Juárez </td><td>C                 </td><td>36                </td></tr>
</tbody>
</table>



Join del nombre de los estados con ENVIPE I, el cual constituye la tabla base


```R
vdb<-merge(x = vdb, y = edo , by = "CVE_ENT", all = TRUE)
tail(vdb)
```


<table>
<thead><tr><th></th><th scope=col>CVE_ENT</th><th scope=col>conca</th><th scope=col>CVE_MUN</th><th scope=col>NOM_MUN</th><th scope=col>DOMINIO</th><th scope=col>CANTIDAD</th><th scope=col>noment</th></tr></thead>
<tbody>
	<tr><th scope=row>1520</th><td>32                   </td><td>32026                </td><td>026                  </td><td>Mazapil              </td><td>R                    </td><td> 20                  </td><td>Zacatecas            </td></tr>
	<tr><th scope=row>1521</th><td>32                   </td><td>32037                </td><td>037                  </td><td>Pánuco               </td><td>R                    </td><td> 35                  </td><td>Zacatecas            </td></tr>
	<tr><th scope=row>1522</th><td>32                   </td><td>32025                </td><td>025                  </td><td>Luis Moya            </td><td>R                    </td><td> 18                  </td><td>Zacatecas            </td></tr>
	<tr><th scope=row>1523</th><td>32                   </td><td>32058                </td><td>058                  </td><td>Santa María de la Paz</td><td>R                    </td><td> 20                  </td><td>Zacatecas            </td></tr>
	<tr><th scope=row>1524</th><td>32                   </td><td>32053                </td><td>053                  </td><td>Villa González Ortega</td><td>C                    </td><td> 34                  </td><td>Zacatecas            </td></tr>
	<tr><th scope=row>1525</th><td>32                   </td><td>32010                </td><td>010                  </td><td>Fresnillo            </td><td>R                    </td><td>110                  </td><td>Zacatecas            </td></tr>
</tbody>
</table>



  2. CONSULTA PARA OBTENER COLUMNAS DE DOMINIO


```R
vdominio<-data.frame(tapply(vdb$CANTIDAD,list(vdb$conca,vdb$DOMINIO),sum))
vdominio<-data.frame(vdominio,row.names.data.frame(vdominio))
colnames(vdominio)<-c("CompUrb","Rural","Urbano","conca")
vdominio[is.na(vdominio)]<- 0
vdominio$prcCompUrb<-round(vdominio$CompUrb * 100 / rowSums(vdominio[1:3]),0)
vdominio$prcRural<-round(vdominio$Rural * 100 / rowSums(vdominio[1:3]),0)
vdominio$prcUrbano<-round(vdominio$Urbano * 100 / rowSums(vdominio[1:3]),0)
head(vdominio)
```


<table>
<thead><tr><th></th><th scope=col>CompUrb</th><th scope=col>Rural</th><th scope=col>Urbano</th><th scope=col>conca</th><th scope=col>prcCompUrb</th><th scope=col>prcRural</th><th scope=col>prcUrbano</th></tr></thead>
<tbody>
	<tr><th scope=row>01001</th><td>38   </td><td>54   </td><td>1143 </td><td>01001</td><td>  3  </td><td>  4  </td><td>93   </td></tr>
	<tr><th scope=row>01002</th><td>19   </td><td> 0   </td><td>   0 </td><td>01002</td><td>100  </td><td>  0  </td><td> 0   </td></tr>
	<tr><th scope=row>01003</th><td>19   </td><td>74   </td><td>   0 </td><td>01003</td><td> 20  </td><td> 80  </td><td> 0   </td></tr>
	<tr><th scope=row>01004</th><td> 0   </td><td>18   </td><td>   0 </td><td>01004</td><td>  0  </td><td>100  </td><td> 0   </td></tr>
	<tr><th scope=row>01005</th><td>39   </td><td>74   </td><td>  68 </td><td>01005</td><td> 22  </td><td> 41  </td><td>38   </td></tr>
	<tr><th scope=row>01006</th><td>39   </td><td> 0   </td><td>   0 </td><td>01006</td><td>100  </td><td>  0  </td><td> 0   </td></tr>
</tbody>
</table>



  3. CONSULTA PARA OBTENER EL TIPO DE VIVIENDA Y PORCENTAJE DE VICTIMA/NO VICTIMA
  
En esta consulta se tiene que considerar que se quiere obtener:

  __RESULT_V__:
    - 1 = Victima
    - 2 = No Victima


```R
vparticular<-aggregate(vivienda,by=list(conca,RESULT_V), FUN=length)
vparticular<-vparticular[1:3]
colnames(vparticular)<-c("conca","victimas","count")
head(vparticular)
tail(vparticular)
```


<table>
<thead><tr><th scope=col>conca</th><th scope=col>victimas</th><th scope=col>count</th></tr></thead>
<tbody>
	<tr><td>01001</td><td>1    </td><td>504  </td></tr>
	<tr><td>01002</td><td>1    </td><td>  3  </td></tr>
	<tr><td>01003</td><td>1    </td><td> 24  </td></tr>
	<tr><td>01004</td><td>1    </td><td>  3  </td></tr>
	<tr><td>01005</td><td>1    </td><td> 70  </td></tr>
	<tr><td>01006</td><td>1    </td><td>  9  </td></tr>
</tbody>
</table>




<table>
<thead><tr><th></th><th scope=col>conca</th><th scope=col>victimas</th><th scope=col>count</th></tr></thead>
<tbody>
	<tr><th scope=row>2210</th><td>32052</td><td>2    </td><td> 19  </td></tr>
	<tr><th scope=row>2211</th><td>32053</td><td>2    </td><td> 30  </td></tr>
	<tr><th scope=row>2212</th><td>32055</td><td>2    </td><td> 14  </td></tr>
	<tr><th scope=row>2213</th><td>32056</td><td>2    </td><td>103  </td></tr>
	<tr><th scope=row>2214</th><td>32057</td><td>2    </td><td> 15  </td></tr>
	<tr><th scope=row>2215</th><td>32058</td><td>2    </td><td> 19  </td></tr>
</tbody>
</table>



Genera columnas de victima, no victima


```R
vicnovic<-data.frame(tapply(vparticular$count,list(vparticular$conca,vparticular$victimas),sum))
vicnovic<-data.frame(vicnovic,row.names.data.frame(vicnovic))
colnames(vicnovic)<-c("Victima","Novictima","conca")
vicnovic[is.na(vicnovic)]<- 0
vicnovic$prcVictima<-round(vicnovic$Victima * 100 / rowSums(vicnovic[1:2]),0)
vicnovic$prcNovictima<-round(vicnovic$Novictima * 100 / rowSums(vicnovic[1:2]),0)
head(vicnovic)
```


<table>
<thead><tr><th></th><th scope=col>Victima</th><th scope=col>Novictima</th><th scope=col>conca</th><th scope=col>prcVictima</th><th scope=col>prcNovictima</th></tr></thead>
<tbody>
	<tr><th scope=row>01001</th><td>504  </td><td>731  </td><td>01001</td><td>41   </td><td>59   </td></tr>
	<tr><th scope=row>01002</th><td>  3  </td><td> 16  </td><td>01002</td><td>16   </td><td>84   </td></tr>
	<tr><th scope=row>01003</th><td> 24  </td><td> 69  </td><td>01003</td><td>26   </td><td>74   </td></tr>
	<tr><th scope=row>01004</th><td>  3  </td><td> 15  </td><td>01004</td><td>17   </td><td>83   </td></tr>
	<tr><th scope=row>01005</th><td> 70  </td><td>111  </td><td>01005</td><td>39   </td><td>61   </td></tr>
	<tr><th scope=row>01006</th><td>  9  </td><td> 30  </td><td>01006</td><td>23   </td><td>77   </td></tr>
</tbody>
</table>



  - __OUTPUT Tabla base y ENVIPE I__

MERGE-ENVIPE CON TABLA BASE


```R
tbase<-merge(x = vdominio[4:7], y = vicnovic[3:5] , by = "conca", all = TRUE)
tbase<-merge(x = tbase, y = mun , by = "conca", all = TRUE)
tbase$CVE_ENT<-substr(tbase$conca, 1, 2)
tbase<-merge(x = tbase, y = edo , by = "CVE_ENT", all = TRUE)
#tbase[is.na(tbase)]<- 0
tbase<-data.frame(tbase$CVE_ENT,tbase$noment,tbase$conca,tbase$NomMun,tbase$prcUrbano,tbase$prcCompUrb,tbase$prcRural,tbase$prcVictima,tbase$prcNovictima)
colnames(tbase)<-c("CVE_ENT","noment","conca","NomMun","prcUrbano","prcCompUrb","prcRural","prcVictima","prcNovictima")
#detach(vivienda)
```


```R
head(tbase)
```


<table>
<thead><tr><th scope=col>CVE_ENT</th><th scope=col>noment</th><th scope=col>conca</th><th scope=col>NomMun</th><th scope=col>prcUrbano</th><th scope=col>prcCompUrb</th><th scope=col>prcRural</th><th scope=col>prcVictima</th><th scope=col>prcNovictima</th></tr></thead>
<tbody>
	<tr><td>01                 </td><td>Aguascalientes     </td><td>01001              </td><td>Aguascalientes     </td><td>93                 </td><td>  3                </td><td>  4                </td><td>41                 </td><td>59                 </td></tr>
	<tr><td>01                 </td><td>Aguascalientes     </td><td>01002              </td><td>Asientos           </td><td> 0                 </td><td>100                </td><td>  0                </td><td>16                 </td><td>84                 </td></tr>
	<tr><td>01                 </td><td>Aguascalientes     </td><td>01003              </td><td>Calvillo           </td><td> 0                 </td><td> 20                </td><td> 80                </td><td>26                 </td><td>74                 </td></tr>
	<tr><td>01                 </td><td>Aguascalientes     </td><td>01004              </td><td>Cosio              </td><td> 0                 </td><td>  0                </td><td>100                </td><td>17                 </td><td>83                 </td></tr>
	<tr><td>01                 </td><td>Aguascalientes     </td><td>01005              </td><td>Jesus Maria        </td><td>38                 </td><td> 22                </td><td> 41                </td><td>39                 </td><td>61                 </td></tr>
	<tr><td>01                 </td><td>Aguascalientes     </td><td>01006              </td><td>Pabellon de Arteaga</td><td> 0                 </td><td>100                </td><td>  0                </td><td>23                 </td><td>77                 </td></tr>
</tbody>
</table>



  - __Salva de Output__


```R
write.csv(tbase, file = "/home/rosa/Descargas/BASE_DE_DATOS_ENVIPE_2017_en/tb/tbase-envipe.csv", row.names = TRUE)
```
