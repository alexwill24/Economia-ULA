# Instalar y cargar las librerías necesarias
install.packages(c("leaps", "locfit", "TSA", "quadprog", "quantmod", "tseries", "Rcpp", "colorspace", "fracdiff", "ggplot2", "forecast", "Rsolnp", "rugarch", "parallel", "base", "stats", "nortest", "fGarch", "timeSeries", "fBasics", "FinTS", "readxl"))
library(leaps)
library(locfit)
library(TSA)
library(quadprog)
library(quantmod)
library(tseries)
library(Rcpp)
library(colorspace)
library(fracdiff)
library(ggplot2)
library(forecast)
library(Rsolnp)
library(rugarch)
library(parallel)
library(base)
library(stats)
library(nortest)
library(fGarch)
library(timeSeries)
library(fBasics)
library(FinTS)
library(readxl)
install.packages("plotly")
library(plotly)

# Definir la ruta del archivo
file_path <- "C:/Users/MARK/Desktop/Econometria II/tasa de interes efectiva de la politica monetaria efectiva.xlsx"

# Leer el archivo Excel
data <- read_excel(file_path)

# Verificar los nombres de las columnas en el archivo
colnames(data)

# Seleccionar la columna de tasa de interés efectiva
tasa_interes <- data$Valor

# Convertir las fechas a un objeto Date
fechas <- as.Date(data$Fecha, format="%Y-%m-%d")

# Ajustar los parámetros de inicio y frecuencia según los datos
start_year <- as.numeric(format(min(fechas), "%Y"))
start_month <- as.numeric(format(min(fechas), "%m"))

# Asegurarse de que la serie tenga un formato de serie de tiempo
ts_interes <- ts(tasa_interes, start=c(start_year, start_month), frequency=12)

# Verificar la serie de tiempo
print(ts_interes)
plot(ts_interes, main="Serie de Tasa de Interés Efectiva", ylab="Tasa de Interés", xlab="Tiempo")

# Descomposición de la serie de tiempo
interes.fit <- decompose(ts_interes, type="multiplicative")
plot(interes.fit)

# Componentes de la descomposición
Estac.interes <- interes.fit$seasonal
Trend.interes <- interes.fit$trend
Res.interes <- interes.fit$random

par(mfrow=c(2,2))
plot(ts_interes, main='Tasa de Interés')
plot(Estac.interes, main='Componente Estacional')
plot(Trend.interes, main='Tendencia')
plot(Res.interes, main='Componente Aleatorio')

# Descomposición aditiva
interes.fit1 <- decompose(ts_interes, type="additive")
plot(interes.fit1)

# Componentes de la descomposición aditiva
Estac.interes1 <- interes.fit1$seasonal
Trend.interes1 <- interes.fit1$trend
Res.interes1 <- interes.fit1$random

par(mfrow=c(2,2))
plot(ts_interes, main='Tasa de Interés')
plot(Estac.interes1, main='Componente Estacional')
plot(Trend.interes1, main='Tendencia')
plot(Res.interes1, main='Componente Aleatorio')

# Descomposición STL
stl.fit <- stl(ts_interes, s.window="periodic")
plot(stl.fit)

# Medias estacionales y regresión dicotómica
interes.1 <- season(ts_interes)
interes.lm <- lm(ts_interes ~ interes.1 - 1) 
# Quitar el intercepto
summary(interes.lm)
interes.lm1 <- fitted(interes.lm)
interes.lm1.ts <- ts(interes.lm1, start=c(start_year, start_month), freq=12)
ts.plot(ts_interes, interes.lm1.ts, main="Regresión dicotómica")

# Criterios de información
AIC(interes.lm)
BIC(interes.lm)

# Regresión trigonométrica
interes2 <- harmonic(ts_interes)
interes.lm3 <- lm(ts_interes ~ interes2)
summary(interes.lm3)
interes.lm3.ts <- ts(fitted(interes.lm3), start=c(start_year, start_month), freq=12)
ts.plot(ts_interes, interes.lm3.ts, main="Regresión trigonométrica")

# Modelo sinusoidal
interes.vec <- as.vector(ts_interes)
t <- seq(1, length(interes.vec))
cos1 <- cos(2 * pi * t / 12)
sin1 <- sin(2 * pi * t / 12)
cos2 <- cos(4 * pi * t / 12)
sin2 <- sin(4 * pi * t / 12)
interes.lm4 <- lm(interes.vec ~ t + cos1 + sin1 + cos2 + sin2)
summary(interes.lm4)
interes.lm4.ts <- ts(fitted(interes.lm4), start=c(start_year, start_month), freq=12)
ts.plot(ts_interes, interes.lm4.ts, main="Regresión Trigonométrica")

# valores estimados histograma
hist(interes.lm4.ts, main = "Histograma de valores estimado por el modelo", col = "blue")

plot(ts_interes, type = "l", xlab = "Tiempo", ylab = "Tasa de Interés Efectiva")
lines(interes.lm4.ts, col = "red")

# Criterios de información
AIC(interes.lm4)
BIC(interes.lm4)

# Medidas de error para la descomposición multiplicativa
mse_multiplicativa <- mean((ts_interes - interes.fit$trend - interes.fit$seasonal - interes.fit$random)^2, na.rm = TRUE)
mae_multiplicativa <- mean(abs(ts_interes - interes.fit$trend - interes.fit$seasonal - interes.fit$random), na.rm = TRUE)

# Medidas de error para la descomposición aditiva
mse_aditiva <- mean((ts_interes - interes.fit1$trend - interes.fit1$seasonal - interes.fit1$random)^2, na.rm = TRUE)
mae_aditiva <- mean(abs(ts_interes - interes.fit1$trend - interes.fit1$seasonal - interes.fit1$random), na.rm = TRUE)

cat("MSE multiplicativa: ", mse_multiplicativa, "\nMAE multiplicativa: ", mae_multiplicativa, "\n")
cat("MSE aditiva: ", mse_aditiva, "\nMAE aditiva: ", mae_aditiva, "\n")

# Medidas de error para la regresión dicotómica
mse_dicotomica <- mean((ts_interes - interes.lm1.ts)^2, na.rm = TRUE)
mae_dicotomica <- mean(abs(ts_interes - interes.lm1.ts), na.rm = TRUE)

cat("MSE dicotómica: ", mse_dicotomica, "\nMAE dicotómica: ", mae_dicotomica, "\n")

# Medidas de error para la regresión trigonométrica
mse_trigonometrica <- mean((ts_interes - interes.lm3.ts)^2, na.rm = TRUE)
mae_trigonometrica <- mean(abs(ts_interes - interes.lm3.ts), na.rm = TRUE)

cat("MSE trigonométrica: ", mse_trigonometrica, "\nMAE trigonométrica: ", mae_trigonometrica, "\n")

# Medidas de error para el modelo sinusoidal
mse_sinusoidal <- mean((ts_interes - interes.lm4.ts)^2, na.rm = TRUE)
mae_sinusoidal <- mean(abs(ts_interes - interes.lm4.ts), na.rm = TRUE)

cat("MSE sinusoidal: ", mse_sinusoidal, "\nMAE sinusoidal: ", mae_sinusoidal, "\n")

# Error de pronóstico

# Función para calcular medidas de error de pronósticos
calculate_forecast_errors <- function(forecast_obj) {
  error_measures <- accuracy(forecast_obj)
  return(error_measures)
}

# Suavizamiento

# Ajustar un modelo de suavización exponencial
fit_additive <- HoltWinters(ts_interes, seasonal="additive")

# Ajustar un modelo de suavización exponencial a los residuos de STL
fit_multiplicative <- ets(ts_interes)

# Pronóstico

# Realizar pronósticos
forecast_additive <- forecast(fit_additive, h=12)
forecast_multiplicative <- forecast(fit_multiplicative, h=12)

# Medidas del error

# Calcular medidas de error
error_additive <- calculate_forecast_errors(forecast_additive)
error_multiplicative <- calculate_forecast_errors(forecast_multiplicative)

# Mostrar medidas de error
print("Errores de pronóstico para la descomposición aditiva:")
print(error_additive)

print("Errores de pronóstico para la descomposición multiplicativa:")
print(error_multiplicative)

# Comparar las medidas de error
best_method <- ifelse(error_additive[2] < error_multiplicative[2], "Aditiva", "Multiplicativa")

print(paste("La mejor técnica de descomposición es:", best_method))

# VARIABLES DICOTÓMICAS
meses <- season(ts_interes)
t <- 1:length(ts_interes)

# Ver algunos datos de la serie de tiempo
head(ts_interes)
summary(ts_interes)
plot(ts_interes, main="Tasa de Interés Efectiva", ylab="Tasa de Interés", xlab="Tiempo")

# Ajuste del modelo
fit.data <- lm(ts_interes ~ t + meses)
summary(fit.data)

# Valores estimados
ml.fitted <- fitted(fit.data)
hist(ml.fitted, main = "Histograma de valores estimado por el modelo", col = "blue")

datosfit.ts <- ts(ml.fitted, start = c(start_year, start_month), frequency = 12)

plot(datosfit.ts, type = "l", xlab = "Tiempo", ylab = "Valores ajustados")

plot(ts_interes, type = "l", xlab = "Tiempo", ylab = "Tasa de Interés Efectiva")
lines(datosfit.ts, col = "red")

# Calcular los residuos y las métricas de error
resi <- residuals(fit.data)
Errorpromedio <- mean(resi)
print(Errorpromedio)
Promedioabsolutos <- mean(abs(resi))
sce <- sum(resi^2)
n_k <- length(ts_interes) - length(fit.data$coefficients)
ECM <- sce / n_k
Desv.Errores <- sqrt(ECM)

tabla_comparativa <- round(cbind(Errorpromedio, Promedioabsolutos, sce, ECM), 20)
print(tabla_comparativa)

# Valores estimados
ml.fitted <- fitted(fit.data)
hist(ml.fitted, main = "Histograma de valores estimado por el modelo", col = "blue")

datosfit.ts <- ts(ml.fitted, start = c(start_year, start_month), frequency = 12)

plot(datosfit.ts, type = "l", xlab = "Tiempo", ylab = "Valores ajustados")

plot(ts_interes, type = "l", xlab = "Tiempo", ylab = "Tasa de Interés Efectiva")
lines(datosfit.ts, col = "red")

resi <- residuals(fit.data)
Errorpromedio = mean(resi)
print(Errorpromedio)
Promedioabsolutos = mean(abs(resi))
sce = sum(resi)
n_k <- c(length(ts_interes) - length(fit.data$coefficients))
ECM <- sce / n_k
Desv.Errores <- sqrt(ECM)
tabla_comparativa <- round(cbind(Errorpromedio, Promedioabsolutos, sce, ECM), 20)
tabla_comparativa

# VARIABLES TRIGONOMÉTRICAS
t = 1:length(ts_interes)
L = frequency(ts_interes)
seno2p = sin((2*pi*t)/L)
cos2p = cos((2*pi*t)/L)
seno4p = sin((4*pi*t)/L)
cos4p = cos((4*pi*t)/L)

# Modelo uno
mltrigo = lm(ts_interes ~ t + seno2p + cos2p)

# Modelo cuatro
mltrigo2 = lm(ts_interes ~ t + seno2p + seno2p * t + cos2p + t * cos2p + seno4p + seno4p * t + cos4p + cos4p * t)

summary(mltrigo)
summary(mltrigo2)

mlt.fitted <- fitted(mltrigo)
hist(mlt.fitted, main = "Histograma de valores estimado por el modelo", col = "blue")

datos.ts <- ts(mlt.fitted, start = c(start_year, start_month), frequency = 12)
plot(datos.ts, type = "l", xlab = "Tiempo", ylab = "Valores ajustados")

plot(ts_interes, type = "l", xlab = "Tiempo", ylab = "Tasa de Interés Efectiva")
lines(datos.ts, col = "red")

resi <- residuals(mltrigo)
Errorpromedio = mean(resi)
print(Errorpromedio)
Promedioabsolutos = mean(abs(resi))
sce = sum(resi)
n_k <- c(length(ts_interes) - length(mltrigo$coefficients))
ECM <- sce / n_k
Desv.Errores <- sqrt(ECM)

tabla_comparativa <- round(cbind(Errorpromedio, Promedioabsolutos, sce, ECM), 20)
tabla_comparativa
