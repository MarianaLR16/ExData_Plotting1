#Crear dataframe
datos <- read.table(file = "household_power_consumption.txt", 
                    header = T, sep = ";", fill = TRUE,
                    na.strings = "?", stringsAsFactors = FALSE)

#Cambiar a clase fecha

fecha <- datos$Date
tiempo <- datos$Time
x <- paste(fecha,tiempo)
datos$fechatiempo <- strptime(x, format="%d/%m/%Y %H:%M:%S")
as.POSIXct(datos$fechatiempo)

#Conocerlímites
datos2dias <- subset( datos, datos$fechatiempo >= "2007-02-01 00:00:00" & datos$fechatiempo <= "2007-02-02 23:59:00")



#Gráfica
png(filename = "plot1.png", width = 480, height = 480)
 plot1 <- hist((datos2dias$Global_active_power),
     main = "Global Active Power", col = "red", 
     xlab = "Global Active Power(kilowatts)")
dev.off()


