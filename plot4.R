file <- unzip("exdata-data-household_power_consumption.zip")
df <- read.table(file, header=TRUE, sep=";", na.strings="?")

# subset data to February 1, 2007 and February 2, 2007 only
df_p4 <- subset(df, subset=df$Date %in% c("1/2/2007", "2/2/2007"),
                    select=c("Date", "Time", "Global_active_power", "Global_reactive_power",
                             "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# convert columns to numeric values
df_p4$Global_active_power <- as.numeric(df_p4$Global_active_power)
df_p4$Global_reactive_power <- as.numeric(df_p4$Global_reactive_power)
df_p4$Voltage <- as.numeric(df_p4$Voltage)
df_p4$Sub_metering_1 <- as.numeric(df_p4$Sub_metering_1)
df_p4$Sub_metering_2 <- as.numeric(df_p4$Sub_metering_2)
df_p4$Sub_metering_3 <- as.numeric(df_p4$Sub_metering_3)

# convert Date column to standard format Year-Month-Day
df_p4$Date <- strptime(df_p4$Date, "%d/%m/%Y")

# create Datetime column
df_p4$Datetime <- paste(df_p4$Date, df_p4$Time)
df_p4$Datetime <- strptime(df_p4$Datetime, "%Y-%m-%d %H:%M:%S")

par(bg = "transparent")
png(filename = "plot4.png", width = 480, height = 480, bg = "transparent")

# set up 2 by 2 plots
par(mfrow = c(2, 2))

# generate plot 1 (upper left)
with(df_p4, plot(Datetime, Global_active_power,
                 ylab = "Global Active Power",
                 yaxp = c(0, 6, 3),
                 xlab = "",
                 type = "l"))

# generate plot 2 (upper right)
with(df_p4, plot(Datetime, Voltage,
                 ylab = "Voltage",
                 yaxp = c(234, 246, 6),
                 xlab = "datetime",
                 type = "l"))

# generate plot 3 (lower left)
with(df_p4, plot(Datetime, Sub_metering_1,
                 ylab = "Energy sub metering",
                 yaxp = c(0, 30, 3),
                 xlab = "",
                 type = "n"))

# plot sub_metering_1 in black (default color)
with(df_p4, lines(Datetime, Sub_metering_1, ylab = ""))

# plot sub_metering_2 in red
with(df_p4, lines(Datetime, Sub_metering_2, col = "red", ylab = ""))

# plot sub_metering_3 in blue
with(df_p4, lines(Datetime, Sub_metering_3, col = "blue", ylab = ""))

# add legend
legend("topright", lty = "solid",
       bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"))

# generate plot 4 (lower right)
with(df_p4, plot(Datetime, Global_reactive_power,
                 yaxp = c(0.0, 0.5, 5),
                 xlab = "datetime",
                 type = "l"))

dev.off()

