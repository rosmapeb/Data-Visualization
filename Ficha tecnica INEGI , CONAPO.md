
## FICHA TECNICA v1 : INEGI - CONAPO
 __ROSA MARTHA PERALTA BLANCO__
 
 INEGI , CONAPO 
 

------------------------------------------------------

#### Descripción

Código correspondiente a la obtención de datos referentes a las características demográficas y urbanas de los municipios de México, con base en datos de la _Delimitacion de las zonas metropolitanas de México, 2010_ de CONAPO y del SCINCE 2010 de INEGI

#### Inputs

INCLUYE Datos del Censo de Población y Vivienda 2010 y la Delimitación de las zonas metropolitanas de México 2010 y con la estructura subsecuente:


```R
scince <- read.csv("/home/rosa/Descargas/BASE_DE_DATOS_ENVIPE_2017_en/pobmun_scince2010.csv")
```

| Campo|| Descripción|| Tipo || Ejemplo |
| ---------- ||---------- ||---------- |
| __CVEGEO__ || Clave - identificador de INEGI para cada municipio  || Texto || "01001" |
| __NOM_ENT__  || Nombre del estado || Texto || "Aguascalientes" |
| __NOM_MUN__  || Nombre del municipio || Texto || "Aguascalientes" |
| __POB1__  || Población total del municipio || Entero || 797,010 |
| __POB31__  || Población femenina || Entero || 410,581 |
| __POB52__  || Población femenina de 18 años y más|| Entero || 267,883 |
| __POB54__  || Población femenina de 60 años y más|| Entero || 34,037|
| __POB57__  || Población masculina || Entero || 386,429 |
| __POB77__  || Población masculina de 18 años y más|| Entero || 239,828 |
| __POB79__  || Población masculina de 60 años y más|| Entero || 27,248|
| __tipo__  || Tipología de centralidad (CONAPO) || Texto || "Central"|
| __criterio__  || Característica de la centralidad (CONAPO) || Texto || "Conurbación física"|
| __zmetro__  || Zona metropolitana correspondiente (CONAPO) || Texto || "Aguascalientes"|

  - Fórmulas sistematizadas
  
  Script para convertir la clave del INEGI de número (1001) a texto ("01001")


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
  }
  return(estmun)
}
```

  - Preparación de datos


```R
attach(scince)
```


```R
CVEGEO<-claveEntMun(CVEGEO) #CONVERSION A TEXTO DE CAMPO
# Mujeres
mM<-POB31 - POB52
menoresM <- round(((mM) * 100) / POB31,1)
adultosM <- round(((POB31 - (mM + POB54)) * 100) / POB31,1)
mayoresM <- round(((POB54) * 100) / POB31,1)

# Hombres
mH<-POB57 - POB77
menoresH <- round(((mH) * 100) / POB57,1)
adultosH <- round(((POB57 - (mH+ POB79)) * 100) / POB57,1)
mayoresH <- round(((POB79) * 100) / POB57,1)

scince<- data.frame(CVEGEO,POB1,POB31,menoresM,adultosM,mayoresM,POB57,menoresH,adultosH,mayoresH,tipo,criterio,zmetro)
colnames(scince)<-c("conca","pobtot","pobfem","menoresM","adultosM","mayoresM","pobmasc","menoresH","adultosH","mayoresH","tipo","criterio","zmetro")

detach(scince)
```

  - Output SCINCE


```R
head(scince)
```


<table>
<thead><tr><th scope=col>conca</th><th scope=col>pobtot</th><th scope=col>pobfem</th><th scope=col>menoresM</th><th scope=col>adultosM</th><th scope=col>mayoresM</th><th scope=col>pobmasc</th><th scope=col>menoresH</th><th scope=col>adultosH</th><th scope=col>mayoresH</th><th scope=col>tipo</th><th scope=col>criterio</th><th scope=col>zmetro</th></tr></thead>
<tbody>
	<tr><td>01001             </td><td>797010            </td><td>410581            </td><td>34.8              </td><td>57.0              </td><td> 8.3              </td><td>386429            </td><td>37.9              </td><td>55.0              </td><td> 7.1              </td><td>Central           </td><td>Conurbacion física</td><td>Aguascalientes    </td></tr>
	<tr><td>01002             </td><td> 45492            </td><td> 22980            </td><td>41.3              </td><td>50.9              </td><td> 7.8              </td><td> 22512            </td><td>43.9              </td><td>48.1              </td><td> 8.1              </td><td>rural             </td><td>                  </td><td>                  </td></tr>
	<tr><td>01003             </td><td> 54136            </td><td> 27886            </td><td>37.9              </td><td>51.8              </td><td>10.3              </td><td> 26250            </td><td>41.8              </td><td>47.7              </td><td>10.5              </td><td>rural             </td><td>                  </td><td>                  </td></tr>
	<tr><td>01004             </td><td> 15042            </td><td>  7716            </td><td>40.9              </td><td>51.3              </td><td> 7.8              </td><td>  7326            </td><td>43.5              </td><td>48.6              </td><td> 7.9              </td><td>rural             </td><td>                  </td><td>                  </td></tr>
	<tr><td>01005             </td><td> 99590            </td><td> 50500            </td><td>41.3              </td><td>53.2              </td><td> 5.5              </td><td> 49090            </td><td>44.0              </td><td>50.5              </td><td> 5.5              </td><td>Central           </td><td>Conurbacion física</td><td>Aguascalientes    </td></tr>
	<tr><td>01006             </td><td> 41862            </td><td> 21692            </td><td>40.1              </td><td>52.5              </td><td> 7.4              </td><td> 20170            </td><td>42.7              </td><td>50.3              </td><td> 7.0              </td><td>rural             </td><td>                  </td><td>                  </td></tr>
</tbody>
</table>



  - Salva de Output


```R
write.csv(scince, file = "/home/rosa/Descargas/BASE_DE_DATOS_ENVIPE_2017_en/tb/tb_scince-conapo.csv", row.names = TRUE)
```
