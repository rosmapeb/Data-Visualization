
## FICHA TECNICA v1
 __ROSA MARTHA PERALTA BLANCO__

------------------------------------------------------

#### Introducción

El código que se presenta a continuación, fue elaborado con la finalidad de generar una ficha técnica para la aplicación de delincuencia de CentroGeo. Dicho documento pretende dar un panorama de la situación a la que los ciudadanos mexicanos se enfrentan en ca uno de los municipios de la República Mexicana. 

Para ello, se obtuvo información de bases de datos de tres principales instituciones gubernamentales, las cuales se describen a continuación:

1. __INEGI-SCINCE__ : Datos del SCINCE 2010 de la escala municipal, la cual permitió obtener datos alusivos a la estructura demográfica de los municipios. http://www.inegi.org.mx/est/scince/scince2010.aspx
2. __INEGI-ENVIPE2017__ : Datos de la _Encuesta Nacional de Victimización y Percepción sobre Seguridad Pública 2017_, de la cual se obtuvieron datos descriptivos de las encuestas, así como de Percepción del entorno, Autoridades, Delitos y Procesos de denuncia. http://www.beta.inegi.org.mx/proyectos/enchogares/regulares/envipe/2017/ . Cabe resaltar que esta encuesta no tiene datos para determinados municipios, debido a que no se seleccionaron en la metogología de INEGI
3. __SECRETARIADO EJECUTIVO__ : Organismo dependiente de la Secretaría de Gobernación, el cual a través de los _Reportes de incidencia delictiva_ de 2015 a Julio de 2018 se obtuvieron datos de la cantidad de averiguaciones iniciadas o carpetas de investigación que reportan las Procuradurías de Justicia y Fiscalías Generales de cada Estado. http://secretariadoejecutivo.gob.mx/incidencia-delictiva/incidencia-delictiva-datos-abiertos.php
4. __CONAPO__ : Datos de la _Delimitacion de las zonas metropolitanas de México, 2010_ de la cual se obtuvo la distribución de paisaje urbano y rural a partir de Tipo de centralidad, Zona Metropolitana y Criterio de centralidad http://www.conapo.gob.mx/es/CONAPO/Zonas_metropolitanas_2010

#### Descripción de OUTPUT

La ficha que se elaboró se divide en cuatro secciones:

- __Datos descriptivos__: Datos del SCINCE, ENVIPE y CONAPO que proporcionan el perfil geográfico de cada municipio
- __Incidencia delictiva__: Datos del Secretariado ejecutivo que proporcionan el contexto de las denuncias
- __ENVIPE__: Datos de la ENVIPE que proporcionan las principales opiniones de la ciudadanía respecto a Consuctas delictivas, Problemas relevantes, así como Confianza y Despeño de las autoridades
- __Delincuencia__: Datos de la ENVIPE que proporcionan la percepción de la ciudadanía respecto al Horario y Daño de los delitos, así como el tiempo empleado y el trato recibido en el Proceso de denuncia

Con base en estas secciones, a continuación se explicará a detalle el _output_ final:

<center>![seleccion_091](https://user-images.githubusercontent.com/22421174/47517546-1bc8e700-d84e-11e8-9870-de20d3713866.png)</center>

#### PRIMERA SECCIÓN: Datos descriptivos

La finalidad de este apartado es dar un panorama general de las condiciones geográficas, demográficas y sociales del municipio. Este a su vez se divide en tres partes:

__DATOS BASE__

Este contiene datos para comprender el contexto urbano-rural, el cual utiliza como identificador la __clave INEGI__ que le ha sido asignada, y adicionalmente la _Delimitacion de las zonas metropolitanas de México, 2010_ del Consejo Nacional de Población (CONAPO).

Al respecto de ello, el CONAPO refiere que ..."_el proceso de desarrollo metropolitano tiende a generalizarse en el territorio con el surgimiento y consolidación de una diversidad de zonas metropolitanas de distintos tamaños de población y extensión territorial que se suman a las que tradicionalmente habían predominado en el panorama nacional (Valle de México, Guadalajara y Monterrey), generando nuevas centralidades regionales y subregionales_" (CONAPO,2014:15).

De esta forma la condición urbana de México se comprende a partir del grado de "Centralidad" que presenta un municipio, la cual se describe con tres incisos:  
        


- __Tipo__ : Se refiere a la tipología de centralidad que presenta el municipio. Al respecto pueden identificarse dos categorías:

  1. __*Central*__: "Municipios donde se localiza la ciudad central que da origen a la zona metropolitana" (CONAPO, 2010 : 24). Se identifican por:
    - Compartir __unión física__ entre dos o más localidades geoestadísticas urbanas de diferentes municipios, cuya población en conjunto asciende a 50,000 o más hab. o posean características urbanas(unión entre localidades geoestadísticas urbanas a la continuidad en la conformación de amanzanamiento)
    - Municipios con localidades de 50,000 o más habitantes con __alto grado de integración física y funcional__ con municipios vecinos urbanos.
    - Municipios con ciudades de __un millón o más habitantes__.
    - Municipios con ciudades que forman parte de una __zona metropolitana transfronteriza__ con 250,000 o más hab.
  
  2. __*Exterior*__: "Municipios contiguos a los centrales, cuyas localidades geoestadísticas urbanas no están conurbadas a la ciudad central, pero manifiestan un carácter predominantemente urbano, al tiempo que mantienen un alto grado de integración funcional con los municipios centrales de la zona metropolitana, determinados a través del cumplimiento de las siguientes condiciones":
    - __Distancia a la ciudad central__: ubicada a menos de 10 km por carretera pavimentada y de doble carril de los límites de la ciudad central.
    - __Integración funcional por lugar de trabajo__: Al menos 15% de la población ocupada residente trabaja en los municipios centrales de la zona metropolitana, o 10% de la población que trabaja en el municipio reside en los municipios centrales de esta última.
    - __Población ocupada en actividades no primarias__: Población ocupada en actividades secundarias y terciarias mayor o igual a 75%
    - __Densidad media urbana__: Por lo menos 20 habitantes por hectárea


- __Zona Metropolitana__ : "Tomando como punto de partida las 56 zonas metropolitanas definidas con base en información de 2005, y con base en el análisis del Marco Geoestadístico Nacional y los resultados por localidad del Censo de Población y Vivienda 2010, se identificaron las conurbaciones y ciudades mayores a 50 mil habitantes, que conformarían las ciudades centrales que dan origen a las zonas metropolitanas. Con este procedimiento se identificó un total de 59 ciudades centrales, las cuales pueden clasificarse en cuatro grupos" (CONAPO, 2010: 29).

- __Criterio de centralidad__ : Con base en las características que cumplen los tipos de centralidad, presentan la siguiente distribución de caracteristicas:

| Municipios centrales|| Municipios exteriores |
| ---------- ||---------- |
| Integración funcional  || Integración funcional  |
| Política urbana  || Política urbana   |
| Conurbación física  ||    |
| Mas de 1,000,000 hab  ||   |

__INEGI__

Contiene datos del _Sistema para la consulta de información censal_ del Censo de Población y Vivienda 2010, los cuales fueron obtenidos a partir de variables continuas por municipio. Los datos que se proporcionan son los siguientes:

  - __Población total__: Correspondiente a la cantidad total de población que INEGI contabilizó en el Censo, que habita en la demarcación municipal correspondiente
  - __Mujeres__: Cantidad total de mujeres en el municipio. A partir de la desagregación de estos datos, se calculó la distribución por edad, la cual constityue los siguientes campos:
    1. __Menores__: Porcentaje de mujeres menores a 18 años
    2. __Adultas__: Porcentaje de mujeres entre 19 y 60 años
    3. __Adultas mayores__: Porcentaje de mujeres mayores de 60 años
  - __Hombres__: Cantidad total de hombres en el municipio. A partir de la desagregación de estos datos, se calculó la distribución por edad, la cual constityue los siguientes campos:
    1. __Menores__: Porcentaje de hombres menores a 18 años
    2. __Adultos__: Porcentaje de hombres entre 19 y 60 años
    3. __Adultos mayores__: Porcentaje de hombres mayores de 60 años

___El código utilizado para obtener la base de datos por municipio, tanto de los datos de CONAPO como de INEGI se encuentra en el link: https://github.com/rosmapeb/Data-Visualization/blob/master/Ficha%20tecnica%20INEGI%20%2C%20CONAPO.md___

__ENVIPE I__

Corresponde a la descripción del perfil de población que se utilizó para la consulta de datos, la cual se divide en:

  - __Contexto de la vivienda__: Se refiere al entorno en el cual se encuentra inmersa la vivienda. En la ficha, los datos descriptivos se proporcionan en porcentaje, el cual se desagrega en tres opciones proporcionados por la ENVIPE:
    1. Urbano
    2. Complemento Urbano
    3. Rural

  - __Estatus__: Se refiere a la condición de vulnerabilidad al delito que tienen las personas encuestadas. Dada la diversa gana de situaciones que toma en cuenta INEGI, se limitó el universo de la muestra a _"Encuestas completas"_ de forma que se presenta el porcentaje entre dos categorías:
  
    1. Víctima: Personas que vivieron algún tipo de delito dentro del periodo contemplado en la encuesta (2016-2017)
    2. No víctima: Personas que no vivieron algún tipo de delito

___El código utilizado para obtener la base de datos por municipio de la sección ENVIPE I se encuentra en el link: https://github.com/rosmapeb/Data-Visualization/blob/master/Ficha%20tecnica%20ENVIPE%20I.md___

---

__SEGUNDA SECCIÓN : Incidencia delictiva__

Esta sección corresponde a los datos de denuncias que se han obtenido de los Reportes de incidencia delictiva del ___Secretariado Ejecutivo___; la finalidad consiste en proporcionar el panorama delictivo de cada municipio. Para ello, el tabulado se ha dividido en dos partes principales:

  - __Delitos prioritarios__ : Delitos que la colaboradora de CentroGeo Mtra. Ana Alegre ha identificado como los delitos de mayor relevancia en México, los cuales son:
    - Extorsión
    - Homicidio doloso
    - Secuestro
    
  - __Delitos reincidentes__ : Aquellos tres delitos que se presentaron con mayor frecuencia en el periodo de tiempo establecido

Una vez identificados los delitos, se desagregan las siguientes opciones:

  - __Contexto municipal__: Referente a la tasa de delitos que se presentan por cada 100,000 habitantes dentro del Municipio durante el periodo Julio 2017 a Julio 2018
  - __Contexto estatal__: Referente a la tasa de delitos que se presentan por cada 100,000 habitantes dentro del Estado durante el periodo Julio 2017 a Julio 2018
  - __Incidencia 2016-17__: Indica el total de reportes que se obtuvieron de el delito durante el periodo Julio 2016 a Julio 2017
  - __Incidencia 2017-18__: Indica el total de reportes que se obtuvieron de el delito durante el periodo Julio 2017 a Julio 
  - __Variación__: Porcentaje que representa la diferencia de denuncias entre los periodos Julio 2016-17 y Julio 2017-18. Este es _negativo_ cuando la incidencia se reduce y _positivo_ cuando la incidencia aumenta; de forma adicional, y dependiendo del caso puede ser mayor de 100%

_Nueva metodología_

A partir de Enero del 2015 se implementó un nuevo metodo para registrar y clasificar delitos y víctimas, la cual dispone de ... "información de incidencia delictiva para los ámbitos estatal y municipal... [y de] ... información de víctimas para los delitos de homicidio, secuestro, extorsión, lesiones, corrupción de menores, tráfico de menores, rapto y trata de personas; así como para unidades robadas de vehículos y tractores" (Secretariado, s/f).

De esta forma, los delitos fueron clasificados en siete tipos de Bienes jurídicos afectados, los cuales se subdividen a su vez en Tipos, Subtipos y Modalidad, para mayor precisión en la descripción del delito.

Resultado de esta metodología, en el contexto nacional los datos obtenidos indican que los delitos con mayor incidencia desde el 2016 hasta el 2018 son:
  - Robo
  - Lesiones
  - Violencia familiar
  - Otros delitos del Fuero Común
  - Daño a la propiedad
  - Amenazas
  - Fraude
  - Narcomenudeo
  - Homicidio doloso
  - Despojo
  - Incumplimiento familiar

La distribución de las denuncias según el delito para los periodos Julio 2016-17 y Julio 2017-18 es la siguiente:

<center>![comparativo](https://user-images.githubusercontent.com/22421174/47382886-fc548180-d6c8-11e8-9644-efa65e9a167b.png)</center>

_Asignación de clave_

Para poder procesar los datos se asignó una clave de identificación, la cual se integra con los prefijos del _Bien jurídico afectado_ (BJA) y el _tipo_ de delito, debido a que el análisis elaborado para la ficha únicamente contempla hasta el tipo de delitos

| PAT || Bien jurdico afectado: EL PATRIMONIO |
| --- | --- | --- |
| _PATabc_ || Abuso de confianza |
| _PATdap_ || Daño a la propiedad |
| _PATdes_ || Despojo |
| _PAText_ || Extorsion |
| _PATfra_ || Fraude |
| _PATrob_ || Robo |
| _PATopa_ || Otros delitos contra el patrimonio |
| __FAM__ || __BJA: LA FAMILIA__ |
| _FAMcom_ || Corrupcion de menores |
| _FAMiof_ || Incumplimiento de obligaciones de asistencia familiar |
| _FAMtpe_ || Trata de personas |
| _FAMvgt_ || Violencia de genero distinta a la violencia familiar |
| _FAMvfa_ || Violencia familiar |
| _FAMola_ || Otros delitos contra la familia |
| __LSS__ || __BJA: LA LIBERTAD Y LA SEGURIDAD SEXUAL__ |
| _LSSabs_ || Abuso sexual |
| _LSSacs_ || Acoso sexual |
| _LSShos_ || Hostigamiento sexual |
| _LSSinc_ || Incesto |
| _LSSveq_ || Violacion equiparada |
| _LSSvsi_ || Violacion simple |
| _LSSols_ || Otros delitos que atentan contra la libertad y la seguridad sexual |
| __SOC__ || __BJA: LA SOCIEDAD__ |
| _SOCcom_ || Corrupcion de menores |
| _SOCtpe_ || Trata de personas |
| _FAMoso_ || Otros delitos contra la sociedad |
| __VIC__ || __BJA: LA VIDA Y LA INTEGRIDAD CORPORAL__ |
| _VICabo_ || Aborto |
| _VICfem_ || Feminicidio |
| _VIChom_ || Homicidio |
| _VICles_ || Lesiones |
| _VICoic_ || Otros delitos que atentan contra la vida y la integridad corporal |
| __LPE__ || __BJA: LIBERTAD PERSONAL__ |
| _LPErap_ || Rapto |
| _LPEsec_ || Secuestro |
| _LPEtme_ || Trafico de menores |
| _LPEolp_ || Otros delitos que atentan contra la libertad personal |
| __OBJ__ || __BJA: OTROS BIENES JURIDICOS AFECTADOS__ |
| _OBJalm_ || Allanamiento de morada |
| _OBJame_ || Amenazas |
| _OBJcma_ || Contra el medio ambiente |
| _OBJdsp_ || Delitos cometidos por servidores públicos |
| _OBJele_ || Electorales |
| _OBJevp_ || Evasion de presos |
| _OBJfal_ || Falsedad |
| _OBJfas_ || Falsificacion |
| _OBJnar_ || Narcomenudeo |
| _OBJofu_ || Otros delitos del Fuero Comun |

___El código utilizado para obtener la base de datos por municipio correspondientes al Secretariado se encuentran en el link: https://github.com/rosmapeb/Data-Visualization/blob/master/Ficha%20tecnica%20Secretariado%20ejecutivo.md___

---

__SEGUNDA SECCIÓN : ENVIPE__

Esta sección corresponde a los datos de la _Encuesta Nacional de Victimización y Percepción sobre Seguridad Pública 2017_ en la cual se reunen datos de Percepción del entorno y de Autoridades.

__Percepción del entorno__

  - __Conductas delictivas__: Se refiere a las conductas consideradas antisociales mas frecuentes en el entorno inmediato de las personas encuestadas, los datos proporcionados son:
    1. Tipo de conducta
    2. Cantidad: Indica el número de población que consideró que la conducta antisocial elegida se realilza en su entorno y representa preocupación para ella.


<center>![conductas](https://user-images.githubusercontent.com/22421174/47517581-45820e00-d84e-11e8-8fa1-43c7bffc43bc.png)</center>

  - __Problemas relevantes__: Se refiere a los temas de mayor preocupación en México a opinión de los encuestados, los datos proporcionados son:
    1. Problema
    2. Cantidad: Indica el número de población que consideró al problema como de mayor trascendencia en México

<center>![problemas](https://user-images.githubusercontent.com/22421174/47517591-4d41b280-d84e-11e8-8162-e86399ac7760.png)</center>

__Autoridades__

  - __Confianza__: Se refiere a cuales son las autoridades con mayor porcentaje de confianza. En este sentido, los datos que se proporcionan son:
    1. Autoridad
    2. Nivel de confianza: Obtenido de variables de contraste proporcionadas por INEGI. La clasificación cualitativa tiene los tópicos _Mucha_, _Alguna_, _Poca_, _Nada_, _No sabe / No responde_
    3. Porcentaje de confianza: Se refiere al porcentaje de población por cada municipio con la misma opinión hacia la autoridad referida

<center>![confianza](https://user-images.githubusercontent.com/22421174/47517609-592d7480-d84e-11e8-8629-0a066f50423d.png)</center>

  - __Desempeño__: Se refiere a las autoridades con el mayor porcentaje de efectividad percibido por las personas encuestadas, los datos porporcionados son:
    1. Autoridad
    2. Nivel de desempeño: Clasificación cualitativa de INEGI en la cual se consideran las clases: _Muy efectivo_ (Mucho), _Algo efectivo_, _Poco efectivo_, _Nada efectivo_, _No sabe / No responde_
    3. Porcentaje de desempeño: Se refiere al porcentaje de población por cada municipio con la misma opinión hacia la autoridad referida

<center>![desempeno](https://user-images.githubusercontent.com/22421174/47517615-5f235580-d84e-11e8-9933-7377406aa812.png)</center>

___El código utilizado para obtener la base de datos por municipio correspondientes al ENVIPE II Entorno y autoridades se encuentran en el link: https://github.com/rosmapeb/Data-Visualization/blob/master/Ficha%20tecnica%20ENVIPE%20II%20Entorno%20y%20Autoridades.md___

---

__TERCERA SECCIÓN : ENVIPE III__

Esta sección corresponde a los datos de la _Encuesta Nacional de Victimización y Percepción sobre Seguridad Pública 2017_ en la cual se reunen datos relacionados con los delitos y el proceso de denuncia de las víctimas.

__Víctimas y delito__

  - __Horario__: Se refiere a la parte del día en la que fueron cometidos los delitos y se encuentran representados en porcentaje, los horarios son:
    1. Mañana (de 6:01 a 12:00 hrs)
    2. Tarde (de 12:01 a 18:00 hrs)
    3. Noche (de 18:01 a 24:00 hrs)
    4. Madrugada (de 00:01 a 6:00 hrs)

<center>![horario del delito](https://user-images.githubusercontent.com/22421174/47531159-65c3c400-d872-11e8-8459-c785370f2645.png)</center>

  - __Daño__: Se refiere al tipo de pérdida ocasionada por el delito. Esta puede ser:
    1. Económica
    2. Emocional
    3. Física
    4. Laboral

<center>![danos](https://user-images.githubusercontent.com/22421174/47531173-6c523b80-d872-11e8-82a3-fd67864f3881.png)</center>

__Proceso de denuncia__

  - __Tiempo empleado__: Se refiere a las horas que le tomó a la victima realizar la denuncia correspondiente ante el MP. Las categorías son:
    1. Menor a 1 hora
    2. Entre 1 y 2 horas
    3. Entre 3 y 4 horas
    4. Mayor a 4 horas

<center>![tiempo](https://user-images.githubusercontent.com/22421174/47531179-72e0b300-d872-11e8-8521-2d597f9f3777.png)</center>

  - __Trato recibido__: Se refiere al trato que se recibió por parte del MP durante el proceso de denuncia, y puede ser:
    1. Excelente
    2. Bueno
    3. Malo
    4. Muy malo

<center>![trato](https://user-images.githubusercontent.com/22421174/47531185-770cd080-d872-11e8-826b-5cfe16cd71d1.png)</center>

___El código utilizado para obtener la base de datos por municipio correspondientes al ENVIPE III Delito y proceso de denuncia se encuentran en el link: https://github.com/rosmapeb/Data-Visualization/blob/master/FICHA%20TECNICA%20v1%20ENVIPE%20III%20DELITO%20Y%20PROCESO%20DE%20DENUNCIA.md___
