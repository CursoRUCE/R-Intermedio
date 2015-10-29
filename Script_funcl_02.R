###############################
### Script Nivel Intermedio ###
########    CLase 02  #########


# Funcionales
# apply

# Suma de filas:
mtx <- matrix(rnorm(50), 10, 5)
apply(X = mtx, MARGIN = 1, FUN = sum)

# Suma de columnas:
apply(X = mtx, MARGIN = 2, FUN = sum)


# apply vs loop for
# Utilizar la función apply para calcular la media por columnas mediante:
medias <- apply(X = mtx, MARGIN = 2, FUN = mean, na.rm = TRUE)
medias

# Resulta equivalente a emplear el loop:
medias <- numeric(ncol(mtx))
for (i in 1:ncol(mtx)){
    medias[i] <- mean(x = mtx[,i], na.rm = TRUE)
}
medias

# col/row Sums/Means
# La línea de código para calcular la media por columnas:
apply(X = mtx, MARGIN = 2, FUN = mean, na.rm = TRUE)

# Resulta equivalente a:
colMeans(x = mtx, na.rm = TRUE)

# Ejemplos adicionales
# Cuantiles de las filas de una matriz.
mtx <- matrix(rnorm(50), 10, 5)
apply(X = mtx, MARGIN = 1, FUN = quantile, probs = c(0.25, 0.75))


# lapply
# Media de los elemtos de una lista: 
lst <- list(1:5, rnorm(10))
str(lst)
lapply(X = lst, FUN = mean)

# Rango de los elemtos de una lista:
lst <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1))
str(lst)
lapply(X = lst, FUN = range)

#lapply
# Observaciones de una distribución Uniforme[0,1]:
x <- 1:4
lapply(X = x, FUN = runif)

# Observaciones de una distribución Uniforme[min,max]:
x <- 1:4
lapply(X = x, FUN = runif, min = 0, max = 10)


# lapply y funciones anónimas
(list.mtx <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 2, 3)))

# Función anónima para extraer la primera fila de una matriz.
lapply(X = list.mtx, FUN = function(elem) elem[1,])

# sapply

# Media de los elementos de una lista:
lst <- list(a = 1:4, b = rexp(10,3), c = rpois(20, 2), d = rnorm(50,1,2))
lapply(X = lst, FUN = mean) #equivalente a sapply(lst, mean, simplify = FALSE)
sapply(X = lst, FUN = mean)

# Máximo de los elementos de una lista:
sapply(X = lst, FUN = max, na.rm=TRUE)

# Posición del máximo en los elementos de una lista:
sapply(X = lst, FUN = which.max)

# tapply
vec <- c(rnorm(10), runif(10), rnorm(10, 1))
# factor con n niveles con 10 observaciones cada uno
fac <- gl(n = 3, k = 10)

# Media de cada subconjunto:
tapply(X = vec, INDEX = fac, FUN = mean)

# Rango de cada subconjunto:
tapply(X = vec, INDEX = fac, FUN = range)

# Data set: PlantGrowth
str(PlantGrowth)

# Varianza de weight en los grupos dados por el factor group:
tapply(X = PlantGrowth[,"weight"], INDEX = PlantGrowth[,"group"],
       FUN = var, na.rm = TRUE)

# sd de weight en los grupos dados por el factor group:
tapply(X = PlantGrowth[,"weight"], INDEX = PlantGrowth[,"group"],
       FUN = sd, na.rm = TRUE)


# split
# Split para un vector numérico:
vec <- c(rnorm(5), runif(5), rexp(5, 1))
fac <- gl(n = 3, k = 5)
split(x = vec, f = fac)

# Retorna una lista:
svec <- split(x = vec, f = fac)
str(svec)


# split y sapply
# media de cada subconjunto
lapply(X = svec, FUN = mean)

# Split, Data Frame
library(datasets)
head(airquality,n = 10)

# Se divide el data frame airquality mediante la variable Month:
sairquality <- split(x = airquality, f = airquality$Month)
names(sairquality)
head(sairquality[[1]], n = 3)
head(sairquality[[2]], n = 3)

# Función a ser aplicada:
# df es un data frame
media.df <- function(df,...){
    colMeans(df[, c("Ozone", "Solar.R", "Wind")],...)  
}

# Se aplica la función media.df a los elementos de sairquality:
sapply(X = sairquality, FUN = media.df)
sapply(X = sairquality, FUN = media.df, na.rm = TRUE)

# Media de las variables utilizando una función anónima:
lapply(sairquality, function(df) colMeans(df[, c("Ozone", "Solar.R", "Wind")],
                                          na.rm = TRUE))


# mapply
# Función rep.int escalar:
# Recibe los argumentos (x, times).
str(rep.int)

# Repite x times veces
rep.int(x = 1, times=2)
rep.int(x = 5, times=3)

# Aplico rep.int a cada uno de los pares (valor_i,veces_i):
valor <- 1:5
veces <- 5:1
mapply(FUN = rep.int, valor, veces, SIMPLIFY = TRUE)

# Vectorización de funciones escalares
# Función exponencial escalar:
x <- 1
exp(x)
# Función exponencial vectorizada:
x <- 1:5
exp(x)

# Función rep.int escalar:
# times es un número.
str(rep.int)
rep.int(x = 1, times=2)

# times es un vector.
rep.int(x = 1, times=c(2,3))


# Función rep.int vectorial:
    
vrep <- Vectorize(FUN = rep.int, vectorize.args = "times", SIMPLIFY = TRUE)
# times es un vector
vrep(x = 1, times = c(2, 3, 4, 5))












