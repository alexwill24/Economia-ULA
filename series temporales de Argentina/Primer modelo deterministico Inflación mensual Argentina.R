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
file_path <- "C:/Users/MARK/Desktop/Econometria II/datos de series de tiempo argentina.xlsx"

# Leer el archivo Excel
data <- read_excel(file_path)

# Verificar los nombres de las columnas en el archivo
colnames(data)

# Seleccionar la columna de inflación
inflacion <- data$Valor

# Convertir las fechas a un objeto Date
fechas <- as.Date(data$Fecha, format="%Y-%m-%d")

# Ajustar los parámetros de inicio y frecuencia según los datos
start_year <- as.numeric(format(min(fechas), "%Y"))
start_month <- as.numeric(format(min(fechas), "%m"))

# Asegurarse de que la serie tenga un formato de serie de tiempo
inf <- ts(inflacion, start=c(start_year, start_month), frequency=12)

# Descomposición de la serie de tiempo
inflacion.fit <- decompose(inf, type="multiplicative")
plot(inflacion.fit)

# Componentes de la descomposición
Estac.inflacion <- inflacion.fit$seasonal
Trend.inflacion <- inflacion.fit$trend
Res.inflacion <- inflacion.fit$random

par(mfrow=c(2,2))
plot(inf, main='Inflación')
plot(Estac.inflacion, main='Componente Estacional')
plot(Trend.inflacion, main='Tendencia')
plot(Res.inflacion, main='Componente Aleatorio')

# Descomposición aditiva
inflacion.fit1 <- decompose(inf, type="additive")
plot(inflacion.fit1)

# Componentes de la descomposición aditiva
Estac.inflacion1 <- inflacion.fit1$seasonal
Trend.inflacion1 <- inflacion.fit1$trend
Res.inflacion1 <- inflacion.fit1$random

par(mfrow=c(2,2))
plot(inf, main='Inflación')
plot(Estac.inflacion1, main='Componente Estacional')
plot(Trend.inflacion1, main='Tendencia')
plot(Res.inflacion1, main='Componente Aleatorio')

# Descomposición STL
stl.fit <- stl(inf, s.window="periodic")
plot(stl.fit)

# Medias estacionales y regresión dicotómica
inflacion.1 <- season(inf)
inflacion.lm <- lm(inf ~ inflacion.1 - 1) 
# Quitar el intercepto
summary(inflacion.lm)
inflacion.lm1 <- fitted(inflacion.lm)
inflacion.lm1.ts <- ts(inflacion.lm1, start=c(start_year, start_month), freq=12)
ts.plot(inf, inflacion.lm1.ts, main="Regresión dicotómica")

# Criterios de información
AIC(inflacion.lm)
BIC(inflacion.lm)

# Regresión trigonométrica
inflacion2 <- harmonic(inf)
inflacion.lm3 <- lm(inf ~ inflacion2)
summary(inflacion.lm3)
inflacion.lm3.ts <- ts(fitted(inflacion.lm3), start=c(start_year, start_month), freq=12)
ts.plot(inf, inflacion.lm3.ts, main="Regresión trigonométrica")

# Modelo sinusoidal
inflacion.vec <- as.vector(inf)
t <- seq(1, length(inflacion.vec))
cos1 <- cos(2 * pi * t / 12)
sin1 <- sin(2 * pi * t / 12)
cos2 <- cos(4 * pi * t / 12)
sin2 <- sin(4 * pi * t / 12)
inflacion.lm4 <- lm(inflacion.vec ~ t + cos1 + sin1 + cos2 + sin2)
summary(inflacion.lm4)
inflacion.lm4.ts <- ts(fitted(inflacion.lm4), start=c(start_year, start_month), freq=12)
ts.plot(inf, inflacion.lm4.ts, main="Regresión Trigonométrica")

#valores estimados histograma
hist(inflacion.lm4.ts, main = "Histograma de valores estimado por el modelo", col = "blue")

plot(inf, type = "l", xlab = "Tiempo", ylab = "Logaritmo de las ventas mensuales")
lines(inflacion.lm4.ts, col = "red")
# Criterios de información
AIC(inflacion.lm4)
BIC(inflacion.lm4)
# Medidas de error para la descomposición multiplicativa
mse_multiplicativa <- mean((inf - inflacion.fit$trend - inflacion.fit$seasonal - inflacion.fit$random)^2, na.rm = TRUE)
mae_multiplicativa <- mean(abs(inf - inflacion.fit$trend - inflacion.fit$seasonal - inflacion.fit$random), na.rm = TRUE)

# Medidas de error para la descomposición aditiva
mse_aditiva <- mean((inf - inflacion.fit1$trend - inflacion.fit1$seasonal - inflacion.fit1$random)^2, na.rm = TRUE)
mae_aditiva <- mean(abs(inf - inflacion.fit1$trend - inflacion.fit1$seasonal - inflacion.fit1$random), na.rm = TRUE)

cat("MSE multiplicativa: ", mse_multiplicativa, "\nMAE multiplicativa: ", mae_multiplicativa, "\n")
cat("MSE aditiva: ", mse_aditiva, "\nMAE aditiva: ", mae_aditiva, "\n")
# Medidas de error para la regresión dicotómica
mse_dicotomica <- mean((inf - inflacion.lm1.ts)^2, na.rm = TRUE)
mae_dicotomica <- mean(abs(inf - inflacion.lm1.ts), na.rm = TRUE)

cat("MSE dicotómica: ", mse_dicotomica, "\nMAE dicotómica: ", mae_dicotomica, "\n")
# Medidas de error para la regresión trigonométrica
mse_trigonometrica <- mean((inf - inflacion.lm3.ts)^2, na.rm = TRUE)
mae_trigonometrica <- mean(abs(inf - inflacion.lm3.ts), na.rm = TRUE)

cat("MSE trigonométrica: ", mse_trigonometrica, "\nMAE trigonométrica: ", mae_trigonometrica, "\n")
# Medidas de error para el modelo sinusoidal
mse_sinusoidal <- mean((inf - inflacion.lm4.ts)^2, na.rm = TRUE)
mae_sinusoidal <- mean(abs(inf - inflacion.lm4.ts), na.rm = TRUE)

cat("MSE sinusoidal: ", mse_sinusoidal, "\nMAE sinusoidal: ", mae_sinusoidal, "\n")

#Error de pronostico#

# Función para calcular medidas de error de pronósticos
calculate_forecast_errors <- function(forecast_obj) {
  error_measures <- accuracy(forecast_obj)
  return(error_measures)
}

#Suavizamiento#

# Ajustar un modelo de suavización exponencial
fit_additive <- HoltWinters(ts_data, seasonal="additive")

# Ajustar un modelo de suavización exponencial a los residuos de STL
fit_multiplicative <- ets(ts_data)

#Pronostico#

# Realizar pronósticos
forecast_additive <- forecast(fit_additive, h=12)
forecast_multiplicative <- forecast(fit_multiplicative, h=12)

#medidas del error#

# Calcular medidas de error
error_additive <- calculate_forecast_errors(forecast_additive)
error_multiplicative <- calculate_forecast_errors(forecast_multiplicative)

# Mostrar medidas de error
print("Errores de pronóstico para la descomposición aditiva:")
print(error_additive)

print("Errores de pronóstico para la descomposición multiplicativa:")
print(error_multiplicative)

# Comparar las medidas de error
best_method <- ifelse(error_additive[2]< error_multiplicative[2] , "Aditiva", "Multiplicativa")

print(paste("La mejor técnica de descomposición es:", best_method))

#VARIABLES DICOTOMICAS#
meses = season(ts_data)
t = 1:length(ts_data)

#Ajuste del modelo#
fit.data = lm(ts_data~ t +meses)
summary(fit.data)

#Valores estimados#
ml.fitted <- fitted(fit.data)
hist(ml.fitted, main = "Histograma de valores estimado por el modelo", col = "blue")

datosfit.ts <- ts(ml.fitted, start = c(1970,1), frequency = 12)

plot(datosfit.ts, type = "l", xlab = "Tiempo", ylab = "Valores ajustados", )

plot(ts_data, type = "l", xlab = "Tiempo", ylab = "Logaritmo de las ventas mensuales")
lines(datosfit.ts, col = "red")


resi<- residuals(fit.data)
Errorpromedio= mean(resi)
print(Errorpromedio)
Promedioabsolutos=mean(abs(resi))
sce=sum(resi)
n_k <- c(length(ts_data) - length(fit.data$coefficients))
ECM <- sce/n_k
Desv.Errores <- sqrt(ECM)
tabla_comparativa <- round(cbind(Errorpromedio,Promedioabsolutos,sce,ECM),20)
tabla_comparativa

# Ajuste del modelo sin intercepto
fit.data.no_intercept <- lm(ts_data ~ t + meses - 1)
summary(fit.data.no_intercept)

# Valores estimados del modelo sin intercepto
ml.fitted.no_intercept <- fitted(fit.data.no_intercept)
hist(ml.fitted.no_intercept, main = "Histograma de valores estimados por el modelo sin intercepto", col = "blue")

datosfit.no_intercept.ts <- ts(ml.fitted.no_intercept, start = c(start_year, start_month), frequency = 12)

plot(datosfit.no_intercept.ts, type = "l", xlab = "Tiempo", ylab = "Valores ajustados")

plot(ts_data, type = "l", xlab = "Tiempo", ylab = "Valores")
lines(datosfit.no_intercept.ts, col = "red")

# Calcular los residuos y las métricas de error del modelo sin intercepto
resi.no_intercept <- residuals(fit.data.no_intercept)
Errorpromedio.no_intercept <- mean(resi.no_intercept)
print(Errorpromedio.no_intercept)
Promedioabsolutos.no_intercept <- mean(abs(resi.no_intercept))
sce.no_intercept <- sum(resi.no_intercept^2)
n_k.no_intercept <- length(ts_data) - length(fit.data.no_intercept$coefficients)
ECM.no_intercept <- sce.no_intercept / n_k.no_intercept
Desv.Errores.no_intercept <- sqrt(ECM.no_intercept)

tabla_comparativa.no_intercept <- round(cbind(Errorpromedio.no_intercept, Promedioabsolutos.no_intercept, sce.no_intercept, ECM.no_intercept), 20)
print(tabla_comparativa.no_intercept)

#VARIABLES TRIGONOMETRICAS#
t = 1:length(ts_data)
L = frequency(ts_data) 
seno2p = sin((2*pi*t)/L) 
cos2p = cos((2*pi*t)/L)
seno4p = sin((4*pi*t)/L) 
cos4p = cos((4*pi*t)/L)
#modelo uno
mltrigo= lm(ts_data~t+seno2p+cos2p)
#modelo cuatro
mltrigo2= lm(ts_data~t+seno2p+seno2p*t+cos2p+t*cos2p+seno4p+seno4p*t+cos4p+cos4p*t)

summary(mltrigo)
summary(mltrigo2)

mlt.fitted <- fitted(mltrigo)
hist(mlt.fitted, main = "Histograma de valores estimado por el modelo", col = "blue")

datos.ts <- ts(mlt.fitted, start = c(1970,1), frequency = 12)
plot(datos.ts, type = "l", xlab = "Tiempo", ylab = "Valores ajustados")

plot(ts_data, type = "l", xlab = "Tiempo", ylab = "veremos")
lines(datos.ts, col = "red")

resi<- residuals(mltrigo)
Errorpromedio= mean(resi)
print(Errorpromedio)
Promedioabsolutos=mean(abs(resi))
sce=sum(resi)
n_k <- c(length(ts_data) - length(mltrigo$coefficients))
ECM <- sce/n_k
Desv.Errores <- sqrt(ECM)

tabla_comparativa <- round(cbind(Errorpromedio,Promedioabsolutos,sce,ECM),20)
tabla_comparativa