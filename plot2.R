file <- unzip("exdata-data-household_power_consumption.zip")
df <- read.table(file, header=TRUE, sep=";", na.strings="?")

# subset data to February 1, 2007 and February 2, 2007 only
df_gap <- subset(df, subset=df$Date %in% c("1/2/2007", "2/2/2007"),
                     select=c("Date", "Time", "Global_active_power"))

# convert column to numeric values
df_gap$Global_active_power <- as.numeric(df_gap$Global_active_power)

# convert Date column to standard format Year-Month-Day
df_gap$Date <- strptime(df_gap$Date, "%d/%m/%Y")

# create Datetime column
df_gap$Datetime <- paste(df_gap$Date, df_gap$Time)
df_gap$Datetime <- strptime(df_gap$Datetime, "%Y-%m-%d %H:%M:%S")

# select only columns needed for plot
df_gap <- df_gap[,c("Datetime", "Global_active_power")]

png(filename = "plot2.png", width = 480, height = 480)

with(df_gap, plot(Datetime, Global_active_power,
                  ylab = "Global Active Power (kilowatts)",
                  xlab = "",
                  type = "l"))

dev.off()

