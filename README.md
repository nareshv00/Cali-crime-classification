# California crime classification
##Visualizing crime patterns:
This is the first time I am working with R and a data set of this size, to explore the data I have started with descriptive and exploratory data analysis for different crimes across the city. Totally, there are more than 90 different types of crimes in the city.

•	You can observe that larceny is the top most crime in the city, from the table below we can observe top 10 crimes constitute to 83.5% of total crimes which happened in San Francisco.

1.	Top 10 Crime Counts
 
I have plotted the crimes with the hour of occurance in the San Francisco city map using latitude and longitude and coloring them with time of the crime. Time ranges from 0 to 23 where 0 is midnight or 12 am.

From below figure, I observed  dark shaded blue points and light shaded blue points in most of the locations, From the Hour meter We can see that light blue dots are after 8 pm and dark blue dots are after 12 am midnight, this interval of time is when most of the crimes happen. Police can have more patrol officers during this time frame than regular time to reduce crimes.

2. Crimes with respect to hour of the day in San Francisco
 
To analyze the above conclusion, I have plotted number of crimes with respect to Hour of the crime occurred. From this plot I have observed that more crimes occur in the afternoon between 12 pm-1 pm and evening times 5pm-7pm.

This might be because most people go out for lunch and in the evening time people travel back to home from offices, People tend to go out for dinner, knowing this fact might Police department. 

3.Number of Crimes with respect to hour of the day
 
Pink dots explains that most of the crimes occurred on Friday, which is an obvious fact considering weekend. Some of the places in the below plot are having crimes happening only in specific days, Police can optimally use the resources by allocating them according to the day.

4. Crimes with respect to Day in San Francisco
 



Plotting crimes with respect to hour and day of occurrence, we can see that on Saturdays after 10 there are large number of crimes happening, which states that many people might go out to celebrate or dinner. Every day most of the crimes are happening in between 6pm-12am time frame. 

5. Crimes with respect to Day and hour of happening
 
From the line plot below I have observed that most of the crimes take place on Fridays and the least number of crimes take place on Sunday. During weekdays most number of crimes take place in Wednesday’s.

6. Crimes with respect to Day 
 

•	Observing the below plot, I have noticed that at 12pm most of the crimes take place on weekdays. 
•	Highest number of crimes after 10pm takes place on Saturdays and it is the peak time for crimes on Saturdays. 
•	Friday evening has more crime occurrences than any other day.
•	Least number of crimes take place on Sunday’s.


7. Crimes with respect to Day and hour of happening
 
more crime is occurring in 12 after noon and around 8'0 clock in the night

Crime densities in the below plot showing light color has more crime occurrences than the dark areas. Obvious fact we can conclude is most number of crimes take place in evenings on any given day.

   8. Heat map according to day vs date with respect to number of crimes
 



Big dots convey more number of crimes in a particular location, we can observe this in Frequency meter. Most number of crimes occur in financial district of san Francisco. Police department can think of having more troops in the areas with big dots. Good way to see the map is by looking the Freq meter, it says the counts of crimes from 0 to 1 lakh interval and assigns colors to the crimes using a gradient.

9. Crimes counts in San Francisco streets
 
I have plotted the above plot using the tile function which created a heat map, this plot conveys better than visualizing with points in my opinion. We have Freq to observe the number of times a crime occurred. Dark red squares are the areas police should concentrate more.

10. Crimes counts in San Francisco streets
 

Finally, I have created heat maps with respect to each crime category, these are better solutions for visualization and interpretation, I have added few of them here. However, when you run the code all the individual heat maps will be saved on your local for better visualization. Below way I have plotted all the categories and interestingly most of the crimes occur in financial district of San Francisco which is highlighted with dark red tile. This is obvious because there are lot of people working.

11. Larceny crimes in San Francisco streets
 
12. Warrants crimes in San Francisco streets
 

13 Vandalism crimes in San Francisco streets

 
