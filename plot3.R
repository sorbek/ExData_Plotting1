file <- unzip("exdata-data-household_power_consumption.zip")
df <- read.table(file, header=TRUE, sep=";", na.strings="?")

# subset data to February 1, 2007 and February 2, 2007 only
df_sm <- subset(df, subset=df$Date %in% c("1/2/2007", "2/2/2007"),
                    select=c("Date", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# convert columns to numeric values
df_sm$Sub_metering_1 <- as.numeric(df_sm$Sub_metering_1)
df_sm$Sub_metering_2 <- as.numeric(df_sm$Sub_metering_2)
df_sm$Sub_metering_3 <- as.numeric(df_sm$Sub_metering_3)

# convert Date column to standard format Year-Month-Day
df_sm$Date <- strptime(df_sm$Date, "%d/%m/%Y")

# create Datetime column
df_sm$Datetime <- paste(df_sm$Date, df_sm$Time)
df_sm$Datetime <- strptime(df_sm$Datetime, "%Y-%m-%d %H:%M:%S")

png(filename = "plot3.png", width = 480, height = 480)

with(df_sm, plot(Datetime, Sub_metering_1,
                 ylab = "Energy sub metering",
                 yaxp = c(0, 30, 3),
                 xlab = "",
                 type = "n"))

# plot sub_metering_1 in black (default color)
with(df_sm, lines(Datetime, Sub_metering_1, ylab = ""))

# plot sub_metering_2 in red
with(df_sm, lines(Datetime, Sub_metering_2, col = "red", ylab = ""))

# plot sub_metering_3 in blue
with(df_sm, lines(Datetime, Sub_metering_3, col = "blue", ylab = ""))

# add legend
legend("topright", lty = "solid",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"))

dev.off()

