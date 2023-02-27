# Google Analytics Capstone: Cyclistic Chicago

The following case study is one of the capstone projects for the Google Analytics Certificate on Coursera.

**Author:**  Karlis Herrera [@hkarlis18](https://www.github.com/hkarlis18)
 
 ## :bike: Summary 

The case study follows the Google Analytics model for data analysis:

### :one:  [Ask](https://github.com/Hkarlis18/Divvy_Chicago_Google_Analytics_Capstone/new/main?readme=1#bike-ask)

### :two: [Prepare](https://github.com/Hkarlis18/Divvy_Chicago_Google_Analytics_Capstone/new/main?readme=1#bike-prepare)

### :three: [Process](https://github.com/Hkarlis18/Divvy_Chicago_Google_Analytics_Capstone/new/main?readme=1#bike-process)

### :four:  [Analyze](https://github.com/Hkarlis18/Divvy_Chicago_Google_Analytics_Capstone/new/main?readme=1#bike-analyze)

### :five:[Share](https://github.com/Hkarlis18/Divvy_Chicago_Google_Analytics_Capstone/new/main?readme=1#bike-share)

### :six:  [Act](https://github.com/Hkarlis18/Divvy_Chicago_Google_Analytics_Capstone/new/main?readme=1#bike-act)





## :bike: Overview 

Cyclistic is a bike-share company located in Chicago, the United States, that was launched in 2016. The company offers 5,800 bicycles 
and 600 docking stations in furtherance of creating friendly ways of transportation around Chicago. 

For the last 7 years, Cyclistic has focused on creating awareness campaigns so that people become familiar with the brand and what 
they offer. However, the company seeks to maximize the number of annual memberships as it is easier to convert casual riders into 
members of the program because they already know the brand and use the bike-share program according to their needs.

This analysis seeks to get answers regarding how casual bikers and member bikers use Cyclistic bikes differently. Therefore, with 
the insights obtained from the analysis, the brand expects to use that data to tailor its user's needs in order to develop new marketing 
strategies that will lead to the growth and expansion of the business. 





## :bike: Ask 

**Business task:** Analyze the Divvy biker's data to identify user habits and trends when using the bike-sharing program 
with the intention to use that information to guide its new marketing strategy to convert casual riders to members. 

 **Stakeholders:**

+ **Lily Moreno:** The director of marketing and your manager.

+ **Cyclistic marketing analytics team:**  A team of data analysts in charge of gathering and examining data in order 
to create the marketing strategist.

+ **Cyclistic executive team:** The committee team.


 **Key questions:**

1. How do annual members and casual riders use Cyclistic bikes differently?
 2. Why would casual riders buy Cyclistic annual memberships?
 3. How can Cyclistic use digital media to influence casual riders to become members?

:top: [ Back to Summary](https://github.com/Hkarlis18/Divvy_Chicago_Google_Analytics_Capstone/new/main?readme=1#bike-summary)


## :bike: Prepare 

**Data Source:** The analysis covered 12 months that goes from February 2022 to January 2023. The dataset used is public
under the following license, and it was made available by Motivate International Inc. Moreover, the data was stored 
in separate files for each month and they were identified correctly.


**ROCCC ANALYSIS**

Next, we will break down certain aspects regarding the dataset used that must be taken into consideration.

+ **Reliability:** Divvy has the rights over the license of this data. Divvy is a program that’s part of the
Chicago Department of Transportation (CDOT). The organization owns vehicles, stations, and a wide range 
of bikes around the city. 

+ **Original:** the data collected is from Motivate International Inc. They manage the City of Chicago’s
Divvy bicycle-sharing program.

+ **Comprehensive:** The data includes key information such as ride ID, type of bike, time the user started
and ended the ride, start and end time, station ID, longitude and latitude, and finally the type of membership.

+ **Current:** The data is up to date to January 2023.

+ **Cited:** the data is available under the current license agreement.


**Limitations**

+ **Pass purchases:** The data doesn’t offer the opportunity to connect previous pass purchases to determine
if users have purchased multiple single passes or the frequency.

+ **Personally identifiable information:** The dataset has restrictions regarding personal information such
as name, address, age, and gender. 

+ **Missing values:** The dataset presents NA values in aspects such as starting and ending station names, 
as well as the station ID.

:top: [ Back to Summary](https://github.com/Hkarlis18/Divvy_Chicago_Google_Analytics_Capstone/new/main?readme=1#bike-summary)



## :bike: Process

For the data cleaning process, Excel and SQL Server were used. The following checklist was applied 
to ensure the accuracy and integrity of the data.


+ Evaluate and choose what data would be necessary for the analysis
+ Check for typos and extra spaces within cells
+ Seek  duplicates
+ Examine the names of the columns to avoid using reserved words in SQL
+ Check for nulls and empty cells
+ Evaluate consistency across columns and data range



**Excel Analysis:**


+ Convert the data into a table for a smoother evaluation 
+ Change the member_casual column name to member_type
+ Remove the station longitude and latitude columns because for this analysis we are not going to use them
+ Create a column to determine the month in its number format by using the following formula =MONTH(C2,2)
+ Create a column for the weekday in its number format by using the formula =WEEKDAY(C2,2)
+ Calculate the ride length in minutes  by doing the following equation =(D2-C2)*1440

Once the data was clean and all the columns were the same in the 12 Excel files, I used the query and append functions 
to organize the data and have fewer files to analyze. The files append into single sheets  were:


+ February 2022, March 2022, and April 2022
+ October 2022, and November 11
+ December 2022, and January 2023


The rest of the months were kept as single files since the data was too large to append in Excel.

**SQL Analysis**


 First of all, I created a new database, then I imported the 8 files in a CSV format.

```
SELECT ride_id, rideable_type, started_at, ended_at, ride_month, day_of_week, no_weekday, ride_length_min, start_station_name, start_station_id,
  end_station_name, end_station_id,  member_type
  INTO Divvy_Analysis
  FROM ( 
  SELECT * FROM [dbo].[Bikes_Feb_April_2022]
  UNION ALL 
  SELECT * FROM [dbo].[Bikes_May_2022]
   UNION ALL 
   SELECT * FROM [dbo].[Bikes_June_2022]
   UNION ALL
   SELECT  *  FROM [dbo].[Bikes_July_2022]
   UNION ALL
   SELECT * FROM [dbo].[Bikes_August_2022]
   UNION ALL 
   SELECT * FROM [dbo].[Bikes_September_2022]
   UNION ALL
  SELECT  *  FROM [dbo].[Bikes_Oct_November_2022]
    UNION ALL
  SELECT * FROM [dbo].[Bikes_Dec22_Jan23]
  )
  AS DA
```
:loudspeaker: To see the complete SQL Server code of the analysis, please  [Click here](https://github.com/Hkarlis18/Divvy_Chicago_Google_Analytics_Capstone/blob/main/Bikes_Analysis.sql)
to check the rmd file.



:top: [ Back to Summary](https://github.com/Hkarlis18/Divvy_Chicago_Google_Analytics_Capstone/new/main?readme=1#bike-summary)




## :bike: Analyze

During this analysis, I focused on aspects such as the type of cyclist who used the program the most, what are the bicycles with the highest
demand, and the times with the greatest concentration, including days of the week, hours, and months.


**Key findings:** 

 + Casual users represented 61.24%, whilst members 38.76% of the rides from February 2022 to January 2023.


+ Over 475,000 rides are realized from members between Monday to Friday, while casual riders have the highest number of rides during the weekend.


+ The average ride length for members lies between 29 minutes to 34 minutes, while casual riders seem to do shorter rides with an average of 
12 to 13 minutes.


+ Most of the rides for both types of users were performed during the morning and the afternoons. 


+ The seasons with the highest demands are Spring and Summer. The volume starts to drop during Fall. 


+ The stations with the highest transit are Streeter Dr & Grand Ave, DuSable Lake Shore Dr & Monroe St, DuSable Lake Shore Dr & North Blvd,
Michigan Ave & Oak St, and Wells St & Concord Ln. 


+ The stations with the lowest demand are Kedvale Ave & 63rd St, Newcastle Ave & Wellington Ave, Ewing Ave & 102nd St,  Morgan St & 87th St,
Emerald Ave & 43rd St.


+ Classic bikes have the highest count of hours ridden. However, 51,08% of rides were made on an electric bike and just 45,84% on a classic bike.


:top: [ Back to Summary](https://github.com/Hkarlis18/Divvy_Chicago_Google_Analytics_Capstone/new/main?readme=1#bike-summary)



## :bike: Share 


All visualizations for this case study were made using Power Bi



![Cyclistic_Google_Capstone_1](https://user-images.githubusercontent.com/123211885/221691907-83bcc9bf-eefb-4a1e-9dd4-d24f50475e7f.png)
![Cyclistic_Google_Capstone_2](https://user-images.githubusercontent.com/123211885/221692759-534518a1-f32b-4cae-bf05-390afbe0f0cd.png)
![Cyclistic_Google_Capstone_3](https://user-images.githubusercontent.com/123211885/221693317-84b01989-f7e1-41be-bfa5-3bd3aebf6bc3.png)



:top: [ Back to Summary](https://github.com/Hkarlis18/Divvy_Chicago_Google_Analytics_Capstone/new/main?readme=1#bike-summary)




## :bike: Act


**Recommendations:**


+ Members have the highest number of rides during the week,  which leads us to think that members use the bike-sharing program for transportation
to work or to do errands on a daily basis.  On the other hand, casual riders seem to use it more for fun.

+ Some of the most popular stations are located near tourist areas of the city. It would be beneficial to run an analysis to determine how many of 
those casual users are living in Chicago and how many are just visiting. This way we can create a membership plan specific for tourists.

+ Since the demand for bicycles begins to decline in autumn due to the change of weather, Cyclistic could take advantage of those months to create 
special offers to obtain a membership at a lower cost.
        
+ Remove stations that are getting a demand lower than 100 pick-ups in a year. Instead, relocate those bicycles to areas or neighborhoods with higher
 demand, especially during spring, summer, and fall. 

+ Create a point reward incentive for users that hit certain milestones every month, which could lead to discounts, and gifts from partnerships. 

 + Establish new membership plans focusing on tourists and casual riders during the warmer months. It could be short-term memberships or just weekend memberships.

+ If we run another analysis, including demographic aspects such as gender, age, and profession, Cyclistic could create a tailored marketing campaign to 
target those users and establish attractive partnerships with other brands that might resonate with the target audience. 



:top: [ Back to Summary](https://github.com/Hkarlis18/Divvy_Chicago_Google_Analytics_Capstone/new/main?readme=1#bike-summary)
