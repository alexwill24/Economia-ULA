# 📈 Análisis de Series Temporales: Economía Argentina

Análisis econométrico exhaustivo de indicadores económicos argentinos utilizando modelos ARIMA y técnicas de descomposición temporal.

---

## 📂 Contenido del Proyecto

### Archivos Principales

| Archivo | Descripción | Tipo |
|---------|-------------|------|
| `analisis-inflacion-arima-final.Rmd` | Modelo ARIMA completo de inflación mensual | R Markdown |
| `analisis-inflacion-arima.Rmd` | Versión preliminar del análisis ARIMA | R Markdown |
| `modelo-deterministico-inflacion.R` | Modelos determinísticos (dicotómico/trigonométrico) | R Script |
| `modelo-deterministico-tasa-interes.R` | Análisis de tasa de interés efectiva | R Script |
| `significancia-individual.R` | Pruebas de significancia de parámetros | R Script |

### Estructura de Carpetas

```
01-series-temporales-argentina/
├── README.md (este archivo)
├── analisis-inflacion-arima-final.Rmd
├── analisis-inflacion-arima.Rmd
├── modelo-deterministico-inflacion.R
├── modelo-deterministico-tasa-interes.R
├── significancia-individual.R
├── data/
│   ├── datos-series-tiempo-argentina.xlsx
│   └── tasa-interes-efectiva-argentina.xlsx
└── outputs/
    ├── graficos/
    └── resultados/
```

---

## 🎯 Objetivos del Análisis

1. **Modelar la inflación argentina** (1970-2025) usando metodología Box-Jenkins
2. **Analizar tasas de interés efectivas** de política monetaria
3. **Comparar modelos determinísticos vs estocásticos**
4. **Generar pronósticos** con intervalos de confianza
5. **Validar supuestos** de los modelos econométricos

---

## 🔬 Metodología

### 1. Análisis ARIMA (Box-Jenkins)

**Pasos implementados:**

**A. Identificación**
- Visualización de la serie original
- Prueba de estacionariedad (Test ADF)
- Análisis de autocorrelaciones (ACF/PACF)
- Diferenciación de la serie (si es necesario)

**B. Estimación**
- Selección automática de orden ARIMA(p,d,q)
- Criterios de información: AIC, BIC
- Estimación de parámetros por máxima verosimilitud

**C. Validación**
- Test de Ljung-Box (autocorrelación residual)
- Test de Shapiro-Wilk (normalidad de residuos)
- Análisis de residuos estandarizados

**D. Pronóstico**
- Proyección h periodos adelante
- Intervalos de confianza al 95%

### 2. Modelos Determinísticos

**Técnicas aplicadas:**

**Descomposición Clásica:**
- Multiplicativa: Y_t = T_t × S_t × I_t
- Aditiva: Y_t = T_t + S_t + I_t

**Descomposición STL:**
- Seasonal-Trend decomposition using Loess
- Robusta a outliers

**Regresión con Variables Estacionales:**
- Dicotómica: Variables dummy mensuales
- Trigonométrica: Funciones seno/coseno
- Combinaciones de tendencia + estacionalidad

---

## 📊 Resultados Principales

### Análisis de Inflación Mensual Argentina

**Serie analizada:**
- Periodo: Julio 1970 - Actualidad
- Frecuencia: Mensual
- Observaciones: 600+ datos

**Modelo óptimo seleccionado: ARIMA(5,1,4)**

**Prueba de Estacionariedad:**
```
Test ADF (serie diferenciada):
H0: Serie no estacionaria
p-value < 0.05 → Rechazamos H0
Conclusión: Serie es estacionaria tras una diferenciación
```

**Métricas de Ajuste:**
| Métrica | Valor | Interpretación |
|---------|-------|----------------|
| ME | ≈ 0 | Sin sesgo sistemático |
| RMSE | Bajo | Buen ajuste global |
| MAE | Bajo | Error absoluto aceptable |
| MAPE | Alto | Posibles outliers |
| MASE | < 1 | Mejor que modelo naive |
| ACF1 | ≈ 0 | Sin autocorrelación residual |

**Pronóstico:**
- Horizonte: 100 meses adelante
- Intervalo de confianza: 95%
- Validado con pruebas diagnósticas

### Análisis de Tasa de Interés Efectiva

**Modelos comparados:**
1. Descomposición multiplicativa/aditiva
2. Regresión dicotómica (medias estacionales)
3. Regresión trigonométrica (armónicos)
4. Modelo sinusoidal completo

**Comparación de MSE/MAE:**
- Modelo sinusoidal mostró mejor ajuste
- Criterios AIC/BIC confirman parsimonia

---

## 🛠️ Librerías Utilizadas

```r
# Análisis de series temporales
library(forecast)      # Modelado ARIMA y pronósticos
library(tseries)       # Pruebas de estacionariedad
library(TSA)           # Time Series Analysis

# Visualización
library(ggplot2)       # Gráficos avanzados
library(plotly)        # Gráficos interactivos

# Manipulación de datos
library(readxl)        # Importar archivos Excel
library(dplyr)         # Transformación de datos

# Pruebas estadísticas
library(lmtest)        # Tests de modelos lineales
library(nortest)       # Tests de normalidad
library(fGarch)        # Modelos GARCH
library(FinTS)         # Análisis financiero
```

---

## 📥 Fuentes de Datos

**Inflación mensual:**
- Fuente: Instituto Nacional de Estadística y Censos (INDEC)
- Archivo: `data/datos-series-tiempo-argentina.xlsx`
- Periodo: 1970-2025

**Tasa de interés efectiva:**
- Fuente: Banco Central de la República Argentina (BCRA)
- Archivo: `data/tasa-interes-efectiva-argentina.xlsx`
- Frecuencia: Mensual

---

## 🚀 Cómo Reproducir el Análisis

### Requisitos previos:
```r
# Instalar paquetes necesarios
install.packages(c(
  "forecast", "tseries", "TSA", "ggplot2", 
  "readxl", "lmtest", "nortest", "fGarch", 
  "FinTS", "plotly", "dplyr"
))
```

### Ejecutar análisis ARIMA:
```r
# Abrir RStudio y ejecutar
setwd("ruta/a/01-series-temporales-argentina")

# Renderizar el R Markdown
rmarkdown::render("analisis-inflacion-arima-final.Rmd")
```

### Ejecutar modelos determinísticos:
```r
# En R o RStudio
source("modelo-deterministico-inflacion.R")
source("modelo-deterministico-tasa-interes.R")
```

---

## 📈 Visualizaciones Generadas

### Gráficos principales:
1. **Serie original con medias móviles** (7 y 30 periodos)
2. **Descomposición STL** (Tendencia, Estacionalidad, Residuos)
3. **ACF y PACF** (series original y diferenciada)
4. **Pronósticos ARIMA** con bandas de confianza
5. **Residuos estandarizados** con tests diagnósticos
6. **Comparación de modelos** determinísticos

Todos los gráficos se generan automáticamente y se guardan en `outputs/graficos/`.

---

## 🔍 Interpretación Económica

### Inflación Argentina:
- **Alta volatilidad** histórica confirmada por el análisis
- **Tendencia creciente** especialmente en últimas décadas
- **Estacionalidad presente** pero débil
- **Outliers** asociados a crisis económicas (2001, 2018, 2020)

### Tasa de Interés:
- **Política monetaria reactiva** ante inflación
- **Componente estacional moderado**
- **Cambios estructurales** evidentes en la serie

---

## 📚 Referencias Metodológicas

- Box, G. E., Jenkins, G. M., & Reinsel, G. C. (2015). *Time Series Analysis: Forecasting and Control*
- Hyndman, R. J., & Athanasopoulos, G. (2018). *Forecasting: Principles and Practice*
- Cleveland, R. B., et al. (1990). "STL: A Seasonal-Trend Decomposition Procedure Based on Loess"

---

## 📊 Publicaciones Relacionadas

🔗 **Ver análisis completo en RPubs:**
- [Series de Tiempo ARIMA](http://rpubs.com/WILLIAM_25/1380982)
- [Política Monetaria Argentina](http://rpubs.com/WILLIAM_25/1380989)

---

## 🤝 Contribuciones

¿Encontraste un bug o tienes sugerencias para mejorar el análisis?

1. Abre un **Issue** describiendo el problema/sugerencia
2. Haz un **Fork** del repositorio
3. Crea una **Pull Request** con tus cambios

---

## 📧 Contacto

**William Gutierrez**  
Economista | Analista de Datos  
📧 gutalex2014@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/ecoanalisiswill) | [GitHub](https://github.com/alexwill24)

---

<div align="center">

**← [Volver al repositorio principal](../README.md)**

</div>
