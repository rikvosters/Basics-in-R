####--- | solution: create new file  ---####

x <- c(1530, 1540, 1550, 1560, 1570, 1580, 1590, 1600)
x
y <- c(4, 9, 17, 48, 78, 92, 96, 98)
y
plot(x, y)


####--- | solution: hours of sleep  ---####

sleep_week <- c(7, 6, 5.5, 8, 6)
sleep_weekend <- c(5,11)
weekend_zzz <- mean(sleep_weekend) - mean(sleep_week)
weekend_zzz