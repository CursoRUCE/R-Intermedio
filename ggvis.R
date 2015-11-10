################################
#####     Script ggvis     #####
################################

library(dplyr)
library(ggvis)

#Ejercicio 1
mtcars %>% ggvis(~wt, ~mpg, fill := "red") %>% layer_points()

#Ejercicio 2
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% layer_smooths()

#Ejercicio 3
pressure %>% ggvis(~temperature, ~pressure) %>% layer_bars()

#Ejercicio 4
pressure %>% ggvis(~temperature, ~pressure, fill=~temperature, size=~pressure) %>% layer_points()

# Ejercicio 5
pressure %>% ggvis(~temperature, ~pressure, size := 100, fill := "red") %>% layer_points()

# Ejercicio 6
pressure$black <- c("black", "grey80", "grey50", "navyblue", "blue", "springgreen4", 
                    "green4", "green", "yellowgreen", "yellow", "orange", "darkorange", 
                    "orangered", "red", "magenta", "violet", "purple", "purple4", 
                    "slateblue")
pressure %>% 
      ggvis(~temperature, ~pressure, 
            fill := ~black) %>% 
      layer_points()

#Ejercicio 7
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()

pressure %>% ggvis(~temperature, ~pressure, stroke:="red", strokeWidth:=2, strokeDash:=6) %>% layer_lines()

#Ejercicio 8
mtcars %>% 
      ggvis(~mpg, ~wt, fill:= input_radiobuttons(label="Choose color", choices=c("black", "red", "blue", "green"))) %>% 
      layer_points()

#Ejercicio 9
mtcars %>% 
      ggvis(~mpg, ~wt, 
            fill := input_text(label = "Choose color", value = "black")) %>% 
      layer_points()

#Ejercicio 10
mtcars %>% 
      ggvis(~mpg, ~wt, 
            fill = input_select(label = "Choose fill variable:", 
                                choices = names(mtcars), map = as.name)) %>% 
      layer_points()

#Ejercicio 11
mtcars %>% 
      ggvis(~mpg) %>% 
      layer_histograms(width = input_numeric(1, label = "Choose a binwidth:"))

#Ejercicio 12
mtcars %>% 
      ggvis(~mpg) %>% 
      layer_histograms(width = input_slider(1, 20, value = 11, label="Choose a binwidth:"))

#Ejercicio 13
faithful %>% 
      ggvis(~waiting, ~eruptions) %>% 
      layer_points() %>% 
      add_axis("y", title = "Duration of eruption (m)", 
               values = c(2, 3, 4, 5), subdivide = 9) %>% 
      add_axis("x", title = "Time since previous eruption (m)")

#Ejercicio 14
faithful %>% 
      ggvis(~waiting, ~eruptions) %>% 
      layer_points() %>%
      add_axis("y", orient = "right") %>%
      add_axis("x", orient = "top")

#Ejercicio 15
faithful %>% 
      ggvis(~waiting, ~eruptions, opacity := 0.6, 
            fill = ~factor(round(eruptions))) %>% 
      layer_points() %>%
      add_legend("fill", title = "~ duration (m)", orient = "left")

