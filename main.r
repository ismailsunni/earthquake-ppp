# Show the data
# Intesity
# Density with 
# Quadrat counting --> homogenous
# Quadrat test CSR  --> p value --> not complete spatial randomness
# Kest --> 
# Kinhom for inhomogenous

rm(list = ls())  # Clear data
library(splancs)
library(spatstat)
library(geojsonio)
# library(OpenStreetMap)
# library(rgdal)

# Set working directory
setwd("/home/ismailsunni/dev/r/eq-project")

# Data loading
path <- "eq-filtered.geojson"
eqsp <- geojson_read(path, what='sp')  # Read GeoJSON as SpatialPointsDataFrame
tail(eqsp)  
# eq <- as.ppp.SpatialPointsDataFrame(eq)  # Convert to ppp
eq <- as(eqsp, "ppp")  # Convert to ppp

# Boundary
bd <- readRDS("gadm36_IDN_0_sp.rds")

# Plot data and boundary
plot(bd, , main='Earthquake in Indonesia July 2014 - February 2019')  # Ploting boundary
plot(unmark(eq), add=TRUE, cex=2, col="red", pch=21)  # Ploting without marks


# Show the data
summary(eq)  # Show summary of the data
any(duplicated(eq))  # Check if there is a duplication
plot(unmark(eq), main='Earthquake in Indonesia')  # Ploting without marks
plot(eq, which.marks = 'depth', main='Earthquake in Indonesia (depth)', bg="red")  # Plot with depth
plot(bd, add=TRUE)
plot(eq, which.marks = 'magnitude', main='Earthquake in Indonesia (magnitude)')  # Plot with magnitude  
plot(bd, add=TRUE)
plot(eq, which.marks = 'year', main='Earthquake in Indonesia (year)')  # Plot with year
plot(bd, add=TRUE)

# Density
plot(density(eq))
plot(bd, add=TRUE)

# Contour
contour(density(eq))
plot(bd, add=TRUE)

# Perspective
persp(density(eq), theta = 30, phi = 30) 

# Showing per year
eq2015 = subset(eq, year==2015)
eq2016 = subset(eq, year==2016)
eq2017 = subset(eq, year==2017)
eq2018 = subset(eq, year==2018)

par(mfrow=c(2,2))
title <- 'Earthquake in Indonesia '
plot(unmark(eq2015), main=paste(title, '(2015)', eq2015$n, 'events'), bg="red", pch=21, cex=4)  # Ploting without marks
plot(bd, add=TRUE)
plot(unmark(eq2016), main=paste(title, '(2016)', eq2016$n, 'events'), bg="red", pch=21, cex=4)  # Ploting without marks
plot(bd, add=TRUE)
plot(unmark(eq2017), main=paste(title, '(2017)', eq2017$n, 'events'), bg="red", pch=21, cex=4) # Ploting without marks
plot(bd, add=TRUE)
plot(unmark(eq2018), main=paste(title, '(2018)', eq2018$n, 'events'), bg="red", pch=21, cex=4)  # Ploting without marks
plot(bd, add=TRUE)

# Big earthquake
eqbig = subset(eq, magnitude>=6)
plot(unmark(eqbig), bg="red", pch=21, cex=4)
plot(bd, add=TRUE)

eq2015 = subset(eqbig, year==2015)
eq2016 = subset(eqbig, year==2016)
eq2017 = subset(eqbig, year==2017)
eq2018 = subset(eqbig, year==2018)

par(mfrow=c(2,2))
title <- 'Big Earthquake in Indonesia '
plot(unmark(eq2015), main=paste(title, '(2015)', eq2015$n, 'events'), bg="red", pch=21, cex=4)  # Ploting without marks
plot(bd, add=TRUE)
plot(unmark(eq2016), main=paste(title, '(2016)', eq2016$n, 'events'), bg="red", pch=21, cex=4)  # Ploting without marks
plot(bd, add=TRUE)
plot(unmark(eq2017), main=paste(title, '(2017)', eq2017$n, 'events'), bg="red", pch=21, cex=4) # Ploting without marks
plot(bd, add=TRUE)
plot(unmark(eq2018), main=paste(title, '(2018)', eq2018$n, 'events'), bg="red", pch=21, cex=4)  # Ploting without marks
plot(bd, add=TRUE)

par(mfrow=c(2,2))
title <- 'Earthquake in Indonesia (magnitude)'
plot(eq2015, which.marks = 'magnitude', main=paste(title, '(2015)')  # Plot with magnitude
plot(eq2016, which.marks = 'magnitude', main=paste(title, '(2016)')  # Plot with magnitude
plot(eq2017, which.marks = 'magnitude', main=paste(title, '(2017)')  # Plot with magnitude
plot(eq2018, which.marks = 'magnitude', main=paste(title, '(2018)')  # Plot with magnitude

# Quadrat count
Q <- quadratcount(eq, nx=4, ny=3)
Q
plot(Q, cex=5)
plot(bd, , main='Earthquake in Indonesia July 2014 - February 2019', add=TRUE)  # Ploting boundary
plot(unmark(eq), add=TRUE, cex=2, col="red", pch=21)  # Ploting without marks

# Intensity
plot(intensity(Q, image=TRUE), main=NULL, las=1)  # Plot density raster
plot(unmark(eq), pch=20, cex=0.6, col=rgb(0,0,0,.5), add=TRUE)  # Add points

# Quadrat test CSR
M=quadrat.test(eq, nx=4, ny=3)
M
plot(bd, , main='Earthquake in Indonesia July 2014 - February 2019', add=TRUE)  # Ploting boundary
plot(unmark(eq), add=TRUE, cex=2, col="red", pch=21)  # Ploting without marks
plot(M, add=TRUE, cex=5)

# Distance test
G <- Gest(eq)
plot(G)

# Kest
K <- Kest(eq)
K
plot(K)

E <- envelope (eq, Kest, nsim=39)
E
plot(E)

# Kinhom
Ki <- Kinhom(eq)
Ki
plot(Ki)

Ei <- envelope (eq, Kinhom, nsim=39)
plot(Ei)

# Area Interaction
ppm(unmark(eq), ~1, AreaInter(r=1))