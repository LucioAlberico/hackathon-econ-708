# hackathon-econ-708
El siguiente es un proyecto de practica realizado para la materia "Economía y procesamiento de datos no tradicionales", Catedra Victoria Semeshenko.
Grupo 4, Tema A.

## Consigna
Nos fue dado este [dataset](https://www.datos.gob.ar/dataset?tags=bovinos&groups=agri&_tags_limit=0) con la consigna de realizar una analisis exploratorio de los
datos y sacar alguna conclusión que nos pareciera de relevancia.

## Datasets elegidos
Tras realizar un analisis exploratorio de todas las tablas y sus variables, decidimos utilizar las tablas (se encuentran en la carpeta):
* [Indicadores_economicos:](https://www.datos.gob.ar/dataset/agroindustria-ganaderia---indicadores-economicos-bovinos/archivo/agroindustria_a28a3be0-f9a3-4f96-8094-53688135c5ad) Precios de los siguientes insumos y productos ganaderos bovinos: ternero, novillo, maíz, vaca conserva, vaquillona, dólar, IPIM. También se incluyen relaciones insumo/producto y márgenes brutos.
* [Indicadores_ganaderos:](https://www.datos.gob.ar/dataset/agroindustria-ganaderia---indicadores-bovinos-mensuales/archivo/agroindustria_46c21636-2a4d-44a4-a0c6-052836d51a3f) Resumen de los principales indicadores de la actividad del sector bovino nacional. Esta información se presenta en forma mensual.

## Hipótesis 1
Analizar la incidencia del tipo de cambio (dolar) y el IPIM en los porcentajes de la producción que se destinan a consumo interno y a las exportaciones.

Si sube más el IPIM que el tipo de cambio --> ¿Mayor porcentaje de la producción es destinado a consumo interno?

Si sube más el tipo de cambio que el IPIM --> ¿Mayor porcentaje de la producción es destinado a exportaciones?

[IPIM](https://www.indec.gob.ar/ftp/cuadros/economia/sint_met_sipm.pdf) --> Tiene por objeto medir la evolución promedio de los precios a los que el productor y/o importador directo vende sus productos en el mercado doméstico.

### Variables de Interés
* IPIM y Dolar
* Consumo Interno y Exportaciones, expresado como porcentajes relativos. Consumo Interno (%) = Consumo Interno / Consumo Interno + Exportaciones

**Análisis**:
* Análsis de regresión entre el IPIM y el Consumo Interno (expresado en pct).
* Análisis de regresión entre Dólar y Exportaciones (expresadas en pct).

### Conclusión 1 (Primera Parte)
Al ver el [grafico_1a](https://raw.githubusercontent.com/LucioAlberico/hackathon-econ-708/main/grafico_1a.png) (relación entre el Dólar y las Exportaciones) podemos pensar que nuestra hipótesis es correcta. Sin embargo, analizando el [grafico_1b](https://raw.githubusercontent.com/LucioAlberico/hackathon-econ-708/main/grafico_1b.png) (relación entre el IPIM y el Consumo Interno) nos damos cuenta que *la correlacion entre el dolar y las exportaciones parece estar dada por una coincidencia temporal ya que la contraparte del supuesto (correlacion positiva entre IPIM y Consumo Interno) no se cumple*. Llegamos a esta conclusión porque consideramos que el aumento constante del IPIM y el tipo de cambio esta dado por la inflación, una variable fuertemente ligada al paso del tiempo.


### Conclusión 2 (Segunda Parte)
Nuevo Analisis: Buscamos comprender si hay algun tipo de relación temporal entre las variaciones porcentuales que se le

* Analsis temporal del consumo interno y las exportaciones FALTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

## Hipótesis 2
Analizar como influye el tipo de cambio en la produccion total. ¿A mayor tipo de cambio más producción?. 

### Variables de interés
Para analizar esto haremos un analisis de regresion entre la variable "total producido" y "dolar".

### Conclusión 2
A partir del analisis visual que nos brinda el [grafico 2](https://raw.githubusercontent.com/LucioAlberico/hackathon-econ-708/main/grafico_2.png) (Relación entre total producido y valor del tipo de cambio). Podemos ver que *existe una correlación positiva entre el tipo de cambio y el total producido*. De todas maneras, existe mucha variación entre el total producido a mismos niveles de dolar como para considerarlo un análisis concluyente.



## Aclaraciones
* Debido a la falta de tiempo, no pudimos realizar un análisis completo, pero comprendemos que deberiamos incluir datos acerca de la inflación, las restricciones por parte del gobierno a las exportaciones y los precios internacionales de las commodities (principalmente del ganado) para realizar un analisis concluyente.
* DESCARGAR GRAFICOS PARA MEJOR VISUALIZACIÓN.
* Para fines presentativos hubiese sido mejor utilizar jupyter notebook, pero no nos dio el tiempo.
