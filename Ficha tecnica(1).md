
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

![Vista previa de la Ficha Tecnica](attachment:Selecci%C3%B3n_088.png "Vista previa de la Ficha Tecnica")


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

  - Población total: Correspondiente a la cantidad total de población que INEGI contabilizó en el Censo, que habita en la demarcación municipal correspondiente
  - Mujeres: Cantidad total de mujeres en el municipio. A partir de la desagregación de estos datos, se calculó la distribución por edad, la cual constityue los siguientes campos:
    1. Menores: Porcentaje de mujeres menores a 18 años
    2. Adultas: Porcentaje de mujeres entre 19 y 60 años
    3. Adultas mayores: Porcentaje de mujeres mayores de 60 años
  - Hombres: Cantidad total de hombres en el municipio. A partir de la desagregación de estos datos, se calculó la distribución por edad, la cual constityue los siguientes campos:
    1. Menores: Porcentaje de hombres menores a 18 años
    2. Adultos: Porcentaje de hombres entre 19 y 60 años
    3. Adultos mayores: Porcentaje de hombres mayores de 60 años

___El código utilizado para obtener la base de datos por municipio, tanto de los datos de CONAPO como de INEGI se encuentra en el link: http://localhost:8888/notebooks/R/Ficha%20tecnica%20INEGI%20%2C%20CONAPO.ipynb___

__ENVIPE I__

Corresponde a la descripción del perfil de población que se utilizó para la consulta de datos, la cual se divide en:

  - __Contexto de la vivienda__: Se refiere al entorno en el cual se encuentra inmersa la vivienda. En la ficha, los datos descriptivos se proporcionan en porcentaje, el cual se desagrega en tres opciones proporcionados por la ENVIPE:
    1. Urbano
    2. Complemento Urbano
    3. Rural

  - __Estatus__: Se refiere a la condición de vulnerabilidad al delito que tienen las personas encuestadas. Dada la diversa gana de situaciones que toma en cuenta INEGI, se limitó el universo de la muestra a _"Encuestas completas"_ de forma que se presenta el porcentaje entre dos categorías:
  
    1. Víctima: Personas que vivieron algún tipo de delito dentro del periodo contemplado en la encuesta (2016-2017)
    2. No víctima: Personas que no vivieron algún tipo de delito

___El código utilizado para obtener la base de datos por municipio de la sección ENVIPE I se encuentra en el link: http://localhost:8888/notebooks/R/Ficha%20tecnica%20INEGI%20%2C%20CONAPO.ipynb___

---

__SEGUNDA SECCIÓN : Incidencia delictiva__

Esta sección corresponde a los datos de denuncias que se han obtenido de los Reportes de incidencia delictiva del Secretariado Ejecutivo; y la finalidad consiste en proporcionar el panorama delictivo de cada municipio. Para ello el tabulado se ha dividido en dos partes principales:

  - __Delitos prioritarios__ : Delitos que la colaboradora de Centro Geo Mtra. Ana Alegre ha identificado como los delitos de mayor relevancia en México, los cuales son:
    - Extorsión
    - Homicidio doloso
    - Secuestro
    
  - __Delitos reincidentes__ : Aquellos tres delitos que se presentaron con mayor frecuencia en el periodo de tiempo estimado

Una vez identificados los delitos, se desagregan las siguientes opciones:

  - __Contexto municipal__: Referente a la tasa de delitos que se presentan por cada 100,00 habitantes dentro del Municipio durante el periodo Julio 2017 a Julio 2018
  - __Contexto estatal__: Referente a la tasa de delitos que se presentan por cada 100,00 habitantes dentro del Estado durante el periodo Julio 2017 a Julio 2018
  - __Incidencia 2016-17__: Indica el total de reportes que se obtuvieron de el delito durante el periodo Julio 2016 a Julio 2017
  - __Incidencia 2017-18__: Indica el total de reportes que se obtuvieron de el delito durante el periodo Julio 2017 a Julio 
  - __Variación__: Porcentaje que representa la diferencia de denuncias entre los periodos Julio 2016-17 y Julio 2017-18. Este es negativo cuando la incidencia se reduce y positivo cuando la incidencia aumenta; y dependiendo del caso puede ser mayor de 100%
