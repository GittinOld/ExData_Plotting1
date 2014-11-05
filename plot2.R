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

# create a timestamp for plotting
p$DT <- as.POSIXlt(paste(p$Date, p$Time), format="%d/%m/%Y %H:%M:%S")

# Draw the correctly formatted plot to PNG
png(file = "plot2.png", bg = "white", width = 480, height = 480)
plot(x = p$DT, y=p$Global_active_power, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
