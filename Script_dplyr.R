#############################
###    dplyr - package    ###
#############################

# Instalación
install.packages('dplyr', dependencies = TRUE)

if (packageVersion("devtools") < 1.6) {
      install.packages("devtools")
}
devtools::install_github("hadley/lazyeval")
devtools::install_github("hadley/dplyr")

# Cargamos la informacion necesaria
library(dplyr)

hflights <- tbl_df(read.csv("flights.csv", stringsAsFactors = FALSE))

hflights_db <- src_sqlite("hflights.sqlite3", create = TRUE)

copy_to(hflights_db, as.data.frame(flights), name = "flights", 
        indexes = list(c("date", "hour"), "plane", "dest", "arr"), temporary = FALSE)
copy_to(hflights_db, as.data.frame(weather), name = "weather", 
        indexes = list(c("date", "hour")), temporary = FALSE)
copy_to(hflights_db, as.data.frame(airports), name = "airports", 
        indexes = list("iata"), temporary = FALSE)
copy_to(hflights_db, as.data.frame(planes), name = "planes", 
        indexes = list("plane"), temporary = FALSE)

flights_db <- hflights_db %>% tbl("flights")
weather_db <- hflights_db %>% tbl("weather")
planes_db <- hflights_db %>% tbl("planes")
airports_db <- hflights_db %>% tbl("airports")

## Operador magrittr

iris %>% head

iris %>% tail(5)

c(1, 2, 3, NA) %>% mean()
c(1, 2, 3, NA) %>% mean(na.rm = TRUE)
iris %>% mutate(dim=Sepal.Length*Sepal.Width) %>% filter(!is.na(dim)) %>% group_by(Species) %>%summarise(avg=mean(dim), sd=sd(dim)) 


### Ejercicio Final ###
library(data.table)
options(stringsAsFactors = FALSE)
data1 <- data.table(read.table("data_gb.txt", sep="\t", header = TRUE, dec=","))
data2 <- data.table(read.table("Demograficos.txt", sep="\t", header = TRUE, dec=","))
data3 <- data.table(read.table("Rev Cartera.txt", sep="\t", header = TRUE, dec=","))
data4 <- data.table(read.table("Var Score.txt", sep="\t", header = TRUE, dec=,))

setkey(data1, Identificacion)
setkey(data2, Identificacion)
setkey(data3, Identificacion)
setkey(data4, Identificacion)

consolidado <- data2[data3][data4]
dim(consolidado)

data <- inner_join(data1, consolidado, by= "Identificacion")
dim(data)
class(data)

table(data %>% select(Genero))

data$Genero <- ifelse(data$Genero == "M", "M",
                      ifelse(data$Genero == "F", "F", "M"))

data <- data %>% mutate(ln_mayor.val.venc=ifelse(mayor.val.venc>0, 
                                         log(mayor.val.venc), 0))

data <- data %>% mutate(comprometido=couta.est/ingreso, 
                        mora=total.venc/total.deuda)
data <- data %>% mutate(CodEstadoCivil=ifelse(EstadoCivil==1, "soltero",
            ifelse(EstadoCivil==2, "casado",
            ifelse(EstadoCivil==3, "divorciado",
            ifelse(EstadoCivil==4, "viudo", "union libre")))))
data <- data %>% mutate(prbm_deuda_vencplus_new_3 = 
                        ifelse(deuda_vencplus_new_3 <= 0, 0.987,
                        ifelse(deuda_vencplus_new_3 <= 53, 0.964,
                        ifelse(deuda_vencplus_new_3 <= 354, 0.919, 0.795))))
datos1 <- data %>% filter(GB_90 %in% c(0,1))

modelo <- glm(GB_90 ~ prbm_deuda_vencplus_new_3+ln_mayor.val.venc+mora+
          comprometido+score, family=binomial("logit"), data=datos1)

summary(modelo)

datos1[, lapply(.SD, class)]
