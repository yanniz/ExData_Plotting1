filepath="./data/household_power_consumption.txt"
# use shell script to find out the row number where it starts to record 3/2/2007 data 
# grep -n  "3/2/2007" household_power_consumption.txt | head -1
df <- read.table(filepath,header=TRUE,sep=";",nrows=70000)
df_sub <- df[df$Date %in% c("1/2/2007","2/2/2007"),]
df_sub$Date <- as.Date(df_sub$Date, "%d/%m/%Y")
df_sub$DateTime <- strptime(paste(df_sub$Date, df_sub$Time), "%Y-%m-%d %H:%M:%S") 

png(file="plot3.png", width=480, height=480)

#plot(df_sub$Sub_metering_1~df_sub$DateTime, type="l",xlab="", ylab="Energy sub metering")
with(df_sub,plot(DateTime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))

#Plot lines
#lines(df_sub$DateTime,df_sub$Sub_metering_2,col="red")
lines(df_sub$DateTime, as.numeric(as.character(df_sub$Sub_metering_2)), type = "l", col = "red")
lines(df_sub$DateTime,df_sub$Sub_metering_3,col="blue")

#Add legend
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1),col=c("black","red","blue"))
dev.off()