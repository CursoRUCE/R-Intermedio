

# Creación objetos data.table

# data frame
DF <- data.frame(x=c("b","b","a","a"),y=4:1, z=rnorm(4))
DF

# data.table
#install.packages("data.table", dependencies = TRUE)
library(data.table)
DT <- data.table(x=c("b","b","a","a"),y=4:1, z=rnorm(4))
DT

# data frame vs data.table
head(mtcars, n = 4)

mtcarsDT <- data.table(mtcars)
head(mtcarsDT, n = 4)

# data frame vs data.table
class(mtcars)

mtcarsDT <- data.table(mtcars)
class(mtcarsDT)

# Objetos data.table en área de trabajo
tables()

carsDT <- data.table(cars)
tables()

# data.table a data frame
DT
sapply(DT,class)

# Subsetting filas
DT <- data.table(x=rep(c("a","b","c"),each=2), y=c(0,1), v=1:6)
DT

# Fila 2
DT[2] 
# Filas 2, 4, 6
DT[c(2, 4, 6)]


## Subsetting filas
DT

# Filas mediante TRUE y FALSE
DT[c(TRUE, TRUE, FALSE, FALSE, TRUE, TRUE)]

## Subsetting filas
DT

# Filas mediante TRUE y FALSE
DT[c(FALSE,TRUE)] # reciclado

# Subsetting omitir filas
DT
# Omitimos las filas 2, 3, 4
DT[!2:4]

## Subsetting columnas
DT
# Columna de nombre v
DT[,v] # col v como vector

## Subsetting columnas
DT
# Columna de nombre v
DT[,list(v)] # col v como data.table

## Subsetting columnas
DT
# Columna de nombre v
DT[,.(v)] # col v como data.table
# En data.table list() es equivalente a .()

## Subsetting columnas
DT
# Columna 3
DT[,3]

# Para extraer la columna 3 se debe añadir with=FALSE
{r}
DT[,3, with=FALSE]


# Subsetting columnas
DT
# Columnas 1 y 3
DT[,c(1,3), with=FALSE]

# Subsetting y cálculo de variables
DT
# Suma de la variable v sobre las filas 2, 3, 4
DT[2:4]
DT[2:4,sum(v)]

# Subsetting y cálculo de variables
DT
# Media de la variable v sobre las filas 1, 2, 3
DT[1:3]
DT[1:3,mean(v)]

# Setkeys
DT
setkey(DT,x) 
tables()

# Subsetting mediante keys
DT
# Seleccionar las filas en las cuales la key sea igual a b
DT["a"] # busqueda binaria (fast)

# Seleccionar las filas en las cuales la key sea igual a b
{r}
DT

# Equivalente a:
DT[c("b","c")]

# Subsetting omitir filas mediante keys
# El simbolo ! en data.table desempeña el mismo papel que el signo - en data frame.
DT
# Omitimos las filas donde key sea igual a a o b
DT[!c("a","b")] # equivalente

# Keyed by
# Para aplicar una función a los grupos generados por una key (tapply()) se utiliza:
DT
DT[,sum(v),by=key(DT)] # agrupamos mediante la key


# Group by
# Para aplicar una función a los grupos generados por una variable se utiliza:
DT
DT[,sum(v),by=y] # agrupamos mediante la variable y

# Group by
# Para aplicar una función a ciertos grupos generados mediate la key utilizamos:
DT["a"]
DT["a",sum(v)] # sum(v) en grupo a 

# Group by
# Para aplicar una función a ciertos grupos generados mediate la key utilizamos:
DT[c("a","b")]
# Si se trata de más de un grupo se debe añadir by=.EACHI
DT[c("a","b"),sum(v),by=.EACHI] # sum(v) en grupos a y b

## Joins
# Considere los data tables DT y DT2:
DT

DT2 <- data.table(c("b","c"),z=c(4,2))
DT2

# Para cruzar las información mediante la key de DT y la primera columna de DT2 utilizamos:
DT[DT2]

# Para cruzar la informacion de la primera fila del grupo usamos:
DT[DT2,mult="first"]

# Para cruzar la informacion de la última fila del grupo usamos:
DT[DT2,mult="last"]


# Modificacion de columnas
DT <- data.table(x=rep(c("a","b","c"),each=2), y=c(0,1), v=1:6)
DT

# Para añadir una columna a newcol a DT utilizamos:
DT[,newcol:=8L] # add col por referencia

# Eliminación de columnas
DT
# Para eliminar la columna newcol de DT utilizamos:
DT[,newcol:=NULL] # remove col por referencia

# Modificacion de columnas existentes
setkey(DT,x)
DT
# Para reasignar valores a una variable existente usamos:
print(DT["a",v:=10L]) # subassign a col existente v por referencia

## Modificacion de columnas
setkey(DT,x)
DT
# Para asignar valores de una nueva variable utilizamos:
print(DT["b",v2:=9L]) # subassign a nueva col by por referencia (NA)

# Modificacion de columnas
setkey(DT,x)
DT
# Para asignar a cada elemento de un grupo valores resultantes de aplicar una función a dichos grupos
utilizamos:
DT[,m:=mean(v),by=x] # add nueva col por grupo


## Importando data a R

# read.table(file, header = FALSE, sep = "", dec=".", stringsAsFactors = TRUE, ...)


# fread( )
# fast file reader function
str(fread) 

# read.table( ) vs fread( )
# Utilizamos el archivo flights.csv (25MB).
system.time(
  read_base <- read.csv("flights.csv", header = TRUE, sep = ",")
)
dim(read_base)


# install.packages("data.table") 
library(data.table)
system.time(
  read_DT <- fread("flights.csv", sep = ",", header = F)
)
dim(read_DT)


- fread() es aproximadamente 10 veces más rápida que read.csv()





