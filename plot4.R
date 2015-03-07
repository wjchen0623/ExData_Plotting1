library(dplyr)
library(lubridate)

elec_consump = read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                          stringsAsFactors = FALSE)
elec_consump[1] = as.Date(elec_consump[,1], format = "%d/%m/%Y")

elec_consump = filter(elec_consump, year(Date)==2007, month(Date)==2, 
                      mday(Date) == 1|mday(Date)==2)

elec_consump[ ,1] = as.character(elec_consump[, 1])
date.time = paste(elec_consump[ ,1], elec_consump[ ,2], sep =" ")
date.time = strptime(date.time, format = "%Y-%m-%d %H:%M:%S")

elec_consump = data.frame(date.time, elec_consump[3:9])
for (i in 2:8) {
  elec_consump[, i] = as.numeric(elec_consump[ ,i])
}


png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(elec_consump, {
  plot(date.time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilotwatts)")
  plot(date.time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(date.time,Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
  lines(date.time,Sub_metering_2, col = "red")
  lines(date.time,Sub_metering_3, col = "blue")
  legend("topright", lty = "solid", col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(date.time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})

dev.off()
