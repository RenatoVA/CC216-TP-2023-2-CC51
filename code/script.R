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
#pregunta 1
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
disp_line<- dataset %>%
  count(arrival_date_month)
disp_line$arrival_date_month <- factor(disp_line$arrival_date_month,levels =c("January","February","March","April","May","June","July","August","September","October","November","December"))
ggplot(data = disp_line, aes(x = arrival_date_month, y = n)) +
  geom_point(size = 6,colour="#FFFFFF") +
  geom_line(group = 1) +
  geom_text(aes(label = n), size = 4,colour="blue")+
  labs(title = "Reservas realizadas según mes", x = "Mes", y = "Número de reservas")


#´pregunta5
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
bookingcanceled<-dataset %>%
  group_by(arrival_date_month) %>%
  summarise(n_canceled = sum(is_canceled == "1"))
print(bookingcanceled)
ggplot(bookingcanceled, aes(x = arrival_date_month, y = n_canceled)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Cantidad de reservas canceladas segun mes", x = "Mes", y = "Número de reservas")+
  geom_text(aes(label = n_canceled), position = position_stack(vjust = 0.5), colour = "white")
#pregunta8
#pregunta9
#pregunta10
#pregunta11