install.packages("tidyverse")
"yes"
library(tidyverse)
GreenJob <- read.csv("~/desktop/All_Green_Economy_Sectors.csv", header=TRUE)
summary(GreenJob)

# To get a good line graph, I needed a data set tracking growth over time
TimeTrend <- read.csv("~/Desktop/TimeTrendGreenJobs.csv", header=TRUE)
summary(TimeTrend)
TimeTrend$Job.Count <- as.numeric(TimeTrend$Job.Count)


#Green Economy Job Growth 2016-2026
ggplot(TimeTrend, aes(x=TimeTrend$Year, y=TimeTrend$Job.Count))+
  geom_line()+
  labs(title= "Green Economy Job Growth 2016-2026", x="2016-2026", y="Green Job Totals")
  

GreenJob$Category<- as.factor(GreenJob$Category)
GreenJob$Code<- as.factor(GreenJob$Code)
GreenJob$Occupation<- as.factor(GreenJob$Occupation)
GreenJob$Sectors<- as.factor(GreenJob$Sectors)
summary(GreenJob)
GreenJob <- read.csv("~/desktop/All_Green_Economy_Sectors.csv", header=TRUE)
Total_Occupation <- read.csv("~/Downloads/Occ20162026.csv", header=TRUE)
summary(Total_Occupation)
Total_Occupation$X2016.National.Employment.Matrix<-as.factor(Total_Occupation$X2016.National.Employment.Matrix)
Total_Occupation$Occupation <-as.factor(Total_Occupation$Occupation)
Total_Occupation$OCC.Group <-as.factor(Total_Occupation$OCC.Group)
Total_Occupation$OCC.Type <-as.factor(Total_Occupation$Occ.Type)
summary(Total_Occupation)
WageData <- read.csv("~/Desktop/national_M2018_dl.csv",header=TRUE)
summary(WageData)
WageData$OCC_CODE <-as.factor(WageData$OCC_CODE)
WageData$Occupation <-as.factor(WageData$Occupation)
WageData$OCC_GROUP <-as.factor(WageData$OCC_GROUP)
summary(WageData)

write.csv(WageData,"~/Desktop/Wage043019.csv")
#[new dataset] <- left_join([green jobs data], [cleaned wages data])
#left_join(x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"), ...)
#(ljsp <- left_join(superheroes, publishers))
GreenJobs1 <- left_join(GreenJob,Total_Occupation)

GreenJobClean <- read.csv("~/desktop/Learning Analytics/GreenJobs043019.csv", header=TRUE)
GreenJobClean$Category <- as.factor(GreenJobClean$Category)
GreenJobClean$Code<- as.factor(GreenJobClean$Code)
GreenJobClean$Occupation<- as.factor(GreenJobClean$Occupation)
GreenJobClean$Sectors <- as.factor(GreenJobClean$Sectors)
GreenJobClean$X2016.Current <- as.integer(GreenJobClean$X2016.Current)
GreenJobClean$X2026.Projected <- as.integer(GreenJobClean$X2026.Projected)
clean <- na.omit(GreenJobClean)
summary(GreenJobClean) 
summary(GreenJobClean$Sectors)
#QC to consolidate any duplicate names
test<- group_by(GreenJobClean,GreenJobClean$Sectors)
summary(test)
ggplot(test, aes(x=test$Category, y=test$Sectors))+
  geom_point()

ggplot(GreenJobClean, aes(x=GreenJobClean$X2016.Current, y=GreenJobClean$A_MEDIAN2, color=GreenJobClean$Category))+
  geom_point()

ggplot(data=GreenJobClean)+
    geom_point(mapping=aes(x=GreenJobClean$X2016.Current, y=GreenJobClean$A_MEDIAN2))

ggplot(GreenJobClean,aes(x=GreenJobClean$X2016.Current, y=GreenJobClean$Change.Percent, color=GreenJobClean$Category))+
  geom_line()

#t + labs(title =" New title", x = "New x", y = "New y")
#ll of the above

ggplot(data=GreenJobClean)+
geom_point(aes(x=X2016.Current,y=C, color=Category))

ggplot(GreenJobClean,aes(x=GreenJobClean$X2016.Current, y=GreenJobClean$Change.Percent, color=GreenJobClean$Category))+
geom_point()+
labs(title="Job Growth Trends 2016-2026", x="2016 Green Economy Jobs",y="Change Percent 2016-2026")


#Category by Job Growth
ggplot(data=GreenJobClean)+
  geom_point(aes(x=Category,y=X2026.Projected))

#Job Categories - usable

basic_category <- plot(GreenJobClean$Category)        
ggsave("basic_category.png", dpi=300)

coplot(GreenJobClean$A_MEDIAN2~GreenJobClean$X2026.Projected|GreenJobClean$Category)

avgsalarysector <-tapply(GreenJobClean$A_MEDIAN2,GreenJobClean$Sectors,mean)
barplot(avgsalarysector,
  main="Mean (Median) Salary by Sector")+
  

#usable - job growth by sector
plot(GreenJobClean$Sectors,GreenJobClean$X2016.Current, type="1")

        
#Not all Sectors are listed
plot(GreenJobClean$Sectors)

plot(GreenJobClean$A_MEDIAN2)


ggplot(data=GreenJobClean)
#ggplot(surveys, aes(x = weight, y = hindfoot_length))

#2026 Numbers - save this
jobgrowth <- ggplot(GreenJobClean, aes(x=GreenJobClean$X2016.Current, y= GreenJobClean$Change.Percent, color=GreenJobClean$Sector))+
geom_point()+ ggtitle("2016-2026 Job Growth")+ xlab("2016 Job Numbers")+ ylab("2026 Job Growth")
ggsave("jobgrowth.png", dpi=300)

#how enhanced skills and increased demand are growing and declining
ggplot(GreenJobClean, aes(x=GreenJobClean$X2016.Current, y= GreenJobClean$Change.Percent, color=GreenJobClean$Category))+
  geom_smooth()+

#manufacturing - declining, renewable energy is increasing, research design and consulting - usable
ggplot(GreenJobClean, aes(x=GreenJobClean$A_MEDIAN2, y= GreenJobClean$Change.Percent, color=GreenJobClean$Sectors))+
  geom_jitter()

#hourly rate - by category usable
ggplot(GreenJobClean, aes(x=GreenJobClean$Category, y= GreenJobClean$H_MEDIAN))+
  geom_boxplot()

#median income by category -
GreenJobClean[which(GreenJobClean$A_MEDIAN2 %in% outliers),]


ggplot(GreenJobClean, aes(x=GreenJobClean$Category, y= GreenJobClean$A_MEDIAN2, color=GreenJobClean$Category))+
  geom_boxplot(GreenJobClean$disp)+
  labs(title="Median Income in the Green Economy", x="Green Economy Categories", y="Annual Median Income (thousands)")

#t + labs(title =" New title", x = "New x", y = "New y")
#All of the above


ggplot(GreenJobClean, aes(x=GreenJobClean$Sectors, y=GreenJobClean$X2026.Projected))+
  geom_boxplot()

#median income by sector
ggplot(GreenJobClean, aes(x=GreenJobClean$A_MEDIAN, y= GreenJobClean$Category, color=GreenJobClean$Category))+
  geom_boxplot()

#median income by occupation
ggplot(GreenJobClean, aes(x=GreenJobClean$Occupation, y= GreenJobClean$A_MEDIAN, color=A_MEDIAN))+
  geom_boxplot()

summary(GreenJobClean)
summary(GreenJobClean$Category)

#projected job growth 2026
ggplot(GreenJobClean, aes(x=GreenJobClean$Category,y= GreenJobClean$X2026.Projected,na.rm=TRUE, color=GreenJobClean$X2026.Projected))+
  geom_point()

#test something else
ggplot(GreenJobClean, aes(x=GreenJobClean$X2016.Current,y= GreenJobClean$A_MEDIAN2, color=GreenJobClean$Sectors))+
  geom_point()
  
summary(GreenJobClean$Category)              
                                                                                                                  
ggplot(GreenJobClean, aes(x=GreenJobClean$Category,y= GreenJobClean$Employment.Percent,na.rm=TRUE, color=GreenJobClean$X2026.Projected))+
  geom_line()                                                                                                              
#2026 by category - use this one 
plot(GreenJobClean$Category, GreenJobClean$X2026.Projected, col=GreenJobClean$X2026.Projected)


ggplot(GreenJobClean, aes(x=GreenJobClean$Sectors,y= GreenJobClean$Change.Percent))+
  geom_point()

GreenJobClean$IsChange.PercentAbove5 <- ifelse(GreenJobClean$Change.Percent>5, 1,0)
GreenJobClean$IsAbove613.72 <- ifelse(GreenJobClean$A_MEDIAN2>613.72, 1,0)


ggplot(GreenJobClean, aes(x=GreenJobClean$IsChange.PercentAbove5, y=GreenJobClean$IsAbove56516, color=GreenJobClean$Category))+
  geom_point()

ggplot(GreenJobClean, aes(x=GreenJobClean$Category,y= GreenJobClean$IsAbove613.72,na.rm=TRUE, color=GreenJobClean$Sectors))+
  geom_jitter()  
ggplot(GreenJobClean, aes(x=GreenJobClean$Category,y= GreenJobClean$A_MEDIAN,na.rm=TRUE, color=GreenJobClean$Category))+
  geom_jitter()  

with(GreenJobClean,GreenJobClean$IsChange.PercentAbove5==1)

#job growth above 5^
ggplot(GreenJobClean, aes(x=GreenJobClean$Category, y= GreenJobClean$IsChange.PercentAbove5, na.rm=TRUE))+
       geom_jitter()

#most job growth is in green enhanced skills
ggplot(GreenJobClean, aes(x=GreenJobClean$Category, y= GreenJobClean$Change.Percent, na.rm=TRUE, color=GreenJobClean$Category))+
  geom_jitter()

#categorical distro by money
ggplot(GreenJobClean, aes(x=GreenJobClean$Category, y= GreenJobClean$A_MEDIAN, na.rm=TRUE, color=GreenJobClean$Category))+
  geom_jitter()

#Hourly by Category
ggplot(GreenJobClean, aes(x=GreenJobClean$Category, y= GreenJobClean$H_MEDIAN, na.rm=TRUE, color=GreenJobClean$Sectors))+
  geom_jitter()

ggplot(GreenJobClean, aes(x=GreenJobClean$Category, y= GreenJobClean$H_MEDIAN, na.rm=TRUE, color=GreenJobClean$Sectors))+
  geom_jitter()

#Job Growth - by categories
ggplot(GreenJobClean, aes(x=GreenJobClean$X2016.Current, y= GreenJobClean$X2026.Projected, na.rm=TRUE, color=GreenJobClean$Category))+
  geom_smooth()
#green enhanced skills are the highest and lowest paying
  ggplot(GreenJobClean, aes(x=GreenJobClean$X2016.Current, y= GreenJobClean$A_MEDIAN2, na.rm=TRUE, color=GreenJobClean$Category))+
  geom_smooth()+
labs(title="Median Income Levels in the Green Economy", x="2016 Green Economy Jobs", y="Annual Median Income (Thousands)")
           
#labs(title =" New title", x = "New x", y = "New y") )

ggplot(GreenJobClean, aes(x=GreenJobClean$Category, y=GreenJobClean$Change.Number, na.rm=TRUE, color=GreenJobClean$Category))
  geom_jitter()


  # Simple Horizontal Bar Plot with Added Labels 
  #counts <- table(mtcars$gear)
  #barplot(counts, main="Car Distribution", horiz=TRUE,
          #names.arg=c("3 Gears", "4 Gears", "5 Gears"))
  
  counts <- table(GreenJobClean$Sectors)
  barplot(counts, main="Sector Distribution, horz=TRUE,")
  
  counts1 <- table(GreenJobClean$Category)
  barplot(counts, main="Sector Distribution, horz=TRUE,")
  
  ## Stacked Bar Plot with Colors and Legend
 # counts <- table(mtcars$vs, mtcars$gear)
  #barplot(counts, main="Car Distribution by Gears and VS",
   #       xlab="Number of Gears", col=c("darkblue","red"),
    #      legend = rownames(counts))
 #number of jobs today (2016)
   counts3 <-table(GreenJobClean$X2016.Current,GreenJobClean$Category)
    barplot(counts3)
  
    counts4 <-table(GreenJobClean$X2026.Projected,GreenJobClean$Category)
    barplot(counts4)

  
hist(GreenJobClean$A_MEDIAN)  

d<- density(GreenJobClean$A_MEDIAN)
plot(d)

#Income by 2016 green jobs
attach(GreenJobClean)
plot(GreenJobClean$Category,GreenJobClean$A_MEDIAN, main="income by 2016 green jobs")
abline(lm(GreenJobClean$X2016.Current~GreenJobClean$A_MEDIAN), col="red")
abline(lm(GreenJobClean$X2026.Projected~GreenJobClean$A_MEDIAN), col="blue")

#2016 job nymbers - 2016 through line
plot(GreenJobClean$X2026.Projected, GreenJobClean$A_MEDIAN2)
abline(lm(GreenJobClean$X2026.Projected~GreenJobClean$A_MEDIAN2), col="blue")

plot(GreenJobClean$X2026.Projected, GreenJobClean$A_MEDIAN2)+
abline(lm(GreenJobClean$X2016.Current~GreenJobClean$X2026.Projected), col="green")

#Income by 2016 jobs with through line
plot(GreenJobClean$X2016.Current, GreenJobClean$A_MEDIAN)
abline(lm(GreenJobClean$X2016.Current~GreenJobClean$A_MEDIAN2), col="blue")


#plot job growth with amount
plot(GreenJobClean$Category, GreenJobClean$A_MEDIAN2)+
abline(lm(GreenJobClean$Change.Percent~GreenJobClean$A_MEDIAN2), col="green")+
  abline(lm(GreenJobClean$Change.Percent~GreenJobClean$H_MEDIAN), col="blue")

#usable
plot(GreenJobClean$X2016.Current, GreenJobClean$Change.Percent)+
  abline(lm(GreenJobClean$Change.Percent~GreenJobClean$A_MEDIAN2), col="green")+
  abline(lm(GreenJobClean$Change.Percent~GreenJobClean$H_MEDIAN), col="blue")


#iris %>%
#group_by(Species) %>%
 # summarise(avg = mean(Sepal.Width)) %>%
  #arrange(avg)

GreenJobClean %>%
  group_by(GreenJobClean$Category) %>%
  summarize(avg=mean(GreenJobClean$Change.Percent,)) %>%
  arrange(avg)


glimpse(GreenJobClean)  

#ggplot(mpg, aes(fl, fill = drv))
#Graph 1
GreenEconomyGrowth <- ggplot(GreenJobClean, aes(Category, fill=Sectors))+
geom_bar(position= position_dodge(width=.9))+
ggtitle("Green Economy Growth")+
labs(title="Green Economy Growth",x="Green Economy Categories",y="Employment")

plot(GreenEconomyGrowth)

GreenEcon1 <- ggplot(GreenJobClean, aes(Category, fill=Sectors))+
  geom_bar(position=position_dodge(width=.5))


#Top Growing Green Jobs
GreenJobClean %>%
  group_by(GreenJobClean$Occupation)
  arrange(GreenJobClean$Occupation,GreenJobClean$X2026.Projected)

  write.csv(GreenJobClean,"~/Desktop/GreeJobClean.csv")


                                                                    
