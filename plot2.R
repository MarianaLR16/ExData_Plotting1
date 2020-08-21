
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

#Gráfica
png(filename = "plot2.png", width = 480, height = 480)
plot2 <- plot(datosprueba$Time,as.numeric(as.character(datosprueba$Global_active_power)),
     type="l",xlab="",ylab="Global Active Power (kilowatts)") 
dev.off()

