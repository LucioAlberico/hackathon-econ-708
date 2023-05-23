#Importando Librerias ------------------------------
library(tidyverse)

#Importando CSV --------------------------------------------------------------
indicadores_ganaderos <- read.csv(file = './indicadores_ganaderos_mensuales.csv', check.names=F, fileEncoding="latin1")
indicadores_economicos <- read.csv(file = './indicadores_economicos.csv', check.names=F, fileEncoding="latin1")


#Exploramos la data -----------------------
    ## Indicadores Ganaderos ---------------
    view(indicadores_ganaderos) 
    glimpse(indicadores_ganaderos)
    unique(indicadores_ganaderos$Año) #(rango 2006-2018)
    
    ## Indicadores Economicos ----------------
    view(indicadores_economicos) 
    glimpse(indicadores_economicos)
    unique(indicadores_economicos$indice_tiempo) #rango (2011-07 a 2019-08)

    
#Creando nuevas tablas con variables de interés ---------------
    
  ## Indicadores ganaderos  ------------------------------
    ### Identificando variables de interés --------------------
    #"Producción: En miles de toneladas Eq res  c/h" --> Producción Total
    #"Exportaciones: En toneladas eq res c/h" --> Para medir las exportaciones mensuales
    #"Consumo Interno: Aparente en miles de toneladas eq res c/h" --> Para medir el consumo interno mensual.
    #Para facilitar el analisis, multiplicamos la variable consumo interno por 1000. Para que se exprese en toneladas al igual que las expos.
    #Para facilitar el merge posterior, crearemos una variable nueva llamada indice_tiempo, que siga la forma "Año-Mes"
    
    ### Creando nueva tabla  -------------------
    new_indicadores_ganaderos <- indicadores_ganaderos %>% 
      select("Año", "Mes", "Producción: En miles de toneladas Eq res  c/h", "Consumo Interno: Aparente en miles de toneladas Eq res  c/h", "Exportaciones: En toneladas Eq res  c/h") %>% 
        rename("total_producido" = "Producción: En miles de toneladas Eq res  c/h", "consumo_interno" = "Consumo Interno: Aparente en miles de toneladas Eq res  c/h", "exportaciones" = "Exportaciones: En toneladas Eq res  c/h") %>% 
          mutate(total_producido = total_producido*1000, consumo_interno = consumo_interno*1000, indice_tiempo = paste(Año, ifelse(Mes < 10, paste0("0", Mes), Mes), sep = "-")) %>% 
            select(-c("Año", "Mes"))
    
    #AVISO: total_producido != consumo_interno + exportaciones por cuestiones de aproximación.
            
    view(new_indicadores_ganaderos)
    glimpse (new_indicadores_ganaderos) #Viendo datatypes variables
    
    
  ## Indicadores económicos  ------------------------------
    ### Identificando variables de interés --------------------
      # "dolar($/U$S)" ---> Para ver tipo de cambio
      # "IPIM" --> Indice de precios internos al por mayor
    
    ### Creando nueva tabla  -------------------
    new_indicadores_economicos <- indicadores_economicos %>% 
      select("indice_tiempo", "dolar($/U$S)", "IPIM") %>% 
        rename("dolar" = "dolar($/U$S)")
    view(new_indicadores_economicos)
    glimpse (new_indicadores_economicos) #Viendo datatypes variables
    
    

#Creando dataset para analisis final ------------------
  ##Uniendo las tablas por indice de tiempo ---------------
    tabla_unida <- merge(new_indicadores_economicos, new_indicadores_ganaderos, by = "indice_tiempo") %>% 
     mutate(total_producido = as.integer(total_producido), exportaciones = as.integer(exportaciones))
    #Pasamos los valores a integer para mejorar la visualización de la tabla.
    
  ##Dejando Exportaciones y Consumo Interno como porcentajes relativos -------------------
    tabla_unida <- tabla_unida %>% mutate(consumo_interno_pct = consumo_interno / total_producido, exportaciones_pct = exportaciones / total_producido)
    
    #RECORDAR QUE LOS PORCENTAJES NO VAN A DAR EXACTOS PORQUE EL TOTAL_PRODUCIDO ESTA REDONDEADO
     view(tabla_unida) 
    
#Hipótesis 1 ------------------------------
     ## Parte 1 (IPIM VS CONSUMO Y DOLAR VS EXPOS) ----------------------------
     grafico_1a <- ggplot(tabla_unida, aes(x = dolar, y = exportaciones_pct)) +
       geom_point() +
       geom_smooth(method = "lm", se = FALSE, color = "blue") +
       labs(x = "Dólar", y = "Exportaciones (pct)")
     grafico_1a
     ggsave("grafico_1a.png", plot = grafico_1a, width = 10, height = 8, dpi = 300) #Guardando grafico 1a.
     
     grafico_1b <- ggplot(tabla_unida, aes(x = IPIM, y = consumo_interno_pct)) +
       geom_point() +
       geom_smooth(method = "lm", se = FALSE, color = "green") +
       labs(x = "IPIM", y = "Consumo Interno (pct)")
     grafico_1b
     ggsave("grafico_1b.png", plot = grafico_1b, width = 10, height = 8, dpi = 300) #Guardando grafico 1b.
     
     ## Parte 2 (ANALISIS TEMPORAL) --------------------------
     tabla_unida_2 <- separate(tabla_unida, indice_tiempo, into = c("año", "mes"), sep = "-") #Tuve que volver atras para hacer el analisis temporal
     tabla_unida_2$año <- as.numeric(tabla_unida_2$año)
     tabla_unida_2$mes <- as.numeric(tabla_unida_2$mes)
     view(tabla_unida_2)
     
     grafico_1c <- ggplot(tabla_unida_2, aes(x = año + mes/12)) +
       geom_line(aes(y = consumo_interno_pct, color = "Consumo interno")) +
        geom_line(aes(y = exportaciones_pct, color = "Exportaciones")) +
          labs(x = "Índice de tiempo", y = "Porcentaje relativo (%)", color = "Variable") +
            scale_x_continuous(breaks = seq(2011, 2018, 1))
     grafico_1c <- grafico_1c + geom_vline(xintercept = 2016.01, linetype = "dashed", color = "purple")
     grafico_1c
     ggsave("grafico_1c.png", plot = grafico_1c, width = 10, height = 8, dpi = 300) #Guardando grafico 1c.
   
     
#Hipótesis 2 ------------------------------
    grafico_2 <- ggplot(tabla_unida, aes(x = dolar, y = total_producido)) +
        geom_point() +
          geom_smooth(method = "lm", se = FALSE, color = "red") +
            labs(x = "Dólar", y = "Total producido")
    grafico_2
    ggsave("grafico_2.png", plot = grafico_2, width = 10, height = 8, dpi = 300) #Guardando grafico 2
    
#Calculando la bondad de ajuste.
    modelo <- lm(total_producido ~ dolar, data = tabla_unida) #Calculo regresion lineal
    resumen <- summary(modelo) #Con summary te tira toda la data.
    r_cuadrado <- resumen$r.squared
    f_estadistico <- resumen$fstatistic[1]
    valor_p <- resumen$fstatistic[3]
    
    cat("Coeficiente de determinación (R cuadrado):", r_cuadrado, "\n")
    cat("Estadístico F:", f_estadistico, "\n")
    cat("Valor p:", valor_p, "\n")    
    cat("Por esto decimos que hay mucha variabilidad en las observaciones como para considerar a la regresión lineal como una medida de tendencia correcta.")    