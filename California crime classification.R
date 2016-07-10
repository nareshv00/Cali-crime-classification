#data cleaning
#loading the data sets into r environment
SFtrain=read.csv('../train.csv/train.csv',stringsAsFactors = FALSE)


#removing the variables  resolution and descriptionn of the crime 
#as  these variables are not available in test set, I believe it is hard to interpret 
#to get results.
SFtrain$Descript=NULL
SFtrain$Resolution=NULL


#changing the Dates variable n to a datetime data type using strptime 
SFtrain$Dates=strptime(SFtrain$Dates,format = '%Y-%m-%d %H:%M:%S')

# splitting date into year,month,day and the hour to anaylze the data with different instances
#Gour in which crime occured
SFtrain$Hour=as.numeric(format(SFtrain$Dates,'%H'))

#Date of the crime occured
SFtrain$Date=as.numeric(format(SFtrain$Dates,'%d'))
#Month of the crime occured
SFtrain$MonthNumber=as.numeric(format(SFtrain$Dates,'%m'))
#dividing the name of the month  crime occured
SFtrain$Month=factor(months(SFtrain$Dates),
                     levels=c("January","February","March","April","May","June","July","August","September","October","November","December"))
#Year in which crime occured
SFtrain$Year=as.numeric(format(SFtrain$Dates,'%Y'))
#reordering the ordered variable day of the week in working week hour type in training set
SFtrain$DayOfWeek=factor(SFtrain$DayOfWeek,
                         levels=c("Monday", "Tuesday","Wednesday","Thursday", "Friday","Saturday","Sunday"))

#taking the number of the Weekday, to input as the numerical variable into a model if necessary
SFtrain$DayNumber=as.numeric(SFtrain$DayOfWeek)


#feature engineering 
#creating a new feature called Night with help of 
#crime occured hour, I Categorized Hour into five categories called Morning,
#Afternoon,Evening,Night and Mid Night
SFtrain$Night=factor(ifelse(SFtrain$Hour>18,'Night'
                            ,ifelse(SFtrain$Hour<=3,'Mid Night',
                                    ifelse(SFtrain$Hour<=10,'Morning',
                                           ifelse(SFtrain$Hour<=15,'Afternoon','Evening')))),
                     levels = c('Morning','Afternoon','Evening','Night','Mid Night'))


#converting the dependent variable crime category into a factor variable

SFtrain$Category=factor(SFtrain$Category)


# converting districts into unordererd categorical variable in both testing and training
#training set
SFtrain$PdDistrict=factor(SFtrain$PdDistrict)

#feature engineering of the address
# converting address variable using bag of words into more useful factor variable
#preprocessing address using tm(text mining),
library(tm)
library(SnowballC)
#training set
#converting address to lower case
SFtrain$Address=tolower(SFtrain$Address)

# removing punctuation
SFtrain$Address=removePunctuation(SFtrain$Address)

#removing stop words
SFtrain$Address=removeWords(SFtrain$Address,c("st","av",stopwords("en")))

# using address and checking whether it is useful or not
#created a data frame from table command to check the number of times an address was a crime scene
AdressCount=as.data.frame.table(sort(table(SFtrain$Address),decreasing = TRUE))
#checking top 1000 addresses sum which is are crime scene for 411163 crimes.
#Remaining addresses are low crime frequency areas with less crimes happening.
#I stored tthe remaining addreses as others.
sum(AdressCount$Freq[1:1000])
SFtrain$AddressRank=factor(ifelse(SFtrain$Address %in% AdressCount$Var1[1:1000],
                                  SFtrain$Address,'others'))



#visualizing crimes using ggplot2 and crimes

# visualizing with tables
#We can observe from the below command 
#that top 10 crimes consitute to 83.5% of total crimes
tableCategory=sort(table(SFtrain$Category),decreasing = TRUE)
sum(as.vector(tableCategory[1:10]))/nrow(SFtrain)*100


# we are plotting the location with the categody variable to seggregate crimes
#by coloring them
#There is not much we can derive from the below plot, But if you observe closely
#there are dark shaded blue points and light shaded blu points in most of the occurences
#From the Hour meter it is said that light blue dots are after 8'o pm and dark blue dots
#are after 12' am in night.
#I believe most of the crimes occur between this intervel. 
locationCategoryPlot=ggplot(subset(SFtrain,X>=-122.46&X<=-122.38&Y>=37.72&Y<=37.78),aes(x=X,y=Y,color=Hour))
locationCategoryPlot+geom_point()

#we try plotting number of crimes with respect to Hour of the crime Occured
#in this initial analysis we can observe that more crimes occure in the afternoon,
#where many people go out for lunch etc and night time where people go from 
#offices, dinner etc.
CrimeCountPlot=ggplot(SFtrain,aes(x=Hour))
CrimeCountPlot+geom_bar(color='Blue',fill='white')

# setting blue colored triangular structured points for the observation
# we can see that we did not achieve anything from this map as the crimes are spread throught 
# the region
locationPlot=ggplot(subset(SFtrain,X>=-122.46&X<=-122.38&Y>=37.72&Y<=37.78),
                    aes(x=X,y=Y,color=DayOfWeek))
locationPlot+geom_point()


#plotting hour to the day, we used face wrap for categories, as we are assuming linear relations
#hip will continue in 
TimeDayPlot=ggplot(SFtrain,aes(x=Hour))
TimeDayPlot+geom_bar(colour = "black", fill = "blue")+ 
  facet_wrap(~DayOfWeek,scales = "free")+ggtitle("Hour of the day vs the week day")


#Weekday counts of the crimes, we can clearly observe that the crimes are more on
#fridays, we used group=1 to get all the groups in one line and with number of thefts
#line graph in the plot
WeekdayCrimes=as.data.frame(table(SFtrain$DayOfWeek))
WeekdayCrimes
ggplot(WeekdayCrimes,aes(x=Var1,y=Freq))+geom_line(aes(group=1))+xlab("Day Of the week")+
  ylab("Number of motor vehicle thefts ")


#plotting count of days vs  hour  on the line plot

DayAndHour=as.data.frame(table(SFtrain$DayOfWeek,SFtrain$Hour))
str(DayAndHour)
DayAndHour$Var2=as.numeric(as.character(DayAndHour$Var2))
colnames(DayAndHour)[1]="DayOfWeek"
colnames(DayAndHour)[2]="Hour"

ggplot(DayAndHour,aes(x=Hour,y=Freq))+geom_line(aes(group=DayOfWeek,color=DayOfWeek),size=1.5)+
  xlab("Hour")+ylab("Crime Count")+ggtitle("crimes per hour on different days ")


#Heat map according to Hour vs DayOfWeek with respect to number of crimes,We can clearly observe
#more crime is occuring in 12 afternoon and arouind 8'0 clock in the night
#we are using gradient to change the name, color of the gradient , theme to remove the y-axis name.
ggplot(DayAndHour,aes(x=Hour,y=DayOfWeek))+geom_tile(aes(fill=Freq),size=1.5)+
  ggtitle("crimes per hour on different days ")+theme(axis.title.y=element_blank())+
  scale_fill_gradient(name="Crime Count",low ="black",high = 'white')


#loading ggmap and maps packages
library(ggmap)
library(maps)
SFmap=readRDS("../input/sf_map_copyright_openstreetmap_contributors.rds")
#creating a heat map kind on the san fransisco map by using the area with the location,
#to do this I am narrowing the Lon, Lat to three and two decimals
#to group data based on this,we can also use limit(low,high) values to limit the 
#freq levels.

LatLon=as.data.frame(table(round(SFtrain$X,2),round(SFtrain$Y,2)))
str(LatLon)
#converting data types of names and data types of Var1 and Var2

LatLon$Var1=as.numeric(as.character(LatLon$Var1))
LatLon$Var2=as.numeric(as.character(LatLon$Var2))

ggmap(SFmap)+geom_point(data=LatLon,aes(x=Var1,y=Var2,color=Freq,size=Freq))+
  scale_color_gradient(high = "red",low='blue')


#a heat map on San Fransisco
ggmap(SFmap)+geom_tile(data=LatLon,aes(x=Var1,y=Var2,alpha=Freq),fill='Red')

#visualizing the different geometric map of SF for different crimes,LARCENY/THEFT all the once 
#These will be saved in your local.
for (CrimeCat in unique(SFtrain$Category)) {
  cat("category is ",CrimeCat)
  
  LatLonCategory=as.data.frame(table(round(subset(SFtrain,Category==CrimeCat)$X,2),round(subset(SFtrain,Category==CrimeCat)$Y,2)))

  LatLonCategory$Var1=as.numeric(as.character(LatLonCategory$Var1))
  LatLonCategory$Var2=as.numeric(as.character(LatLonCategory$Var2))
  LatLonCategory$Freq=as.numeric(LatLonCategory$Freq)
  paste(ggmap(SFmap)+geom_tile(data=LatLonCategory,aes(x=Var1,y=Var2,alpha=Freq),fill='Red')+ggtitle(paste("heat map of",CrimeCat," crimes")))
  
  CategoryMap=ggmap(SFmap)+geom_tile(data=LatLonCategory,aes(x=Var1,y=Var2,alpha=Freq),fill='Red')+ggtitle(paste("heat map of",CrimeCat," crimes"))
  pdf(paste(removePunctuation(CrimeCat),'.pdf'))
  print(CategoryMap)
  dev.off()
}



