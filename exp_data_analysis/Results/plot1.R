plot1 <- function(fileurl) {
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
    
    ## create plot 1
    png(filename="plot1.png", bg="transparent")
    par("bg"="transparent")
    hist(realdata$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
    dev.off()
}