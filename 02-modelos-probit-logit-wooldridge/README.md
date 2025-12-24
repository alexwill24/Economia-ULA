# 📊 Modelos Probit y Logit: Discriminación en Préstamos Hipotecarios

Análisis econométrico de discriminación racial en el otorgamiento de préstamos hipotecarios utilizando datos HMDA (Home Mortgage Disclosure Act) de Estados Unidos.

## 🎯 Objetivo

Evaluar si existe discriminación estadísticamente significativa contra solicitantes no blancos en el proceso de aprobación de préstamos hipotecarios, controlando por características socioeconómicas y crediticias.

## 📁 Contenido

- `modelo-probit-logit.Rmd`: Análisis completo con interpretación económica
- `modelo-probit-logit.html`: Reporte renderizado

## 🔬 Metodología

### Modelos Estimados:
1. **Modelo Probit básico**: Probabilidad de aprobación vs. raza
2. **Modelo Probit extendido**: Incluyendo covariables financieras
3. **Modelo Logit extendido**: Comparación de especificaciones

### Variables del Modelo:

**Variable Dependiente:**
- `approve`: Aprobación del préstamo (1=sí, 0=no)

**Variables Independientes:**
- `white`: Raza del solicitante (1=blanco, 0=no blanco)
- `hrat`: Ratio vivienda/ingreso
- `obrat`: Ratio otras deudas/ingreso
- `loanprc`: Ratio préstamo/precio propiedad
- `unem`: Tasa de desempleo local
- `male`, `married`, `dep`, `sch`: Características demográficas
- `cosign`, `chist`, `pubrec`, `mortlat1`, `mortlat2`: Variables crediticias

## 📈 Resultados Principales

### Efecto de la Variable "white" (Raza):

| Modelo | Efecto Marginal Promedio (AME) | Interpretación |
|--------|-------------------------------|----------------|
| Probit | 8.64% (p < 0.001) | Ser blanco aumenta 8.64 pp la prob. de aprobación |
| Logit  | 8.28% (p < 0.001) | Ser blanco aumenta 8.28 pp la prob. de aprobación |

### Efecto Discriminativo (Ecuación 17.17 de Wooldridge):

- **Probit**: 10.42% puntos porcentuales
- **Logit**: 10.09% puntos porcentuales

**Conclusión:** Existe evidencia estadísticamente significativa de discriminación racial en el otorgamiento de préstamos, incluso después de controlar por todas las características observables.

## 💡 Interpretación Económica

El análisis revela que, manteniendo constantes:
- Características financieras (ingresos, deudas, valor de la propiedad)
- Historial crediticio
- Variables demográficas

Los solicitantes blancos tienen aproximadamente **10 puntos porcentuales más de probabilidad** de obtener aprobación que los no blancos.

### Posibles Explicaciones:

1. **Sesgos institucionales** en guías crediticias
2. **Discriminación implícita** de oficiales de crédito
3. **Disparidad en acceso a información** pre-aprobatoria
4. **Efectos del *redlining* histórico**

## 🛠️ Herramientas Utilizadas
```r
library(wooldridge)  # Dataset HMDA
library(margins)     # Efectos marginales
library(ggplot2)     # Visualización
library(car)         # Diagnósticos
library(pROC)        # Curvas ROC
library(texreg)      # Tablas de regresión
```

## 📚 Referencias

- Wooldridge, J. M. (2010). *Econometric Analysis of Cross Section and Panel Data* (2nd ed.)
- Dataset: `loanapp` del paquete `wooldridge` en R (datos HMDA 2006-2007)

## 🔗 Publicación

📄 [Ver análisis completo](http://rpubs.com/WILLIAM_25/1383742)

---

**Autor:** William Gutierrez  
**Curso:** Econometría II  
**Institución:** Universidad de Los Andes
