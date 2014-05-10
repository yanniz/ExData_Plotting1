filepath="./data/household_power_consumption.txt"
# use shell script to find out the row number where it starts to record 3/2/2007 data 
# grep -n  "3/2/2007" household_power_consumption.txt | head -1
df <- read.table(filepath,header=TRUE,sep=";",nrows=70000)
df_sub <- df[df$Date %in% c("1/2/2007","2/2/2007"),]
df_sub$Date <- as.Date(df_sub$Date, "%d/%m/%Y")
df_sub$DateTime <- strptime(paste(df_sub$Date, df_sub$Time), "%Y-%m-%d %H:%M:%S") 

# Open png device
png(file="plot1.png", width=480, height=480)

# Plot histogram
hist(as.numeric(df_sub$Global_active_power),col="red",xlab="Global Active Power (kilowatts)", 
     main="Global Active Power")

# Close png device
dev.off()