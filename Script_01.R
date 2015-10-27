###############################
### Script Nivel Intermedio ###
########    CLase 01  #########

# abreviacion de cadenas
head(USArrests)

states <- rownames(USArrests)
head(states)

substr(x = states, start = 1, stop = 4)

states2 <- abbreviate(states)
states2

state_chars <- nchar(states)
state_chars
barplot(table(state_chars), main="Número de caracteres")

# busqueda por patrones
grep(pattern = "w", states, value = TRUE)
grep(pattern = "[wW]", states, value = TRUE)
grep(pattern = "w", tolower(states), value = TRUE)
grep(pattern = "W", toupper(states), value = TRUE)

# paquete stringr
install.packages('stringr', dependencies=TRUE)
library(stringr)

str_count(states, "a")

str_count(tolower(states), "a")

vocales <- c("a", "e", "i", "o", "u")
num_vocales <- vector(mode = "integer", length = 5)

for (i in seq_along(vocales)) {
      num_aux <- str_count(tolower(states), vocales[i])
      num_vocales[i] <- sum(num_aux) 
}


names(num_vocales) <- vocales
num_vocales

# funcion paste
paste("El valor de pi es: ", pi)
paste("Curso", "R", "Intermedio", sep = "-")
paste(c("a", "b", "c"), c("1r", "2r", "3r"), sep="")
paste("S", 1:8, sep = ".")
paste(1:3, c("!", "?", "+"), sep = "", collapse = "")
paste(1:3, c("!", "?", "+"), sep = "")

chartr("a", "A", "Ecuador se encuentra en Sudamérica")

chartr("cu", "C", "Ecuador se encuentra en Sudamérica")

substr("abcdef", start = 2, stop = 4)

x <- c("may", "the", "force", "be", "with", "you")

substr(x, 2, 2) <- "#"
x

y <- c("may", "the", "force", "be", "with", "you")
substr(y, 2, 3) <- ":)"
y

z <- c("may", "the", "force", "be", "with", "you")
substr(z, 2, 3) <- c("#", "@")
z

substring("ABCDEF", 2, 4)

change <- c("Be the change", "you want to be")
# extraemos la primera palabra
word(change, 1)
# extraemos la ultima palabra
word(change, -1)
#extraemos todo menos las dos primeras
word(change, 2, -1)

# estructuras de datos

x <- c(1, 2, 3)
y <- c(4, 5, 6)
res <- rbind(x,y)
res
class(res)
dim(res)

dx <- data.frame(A=letters[1:2], B=c(3, 9))
dy <- data.frame(A=letters[4:6], B=c(1, 4, 6))
dres <- rbind(dx, dy)
res
class(dres)
dim(dres)

x <- c(1, 2, 3)
y <- c(4, 5, 6)
res <- cbind(x,y)
res
class(res)
dim(res)

dx <- data.frame(A=letters[1:3], B=c(3, 9, 2))
dy <- data.frame(A=letters[4:6], B=c(1, 4, 6))
dres <- cbind(dx, dy)
dres
class(dres)
dim(dres)

cbind(1, 1:3)
rbind(1:4, 2)
cbind(0, rbind(1, 1:3))

A <- data.frame(letter=LETTERS[1:4], a=1:4)
B <- data.frame(letter=LETTERS[sample(6)], x=runif(6))
merge(A, B)
merge(A, B, all=TRUE)

bdd1 <- data.frame(name=c("Luis", "Jose", "David", "Dario"), edad=c(20, 35, 43, 29))
bdd2 <- data.frame(nombres=c("Pepe", "Jose", "Lucas", "Luis", "Dario", "Sergio"), 
                   estcivil=c("S", "C", "S", "V", "S", "C"))
bdd3 <- data.frame(edad=c(18, 20, 35, 40, 45), sueldo=c(500, 620, 750, 890, 1200))
merge(bdd1, bdd2, by.x="name", by.y="nombres")
merge(bdd1, bdd3, by="edad")

match(c("B", "E"), LETTERS)
match(c("B", "3", "E"), c("3", "A", "5", "B", "F", "P"))

c("B", "E") %in% LETTERS
c("B", "3", "E") %in% LETTERS

vec <- c(3.4, NA_real_, -7.1)
typeof(vec)
vec <- c(5, NA_integer_, 9)
typeof(vec)

vec <- c("a", NA_character_, "b")
typeof(vec)
vec <- c(2+1i, NA_complex_, -3i)
typeof(vec)

vec <- c(3.5, 2.6, 4.1, 2.7, 3.9, 5.0, NA_integer_, 1.1, NA_integer_)
mean(vec)
mean(vec, na.rm = TRUE)
sd(vec)
sd(vec, na.rm = TRUE)

vec <- c(3.5, 2.6, 4.1, 2.7, 3.9, 5.0, NA_integer_, 1.1, NA_integer_)
is.na(vec)
vec[!is.na(vec)]

which(is.na(vec))
sum(!is.na(vec))

vec <- c(2, 3, 6, 4, 1, 2, 8, 2, 3, 8, 1, 3, 2, 4, 8, 2)
table(vec)
unique(vec)
sort(unique(vec))

vec <- c(2, 3, 6, 4, 1, 2, 8, 2, 3, 8, 1, 3, 2, 4, 8, 2)
duplicated(vec)

# cantidad de valores duplicados
sum(duplicated(vec))
vec[duplicated(vec)]

data <- data.frame(name=c("A", "B", "C", "D", "E", "F", "G"),
                   edad=c(18, 12, 42, 29, 47, 32, 25),
                   hijos=c(1, 0, 4, 2, 3, 2, 0))

data$d_hijos <- ifelse(data$hijos==0, "SIN HIJOS", "CON HIJOS")
head(data)

data$grupo <- ifelse(data$edad<=18, "[0-18]", ifelse(data$edad>18 & data$edad<=45, 
                                                     "[19-45]", "[46-100]"))
head(data, n=4)

data$lista <- ifelse(data$name %in% c("A", "B"), 1, 
                     ifelse(data$name %in% c("C", "D", "E"), 2, 3))
head(data, n=3)

install.packages('car', dependencies=TRUE)
library(car)

data <- data.frame(name=c("Ed", "Bill", "Camy", "Diego", "Edy", "Fer", "Giu"),
                   lista=c(2, 1, 4, 3, 5, 3, 2),
                   panel=c(1, 0, 2, 2, 1, 2, 0))

data$new_list <- recode(data$panel,'0=100; 1=101; else=102')
head(data, n=4)

vec <- c(1.2, 3.2, 4.5, 2.7, 6.1, 9.3, 8.3, 7.2, 11.4, 10.9)
cortes1 <- cut(vec, breaks=c(0, 3, 6, 12, 15))
cortes1
table(cortes1)
prop.table(table(cortes1))

vec <- c(-0.4, 1.2, 5.2, 4.1, -2.7, 6.9, 9.1, -0.4, 8.3, 7.2, 3.6, 11.4, 10.9)
cortes2 <- cut(vec, breaks=c(-5, 0, 5, 10, 15), labels=c("De -5 a 0", "De 0 a 5", "De 5 a 10", "De 10 a 15"))
table(cortes2)
round(100*prop.table(table(cortes2)), 2)


# muestras
sample(c(3,5,7,8), size=3)
sample(c(3,5,7,8), size=3, prob=c(0.1, 0.2, 0.3, 0.4))

muestra <- sample(1:300, size=60, replace=FALSE)
muestra
sum(duplicated(muestra))
muestra[duplicated(muestra)]

muestra <- sample(1:300, size=60, replace=TRUE)
muestra
sum(duplicated(muestra))
muestra[duplicated(muestra)]



### Muestreo / Modelamiento /validacion
# Solucion 1
nmod <- ceiling(0.7*nrow(sdata))
id_muestra <- sample(sdata$identificacion, size=nmod, replace=FALSE)
sdata$muestra <- ifelse(sdata$identificacion %in% id_muestra, "modelamiento", "validacion")
head(sdata)
round(prop.table(table(sdata$muestra)),2)

# Solucion 2
id <- sample(1:nrow(sdata), size=ceiling(0.7*nrow(sdata)), replace=FALSE)
df1 <- data.frame(sdata[id,], muestra="modelamiento")
id_val <- setdiff(1:nrow(sdata),id)
df2 <- data.frame(sdata[id_val,], muestra="validacion")
rbind(df1, df2)






