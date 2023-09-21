dataset<-read.csv("../data/hotel_bookings.csv",header=TRUE,sep=",",stringsAsFactors = FALSE)
head(dataset)
str(dataset)
summary(dataset)
#Limpieza de datos
cantidad_duplicadas <- sum(duplicated(dataset))
cat("Cantidad de filas duplicadas:", cantidad_duplicadas, "\n")
dataset <- dataset[!duplicated(dataset), ]
sin_valor <- function(x){
  sum = 0
  for(i in 1:ncol(x))
  {
    cat("En la columna",colnames(x[i]),"total de valores NA:",colSums(is.na(x[i])),"\n")
  }
}
sin_valor(dataset)
en_blanco <- function(x){
  sum = 0
  for(i in 1:ncol(x))
  {
    cat("En la columna",colnames(x[i]),"total de valores en blanco:",colSums(x[i]=="NULL"),"\n")
  }
}
en_blanco(dataset)
dataset$agent<-NULL
dataset$company<-NULL
#pregunta 1
#¿Cuántas reservas se realizan por tipo de hotel? o ¿Qué tipo de hotel prefiere la gente?
#tabla de frecuencias de la columna hotel
install.packages("knitr")
install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
library(ggplot2)
library(knitr)
freq_table <- dataset %>%
  count(hotel)

kable(freq_table)
#grafico de barras cantidad de reservas segun tipo de hotel
freq_table %>%
  ggplot(aes(x = hotel, y = n)) +
  geom_bar(stat = "identity", fill = c("red", "blue")) +
  xlab("Tipo de hotel") +
  ylab("Número de reservas") +
  geom_text(aes(label = n), position = position_stack(vjust = 0.5), colour = "white")+
  labs(title = "Cantidad de reservas realizadas segun tipo de hotel")
#pregunta2
#¿Está aumentando la demanda con el tiempo?
disp_line1<- dataset %>%
  filter(arrival_date_year == 2015) %>%
  count(arrival_date_month)
disp_line2<- dataset %>%
  filter(arrival_date_year == 2016) %>%
  count(arrival_date_month)
disp_line3<- dataset %>%
  filter(arrival_date_year == 2017) %>%
  count(arrival_date_month)
disp_line1$arrival_date_month <- factor(disp_line1$arrival_date_month,levels =c("January","February","March","April","May","June","July","August","September","October","November","December"))
disp_line2$arrival_date_month <- factor(disp_line2$arrival_date_month,levels =c("January","February","March","April","May","June","July","August","September","October","November","December"))
disp_line3$arrival_date_month <- factor(disp_line3$arrival_date_month,levels =c("January","February","March","April","May","June","July","August","September","October","November","December"))
ggplot(data = disp_line1, aes(x = arrival_date_month, y = n)) +
  geom_point(size = 6,colour="#FFFFFF") +
  geom_line(group = 1) +
  geom_text(aes(label = n), size = 4,colour="blue")+
  labs(title = "Reservas realizadas en el año 2015 según mes", x = "Mes", y = "Número de reservas")
ggplot(data = disp_line2, aes(x = arrival_date_month, y = n)) +
  geom_point(size = 6,colour="#FFFFFF") +
  geom_line(group = 1) +
  geom_text(aes(label = n), size = 4,colour="blue")+
  labs(title = "Reservas realizadas en el año 2016 según mes", x = "Mes", y = "Número de reservas")
ggplot(data = disp_line3, aes(x = arrival_date_month, y = n)) +
  geom_point(size = 6,colour="#FFFFFF") +
  geom_line(group = 1) +
  geom_text(aes(label = n), size = 4,colour="blue")+
  labs(title = "Reservas realizadas en el año 2017 según mes", x = "Mes", y = "Número de reservas")
#pregunta3y4
#¿Cuándo es menor la demanda de reservas?¿Cuándo se producen las temporadas de reservas: alta, media y baja?
dataset$season <- ifelse(
  dataset$arrival_date_month %in% c("June", "July", "August"),
  "summer",
  ifelse(
    dataset$arrival_date_month %in% c("September", "October", "November"),
    "fall",
    ifelse(
      dataset$arrival_date_month %in% c("December", "January", "February"),
      "winter",
      "spring"
    )
  )
)


disp_line<- dataset %>%
  count(season)

#disp_line$arrival_date_month <- factor(disp_line$arrival_date_month,levels =c("January","February","March","April","May","June","July","August","September","October","November","December"))
ggplot(data = disp_line, aes(x = season, y = n)) +
  geom_point(size = 6,colour="#FFFFFF") +
  geom_line(group = 1) +
  geom_text(aes(label = n), size = 4,colour="blue")+
  labs(title = "Reservas realizadas según estaciones del año", x = "Estacion", y = "Número de reservas")
ggplot(disp_line, aes(x = season, y = n,fill = season)) +
  geom_bar(stat = "identity") +
  labs(
    x = "Estacion",
    y = "Cantidad de reservas",
    title = "Reservas realizadas según estaciones del año"
  ) +
  geom_text(aes(label = n), position = position_stack(vjust = 0.5), colour = "white",fontface="bold")+
  theme_minimal()

#´pregunta5
#¿Cuántas reservas incluyen niños y/o bebes? 
df_chba <- dataset %>%
  select(children, babies)
head(df_chba)
df_chba$has_children_or_babies <- ifelse(df_chba$children > 0 | df_chba$babies > 0, "Yes", "No")
table(df_chba$has_children_or_babies)
df_chba<- df_chba %>%
  count(has_children_or_babies)

ggplot(df_chba, aes(x="", y=n, fill=has_children_or_babies))+
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0) +
  scale_fill_manual(values=c("#131D6A", "#DAB200"),labels=c("No","SI"),name = "Tiene niños y/o bebés")+
  geom_text(aes(label=paste0(round(n/sum(n)*100, 2), "%")), position = position_stack(vjust = 0.5),colour="white",size=5)+
  labs(title = "Porcentaje de reservas que tienen niños Y/O bebes")
#pregunta6
#¿Es importante contar con espacios de estacionamiento?
parking <- dataset %>%
  select(required_car_parking_spaces)
parking$requires_parking <- ifelse(parking$required_car_parking_spaces > 0, "Yes", "No")
parkingtable<- parking%>%
  count(requires_parking)
print(parkingtable)
percentparking<-(parkingtable$n[2]/sum(parkingtable$n))*100
print(percentparking)
ggplot(parkingtable, aes(x="", y=n, fill=requires_parking))+
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0) +
  scale_fill_manual(values=c("#F8FF64", "#79E57B"),labels=c("No","SI"),name = "Requieren estacionamiento")+
  geom_text(aes(label=paste0(round(n/sum(n)*100, 2), "%")), position = position_stack(vjust = 0.5))+
  labs(title = "Porcentaje de reservas que solicitaron estacionamiento")+
  expand_limits(x=c(-1,1))
#pregunta7
#¿En qué meses del año se producen más cancelaciones de reservas?
bookingcanceled<-dataset %>%
  group_by(arrival_date_month) %>%
  summarise(n_canceled = sum(is_canceled == "1"))
print(bookingcanceled)
bookingcanceled$arrival_date_month <- factor(bookingcanceled$arrival_date_month,levels =c("January","February","March","April","May","June","July","August","September","October","November","December"))
ggplot(bookingcanceled, aes(x = arrival_date_month, y = n_canceled)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Cantidad de reservas canceladas segun mes", x = "Mes", y = "Número de reservas")+
  geom_text(aes(label = n_canceled), position = position_stack(vjust = 0.5), colour = "white")
#pregunta8
#¿Que tipo de habitacion es la mas reservada? 
roomtype<-dataset %>%
  count(reserved_room_type)
print(roomtype)
ggplot(roomtype, aes(x = reserved_room_type, y = n)) +
  geom_bar(stat = "identity", fill = "skyblue", position="stack") +
  labs(title = "Cantidad de reservas realizadas segun tipo de habitacion", x = "Tipo de habitacion", y = "Número de reservas")+
  geom_text(aes(label = n), size=4, colour = "black",fontface="bold")
#pregunta9
#¿Cuales son los tipos de habitaciones mas caros y mas baratos?
roomsprice<-dataset%>%
  group_by(assigned_room_type) %>%
  summarise(price=sum(adr))
roomtype2<-dataset %>%
  count(assigned_room_type)
roomsprice$average<-as.numeric(roomsprice$price)/as.integer(roomtype2$n)
roomsprice$average<-as.integer(roomsprice$average)
print(roomsprice)
ggplot(roomsprice, aes(x = assigned_room_type, y = average, fill = assigned_room_type)) +
  geom_bar(stat = "identity") +
  labs(
    x = "Tipo de habitacion",
    y = "Precio promedio",
    title = "Distribucion de precio promedio de reserva segun tipo de habitación",
    fill="Tipo de habitacion"
  ) +
  geom_text(aes(label = average), position = position_stack(vjust = 0.5), colour = "white",fontface="bold")+
  theme_minimal()

#pregunta10
#¿Cual es la relacion entre el tipo de hotel y la duracion de la estadia?
staytime<-dataset%>%
  select(hotel,stays_in_week_nights,stays_in_weekend_nights)
staytime$days<-as.integer(staytime$stays_in_week_nights)+as.integer(staytime$stays_in_weekend_nights)

#pregunta11
#¿De que pais provienen los clientes que realizan mas reservas segun el tipo de hotel?

#pregunta12
#¿Cual es el promedio de costo de las reservas? ¿Existen valores atipicos?
