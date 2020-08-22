#Crear dataframe
datos <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(datos) <- c("Date","Time","Global_active_power","Global_reactive_power"
                  ,"Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")


#Conocerlímites

datosprueba <- subset(datos,datos$Date=="1/2/2007" | datos$Date =="2/2/2007")


#Cambiar a clase fecha
datosprueba$Date <- as.Date(datosprueba$Date, format="%d/%m/%Y")
datosprueba$Time <- strptime(datosprueba$Time, format="%H:%M:%S")

datosprueba[1:1440,"Time"] <- format(datosprueba[1:1440,"Time"],"2007-02-01 %H:%M:%S")
datosprueba[1441:2880,"Time"] <- format(datosprueba[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#New column
fecha <- datos$Date
tiempo <- datos$Time
x <- paste(fecha,tiempo)
datos$fechatiempo <- strptime(x, format="%d/%m/%Y %H:%M:%S")
as.POSIXct(datos$fechatiempo)

datos2dias <- subset( datos, datos$fechatiempo >= "2007-02-01 00:00:00" & datos$fechatiempo <= "2007-02-02 23:59:00")


# Creando gráfica y png
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))

#1

with(plot(datosprueba$Time,as.numeric(as.character(datosprueba$Global_active_power)),
          type="l",xlab="",ylab="Global Active Power (kilowatts)")) 

#2     
with(plot(datosprueba$Time,datosprueba$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
with(datosprueba,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(datosprueba,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(datosprueba,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, cex = 0.7, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))



#3
with (plot(datos2dias$fechatiempo, datosprueba$Voltage,
           type = "l", xlab= "datetime", ylab = "Voltage"))

#4
with(plot(datos2dias$fechatiempo, datosprueba$Global_reactive_power,
          type = "l", xlab= "datetime", ylab = "Global_reactive_power"))
dev.off()



