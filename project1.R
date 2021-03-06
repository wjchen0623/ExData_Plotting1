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

windows()
par(pin = c(480, 480))
hist(elec_consump$Global_active_power, col = "orangered1", 
    main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.copy(png, 'plot1.png')
dev.off()
