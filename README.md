# 📊 Portafolio de Análisis Econométricos en R

[![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)](https://www.r-project.org/)
[![RStudio](https://img.shields.io/badge/RStudio-75AADB?style=for-the-badge&logo=RStudio&logoColor=white)](https://www.rstudio.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

Colección de análisis econométricos y trabajos desarrollados en R durante mi carrera de Economía en la Universidad de Los Andes (ULA), Venezuela.

## 👨‍💼 Autor

**William Gutierrez**  
Economista | Analista de Datos | Universidad de Los Andes  
📧 gutalex2014@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/ecoanalisiswill) | [RPubs](https://rpubs.com/WILLIAM_25) | [Portafolio](https://gutalex2014.wixsite.com/portafolio-william-g)

---

## 📂 Contenido del Repositorio

### 🔹 [01 - Series Temporales: Economía Argentina](./01-series-temporales-argentina/)

Análisis exhaustivo de series económicas argentinas utilizando modelos ARIMA y técnicas de descomposición.

**Proyectos incluidos:**
- **Modelado ARIMA de Inflación**: Análisis estocástico de la inflación mensual (1970-2025)
- **Tasa de Interés Efectiva**: Modelos determinísticos y trigonométricos
- **Pruebas de Estacionariedad**: Test ADF, análisis ACF/PACF

**Técnicas aplicadas:**
- Series de Tiempo ARIMA(p,d,q)
- Descomposición STL (Seasonal-Trend-Loess)
- Modelos determinísticos (regresión dicotómica y trigonométrica)
- Pruebas de raíz unitaria (Augmented Dickey-Fuller)
- Validación de modelos (Ljung-Box, Shapiro-Wilk)

**Herramientas:** `forecast`, `tseries`, `ggplot2`, `TSA`, `lmtest`

📊 **Ver análisis publicados:**
- [Series ARIMA - RPubs](http://rpubs.com/WILLIAM_25/1380982)
- [Política Monetaria Argentina - RPubs](http://rpubs.com/WILLIAM_25/1380989)

---

### 🔹 [02 - Pirámides Poblacionales Comparativas](./02-piramides-poblacionales/)

Análisis demográfico y visualización de estructuras etarias en diferentes regiones.

**Regiones analizadas:**
- Europa del Sur (España, Italia, Grecia)
- El Caribe (Cuba, República Dominicana, Puerto Rico)
- El Cáucaso (Georgia, Armenia, Azerbaiyán)

**Técnicas aplicadas:**
- Visualización de datos demográficos
- Análisis comparativo de estructuras poblacionales
- Interpretación de pirámides etarias

**Herramientas:** `ggplot2`, `dplyr`, `tidyr`

📊 **Ver análisis:** [Pirámides Poblacionales - RPubs](http://rpubs.com/WILLIAM_25/1380940)

---

### 🔹 [03 - Otros Análisis Econométricos](./03-otros-analisis/)

Proyectos adicionales y análisis exploratorios (en desarrollo).

---

## 🛠️ Stack Tecnológico

### Lenguajes y Entornos
- **R** (4.x): Lenguaje principal
- **RStudio**: IDE de desarrollo
- **R Markdown**: Documentación reproducible

### Librerías Principales

**Análisis de Series Temporales:**
```r
library(forecast)     # Modelado ARIMA y pronósticos
library(tseries)      # Tests de estacionariedad
library(TSA)          # Análisis de series temporales
library(stl)          # Descomposición STL
```

**Manipulación y Visualización:**
```r
library(tidyverse)    # Ecosistema de análisis de datos
library(ggplot2)      # Visualización avanzada
library(dplyr)        # Manipulación de datos
library(readxl)       # Lectura de archivos Excel
```

**Análisis Estadístico:**
```r
library(lmtest)       # Tests de modelos lineales
library(nortest)      # Tests de normalidad
library(stats)        # Funciones estadísticas base
```

---

## 📖 Metodología de Trabajo

Todos los análisis en este repositorio siguen un flujo estructurado:

1. **Importación de Datos**: Lectura desde Excel/CSV
2. **Exploración Inicial**: Visualización y estadísticas descriptivas
3. **Preparación**: Limpieza y transformación de datos
4. **Modelado**: Aplicación de técnicas econométricas
5. **Validación**: Pruebas diagnósticas y estadísticas
6. **Visualización**: Gráficos profesionales con ggplot2
7. **Documentación**: Reportes reproducibles en R Markdown

---

## 🚀 Cómo Usar Este Repositorio

### Clonar el repositorio:
```bash
git clone https://github.com/alexwill24/Economia-ULA.git
cd Economia-ULA
```

### Instalar dependencias:
```r
# Instalar todas las librerías necesarias
install.packages(c(
  "forecast", "tseries", "TSA", "ggplot2", 
  "dplyr", "readxl", "lmtest", "tidyverse"
))
```

### Ejecutar un análisis:
```r
# Ejemplo: Análisis ARIMA de inflación argentina
setwd("01-series-temporales-argentina")
source("analisis-inflacion-arima-final.Rmd")
```

---

## 📊 Proyectos Destacados

### 🏆 Análisis de Inflación Argentina con ARIMA
- **Periodo:** 1970-2025 (datos mensuales)
- **Modelo óptimo:** ARIMA(5,1,4) seleccionado por criterios AIC/BIC
- **Validación:** Pruebas de Ljung-Box y Shapiro-Wilk
- **Pronóstico:** 100 periodos adelante con IC 95%

**Resultados clave:**
- Test ADF: Serie estacionaria tras diferenciación (p < 0.05)
- MAPE: Precisión aceptable con ajuste robusto
- ACF1 ≈ 0: Sin autocorrelación residual

---

## 📚 Recursos Adicionales

- **Tesis de Grado:** [Análisis Cuantitativo ACA Mérida](https://github.com/alexwill24/monografia-analisis-aca-merida)
- **Publicaciones RPubs:** [Perfil completo](https://rpubs.com/WILLIAM_25)
- **Portafolio Web:** [Proyectos y CV](https://gutalex2014.wixsite.com/portafolio-william-g)

---

## 📜 Licencia

Este repositorio está bajo la Licencia MIT. Puedes usar, modificar y distribuir el código citando la fuente original.

---

## 📬 Contacto

¿Tienes preguntas o sugerencias sobre algún análisis?

📧 **Email:** gutalex2014@gmail.com  
💼 **LinkedIn:** [ecoanalisiswill](https://linkedin.com/in/ecoanalisiswill)  
🐙 **GitHub:** [@alexwill24](https://github.com/alexwill24)

---

<div align="center">
  
**⭐ Si este repositorio te resulta útil, considera darle una estrella**

![GitHub stars](https://img.shields.io/github/stars/alexwill24/Economia-ULA?style=social)
![GitHub forks](https://img.shields.io/github/forks/alexwill24/Economia-ULA?style=social)

</div>
