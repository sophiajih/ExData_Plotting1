plot2 <- function(fileurl) {
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
    
    ## create plot 2
    png(filename="plot2.png", bg="transparent")
    par("bg"="transparent")
    plot(dataplot$Global_active_power ~ dataplot$datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
    dev.off()
}