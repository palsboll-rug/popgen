#first load the needed packages/libraries
library('diveRsity')
library("ggplot2")

#Make a list named Nm, with the migration rates (4*Nm) for input to ms command 
#Nm <- c(25, 20, 15, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0.9, 0.8, 0.7, 0.5, 0.4, 0.3, 0.2, 0.1, 0.05, 0.01)
Nm <- c(seq(0.001, 25, by = 0.05))

#Make an empty list for Fst_WC estimates named Fst
Fst <- Nm

#Combine the two lists into a 2-column data frame named final_data
final_data <- data.frame(Fst, Nm)

#name columns in data frame
names(final_data) <-c("WC_Fst", "Nm")

#start a counter so result is added to the next cell in Fst column in final_data
counter <- 1

#go through all values in the Nm column in the final_data data frame   
for (nm in Nm) { # here the next value in the Nm column is assigned to a variable named nm
  # here we make the text for the ms command. We need to combine it in three parts to add the current value of nm
  # to the command. Remember that ms uses 4 times Nm 
  ms_text <- paste("ms 120 20 -t 1.0 -I 2 60 60",  4*nm, "| microsat | ms_usat_conversion 120 20 2 60 60 genepop > data")
  
  #tell system to run the command in the ms_text variable
  try(system(ms_text))
  
  #save the fst calculations conducted by diveRsity's fastDivPart function to a data frame named results
  results <- fastDivPart(infile = "data", fst = TRUE)
  
  #save the Fst_WC estimate in the "Global" row in the $estimate list in the results data frame to our final_data in
  #the Fst column, at the corresponding Nm value, which we moved to by using the counter
  final_data$WC_Fst[counter] <- results$estimate[21,7] #by trial and error I found out that the global Fst_WC value 
                                          # was in the 2d $estimate atomic vector row 21, column 7
  
  #increase the counter by 1 to make sure the next Fst_WC estimate is saved in the next cell 
  counter <- counter+1
}

# Finally make a simple lone plot of the six data points using ggplot in an object named fig
fig <- ggplot(final_data, aes(x = Nm, y = WC_Fst)) + geom_point()

ggplot(final_data, aes(x = Nm, y = WC_Fst)) + geom_point()

#open an .pdf output file
pdf("rplot.pdf")

#print the plot fig
print(fig)

#"close" the file
dev.off()
