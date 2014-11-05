setwd("~/Documents/workspace/coursera/ExData1") # your working dir here

# read the source data (same as plot1.R)
urlz <- paste0("https://d396qusza40orc.cloudfront.net/",
               "exdata%2Fdata%2Fhousehold_power_consumption.zip")
filez <- "power.zip"
file <- "household_power_consumption.txt"
download.file(url=urlz, destfile=filez, method="curl")
unzip(filez)
p <- read.table(file, header=TRUE, sep=";", stringsAsFactors=FALSE, 
                na.strings="?",quote="",comment.char="", strip.white=TRUE)  

# restrict to dates specified in assignment (same as plot1.R)
p <- p[p$Date %in% c("1/2/2007","2/2/2007"),]

# create a timestamp for plotting (same as plot2.R)
p$datetime <- as.POSIXlt(paste(p$Date, p$Time), format="%d/%m/%Y %H:%M:%S")

# unique(Sub_metering_1) are all integer values, so convert (not required)
for(i in grep("Sub_metering_\\d",names(p))) p[,i] <- as.integer(p[,i])

# Create Plot 4, a 2x2 grid as shown in the assignment
png(file = "plot4.png", bg = "white", width = 480, height = 480)
  par(mfrow=c(2,2))
  with(p,{
    # upper left: same as plot2.R
    plot(x = datetime, y=Global_active_power, type="l",
       ylab="Global Active Power", xlab="")
  
    # upper right: new plot of Voltage
    plot(x = datetime, y=Voltage, type="l", ylab="Voltage")
  
    # lower left: same as plot3.R
    color <- c("black","red","blue")
    vname <-  paste0("Sub_metering_",c(1:3)) 
    plot(x = datetime, y=Sub_metering_1, col=color[1], type="l",
         ylab="Energy sub metering", xlab="")
    lines(x = datetime,y=Sub_metering_2, col = color[2], type = "l")
    lines(x = datetime,y=Sub_metering_3, col = color[3],type = "l")
    legend("topright", lwd=1, vname, col=color, horiz=FALSE,bty="n", bg="white")
  
    # lower right: new plot of Global_reactive_power
    plot(x = datetime, y=Global_reactive_power, type="l",
         ylab="Global_reactive_power")
  })
dev.off()

