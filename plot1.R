file <- unzip("exdata-data-household_power_consumption.zip")
df <- read.table(file, header=TRUE, sep=";", na.strings="?")

# subset data to February 1, 2007 and February 2, 2007 only
df_gap <- subset(df, subset=df$Date %in% c("1/2/2007", "2/2/2007"),
                     select=c("Global_active_power"))

# convert to numeric values
df_gap <- as.numeric(df_gap[,])

png(filename = "plot1.png", width = 480, height = 480)

hist(df_gap,
     col = "red",
     main = "Global Active Power",
     yaxp = c(0, 1200, 6),
     xlab = "Global Active Power (kilowatts)",
     xaxp = c(0, 6, 3))

dev.off()

