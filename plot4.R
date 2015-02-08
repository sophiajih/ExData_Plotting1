plot4 <- function(fileurl) {
    ## load necessary libraries
    library(datasets)
    
    ## load necessary data files    
    if(!file.exists("./exp_data_analysis/household_power_consumption.txt")) {
        dir.create("./exp_data_analysis")
        download.file(fileurl, destfile="./exp_data_analysis/elecpowerconsump.zip")
        unzip("./exp_data_analysis/elecpowerconsump.zip", exdir="./exp_data_analysis")
    }
    
    ## read in data
    fulltable <- read.table("./exp_data_analysis/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings="?")
    fulltable$Date <- as.Date(fulltable$Date, "%d/%m/%Y")
    realdata <- fulltable[fulltable$Date == "2007-02-01" | fulltable$Date == "2007-02-02",]
    
    ## add in date+time column
    datetime <- strptime(paste(realdata$Date, realdata$Time), "%Y-%m-%d %H:%M:%S")
    dataplot <- cbind(realdata, datetime)
    
    ## create plot 4
    png(filename="plot4.png", bg="transparent")
    par("bg"="transparent", mfrow=c(2,2))
    with(dataplot, {
        plot(dataplot$Global_active_power ~ dataplot$datetime, type="l", ylab="Global Active Power", xlab="")
        plot(datetime, Voltage, type="l")
        plot(datetime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
        points(datetime, Sub_metering_2, type="l", col="red")
        points(datetime, Sub_metering_3, type="l", col="blue")
        legend("topright", col=c("black", "red", "blue"), box.col="transparent",cex=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=c(1,1,1), lwd=c(2.5, 2.5, 2.5))
        plot(datetime, Global_reactive_power, type="l")
    })
    dev.off()
    
}