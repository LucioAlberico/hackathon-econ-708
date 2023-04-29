# hackathon-econ-708
El siguiente es un proyecto de practica realizado para la materia "Economía y procesamiento de datos no tradicionales", Catedra Victoria Semeshenko.
Grupo 4, Tema A.

## Consigna
Nos fue dado este <a href="(https://www.datos.gob.ar/dataset?tags=bovinos&groups=agri&_tags_limit=0" target="_blank">dataset</a>


[dataset](https://www.datos.gob.ar/dataset?tags=bovinos&groups=agri&_tags_limit=0) acerca de la producción bovina y agricola con la consigna de realizar una analisis exploratorio de los datos y sacar alguna conclusión que nos pareciera de relevancia. 

Para poder seguir de mejor manera el análisis realizado recomendamos descargar el script de R y correrlo en su computadora. Los nombres de cada gráfico están al final del documento.

## Datasets elegidos
Tras realizar un análisis exploratorio de todas las tablas y sus variables, decidimos utilizar las siguientes tablas (se encuentran en la carpeta):
* [Indicadores_economicos:](https://www.datos.gob.ar/dataset/agroindustria-ganaderia---indicadores-economicos-bovinos/archivo/agroindustria_a28a3be0-f9a3-4f96-8094-53688135c5ad) Precios de los siguientes insumos y productos ganaderos bovinos: ternero, novillo, maíz, vaca conserva, vaquillona, dólar, IPIM. También se incluyen relaciones insumo/producto y márgenes brutos.
* [Indicadores_ganaderos:](https://www.datos.gob.ar/dataset/agroindustria-ganaderia---indicadores-bovinos-mensuales/archivo/agroindustria_46c21636-2a4d-44a4-a0c6-052836d51a3f) Resumen de los principales indicadores de la actividad del sector bovino nacional. Esta información se presenta en forma mensual.

## Hipótesis 1
Analizar la incidencia del tipo de cambio (dólar) y el IPIM en los porcentajes de la producción que se destinan a consumo interno y a las exportaciones.

Si sube el IPIM --> ¿Mayor porcentaje de la producción es dedicado al consumo interno?

Si sube el dólar --> ¿Mayor porcentaje de la producción es destinado a exportaciones?

[IPIM](https://www.indec.gob.ar/ftp/cuadros/economia/sint_met_sipm.pdf) --> Indice de Precios Internos al por Mayor. Tiene por objeto medir la evolución promedio de los precios a los que el productor y/o importador directo vende sus productos en el mercado doméstico.

### Variables de Interés
* IPIM y Dólar.
* Consumo Interno y Exportaciones, expresado como porcentajes relativos. Consumo Interno (%) = Consumo Interno / Producción Total.

**Análisis**:
* Análisis de regresión entre el IPIM y el Consumo Interno (expresado en pct).
* Análisis de regresión entre Dólar y las Exportaciones (expresadas en pct).

### Conclusión 1 (Primera Parte)
Al ver el [grafico_1a](https://raw.githubusercontent.com/LucioAlberico/hackathon-econ-708/main/grafico_1a.png) podemos pensar que nuestra hipótesis es correcta. Sin embargo, analizando el [grafico_1b](https://raw.githubusercontent.com/LucioAlberico/hackathon-econ-708/main/grafico_1b.png) nos damos cuenta que **la correlacion entre el dolar y las exportaciones parece estar dada por una coincidencia temporal ya que la contraparte del supuesto (correlacion positiva entre IPIM y Consumo Interno) no se cumple**. Llegamos a esta conclusión porque consideramos que el aumento constante del IPIM y el tipo de cambio esta dado por la inflación, una variable fuertemente ligada al paso del tiempo.


### Conclusión 1 (Segunda Parte)
**Nuevo Analisis**: Buscamos comprender si hay algun tipo de relación temporal entre las variaciones relativas de las Exportaciones y el Consumo Interno. ¿Que factores que no tomamos en cuenta incidieron?

**Variables de Interés**: Consumo Interno, Exportaciones, Indice Temporal.

**Conclusión**: Como vemos en el [grafico 1c](https://raw.githubusercontent.com/LucioAlberico/hackathon-econ-708/main/grafico_1c.png), Enero de 2016 es un punto de inflexión en el cual comienzan a bajar el consumo interno y a subir las exportaciones. Esto coincide con el comienzo del mandato de Mauricio Macri. **Consideramos que otras variables no tenidas en cuenta que podrían haber influido son: el cepo cambiario, las restricciones del gobierno sobre las exportaciones y los precios internacionales de las commodities**.

Sobre el cepo, podemos ver como el comienzo de la serie coincide con el inicio del cepo cambiario ([28 de octubre 2011](https://www.iprofesional.com/economia/350624-el-cepo-al-dolar-de-cristina-cumplio-10-anos-asi-se-gesto)) y el comienzo del punto de inflexión en el que aumentaron las exportaciones coincide con la [eliminación del cepo cambiario](https://www.cronista.com/finanzas-mercados/Prat-Gay-anuncio-el-fin-del-cepo-al-dolar-y-la-unificacion-del-tipo-de-cambio-20151216-0095.html). 

Por otro lado,  ni bien comenzó el mandato de Macri se le dieron mayores libertades a los exportadores, eliminando [impuestos](https://www.reuters.com/article/latinoamerica-economia-argentina-retenci-idLTAKBN0TX1GP20151215) y [retenciones](https://www.pagina12.com.ar/diario/economia/2-288230-2015-12-14.html) agricolas.

Para analizar el precio de los commodities, deberiamos utilizar una serie historica que registre mensualmente la variaciones de los precios en las cabezas de ganado desde 2011 hasta 2018 (años analizados).

## Hipótesis 2
Analizar como influye el tipo de cambio en la producción total --> ¿A mayor tipo de cambio más producción?. 

### Variables de interés y Análisis
Haremos un analisis de regresión entre la variable "total producido" y "dolar".

### Conclusión 2
A partir del analisis visual que nos brinda el [grafico 2](https://raw.githubusercontent.com/LucioAlberico/hackathon-econ-708/main/grafico_2.png). Podemos ver que **existe una correlación positiva entre el tipo de cambio y el total producido**. De todas maneras, existe mucha variación entre el total producido a mismos niveles de dólar como para considerarlo un análisis concluyente.


## Graficos
* Grafico 1a: Relación entre el tipo de cambio y las Exportaciones.
* Grafico 1b: Relacion entre el IPIM y el Consumo Interno.
* Grafico 1c: Progresión temporal del porcentaje de producción destinado al Consumo Interno y a las Exportaciones.
* Grafico 2: Relación entre el total producido y el tipo de cambio.


## Aclaraciones
Por falta de tiempo:
* No pudimos realizar un análisis completo, pero comprendemos que deberiamos incluir datos acerca de la inflación, las restricciones por parte del gobierno a las exportaciones y los precios internacionales de las commodities (principalmente del ganado) para realizar un analisis concluyente. Somos concientes de que las notas de diario no pueden ser consideradas de ninguna manera fuentes oficiales o veridicas de datos. Las utilizamos simplemente para dar contexto historico.
* No pudimos utilizar Jupyter Notebook para la presentación, lo que nos hubiese permitido integrar los gráficos a las respuestas.
* En el grafico 1c hubiese quedado mejor que calculemos primero la variacion año a año de las exportaciones y el consumo interno, para ver el cambio.
* No pudimos agregar un análisis matematico de las variaciones y nos enfocamos solo en lo visual.
