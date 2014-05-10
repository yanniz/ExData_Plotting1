filepath="./data/household_power_consumption.txt"
# use shell script to find out the row number where it starts to record 3/2/2007 data 
# grep -n  "3/2/2007" household_power_consumption.txt | head -1
df <- read.table(filepath,header=TRUE,sep=";",nrows=70000)
df_sub <- df[df$Date %in% c("1/2/2007","2/2/2007"),]
df_sub$Date <- as.Date(df_sub$Date, "%d/%m/%Y")
df_sub$DateTime <- strptime(paste(df_sub$Date, df_sub$Time), "%Y-%m-%d %H:%M:%S") 

png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# chart 1
with(df_sub,plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active df_sub (kilowatts)"))

# chart 2
with(df_sub,plot(DateTime,Voltage,type="l",xlab="datetime",ylab="Voltage"))

# chart 3
with(df_sub,plot(DateTime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
# lines(df_sub$DateTime,df_sub$Sub_metering_2,col="red")
lines(df_sub$DateTime, as.numeric(as.character(df_sub$Sub_metering_2)), type = "l", col = "red")
lines(df_sub$DateTime,df_sub$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1),col=c("black","red","blue"))

# chart 4
with(df_sub,plot(DateTime,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_df_sub"))
dev.off()