# Cargar las librerías necesarias
library(ggplot2)
library(forecast)
library(tseries)
library(readxl)
library(lmtest)

# Importar los datos desde el archivo Excel
datos <- read_excel("C:/Users/MARK/Desktop/Econometria II/datos de series de tiempo argentina.xlsx")

# Convertir la columna de fecha a tipo Date
datos$Fecha <- as.Date(datos$Fecha)

# Crear la serie de tiempo
datos.ts <- ts(datos$Valor, frequency = 12, start = c(2000, 1))

# Trazar la serie de tiempo original
ggplot() +
  geom_line(data = datos, aes(x = Fecha, y = Valor)) + 
  ylab('Inflación de Argentina') + 
  ggtitle('Serie de Tiempo de la Inflación de Argentina')

# Calcular medias móviles para suavizar la serie de tiempo
datos$Valor.ma <- ma(datos$Valor, order = 7)
datos$Valor30.ma <- ma(datos$Valor, order = 30)

# Trazar la serie de tiempo con medias móviles
ggplot() +
  geom_line(data = datos, aes(x = Fecha, y = Valor, colour = "Serie Original")) +
  geom_line(data = datos, aes(x = Fecha, y = Valor.ma, colour = "Media Móvil Semanal")) +
  geom_line(data = datos, aes(x = Fecha, y = Valor30.ma, colour = "Media Móvil Mensual")) +
  ylab('Inflación de Argentina') + 
  ggtitle('Serie de Tiempo con Medias Móviles')

# Crear la serie de tiempo con la media móvil mensual, omitiendo los valores NA
count_ma <- ts(na.omit(datos$Valor30.ma), frequency = 12)

# Descomponer la serie de tiempo
decomp <- stl(count_ma, s.window = "periodic")
deseasonal_inf <- seasadj(decomp)

# Verificar que deseasonal_inf está definido correctamente
print(deseasonal_inf)

# Trazar la descomposición
plot(decomp)

# Prueba de raíz unitaria (ADF) para verificar la estacionariedad
adf.test(count_ma, alternative = "stationary")

# Graficar ACF y PACF
Acf(count_ma, main = 'ACF de la Serie Deseasonalizada')
Pacf(count_ma, main = 'PACF de la Serie Deseasonalizada')

# Diferenciar la serie de tiempo para hacerla estacionaria
count_d1 <- diff(deseasonal_inf, differences = 1)
plot(count_d1, main = "Serie Diferenciada")

# Descomponer la serie diferenciada
decomp2 <- stl(count_d1, s.window = "periodic")
deseasonal_inf2 <- seasadj(decomp2)
plot(decomp2)

# Prueba de raíz unitaria (ADF) para la serie diferenciada
adf.test(count_d1, alternative = "stationary")

# Graficar ACF y PACF de la serie diferenciada
Acf(count_d1, main = 'ACF de la Serie Diferenciada')
Pacf(count_d1, main = 'PACF de la Serie Diferenciada')

# Ajustar el modelo ARIMA a la serie deseasonalizada
modelo_arima <- arima(deseasonal_inf, order = c(5, 1, 4))

# Resumen del modelo ARIMA
summary(modelo_arima)

# Evaluación de la significancia individual de los parámetros
# Utilizando la función coeftest de lmtest para obtener una tabla de resultados con los valores t y p-valores
resultados <- coeftest(modelo_arima)
print(resultados)
