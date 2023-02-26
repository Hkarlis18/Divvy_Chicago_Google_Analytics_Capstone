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



--Calculates the Average and Total Ride Lenght per Weekday and depending on the Member type 
Select member_type, no_weekday,
SUM (ride_length_min/60) AS TotalHour_Ride_Length,
ROUND (AVG (ride_length_min),2) AS AVG_Ride_Length
--MAX (ride_length_min) AS MAX_Ride_Length
FROM [dbo].[Divvy_Analysis]
GROUP BY member_type, no_weekday
ORDER BY no_weekday desc

--Calculates the Average and Total Ride Lenght per Weekday and depending on the Rideable Type 
Select rideable_type, no_weekday, 
ROUND (AVG (ride_length_min),2) AS AVG_Ride_Length
--ROUND (MAX (ride_length_min/60),2) AS MAX_Ride_Length
FROM [dbo].[Divvy_Analysis]
GROUP BY rideable_type, no_weekday
ORDER BY AVG_Ride_Length DESC


-- Calculates Total Hours Ride per Rideable Type  
SELECT  
SUM (CASE WHEN rideable_type = 'electric_bike' THEN (ride_length_min/60) END) as TotalHoursRideElectric,
SUM (CASE WHEN rideable_type  = 'classic_bike' THEN (ride_length_min/60) END) as TotalHoursRideClassic,
SUM (CASE WHEN rideable_type = 'docked_bike' THEN (ride_length_min/60) END ) as TotalHoursRideDocked
FROM [dbo].[Divvy_Analysis]

-- Calculates Total Hour Ride per Member Type 
SELECT  
SUM (CASE WHEN member_type = 'casual' THEN (ride_length_min/60) END) as TotalHourRideCasual,
SUM (CASE WHEN member_type  = 'member' THEN (ride_length_min/60) END) as TotalHourRideMember
FROM [dbo].[Divvy_Analysis]


--Number of Rides  by Weekday and Casual Bikers 
SELECT  no_weekday,
COUNT (CASE WHEN no_weekday = '1' AND member_type = 'casual' THEN  'Monday' END) as CasualRideMonday,
COUNT (CASE WHEN no_weekday = '2' AND member_type = 'casual' THEN  'Tuesday' END) as CasualRideTuesday,
COUNT (CASE WHEN no_weekday = '3' AND member_type = 'casual' THEN  'Wednesday' END) as CasualRideWednesday,
COUNT (CASE WHEN no_weekday = '4' AND member_type = 'casual' THEN  'Thursday' END) as CasualRideThursday,
COUNT (CASE WHEN no_weekday = '5' AND member_type = 'casual' THEN  'Friday' END) as CasualRideFriday,
COUNT (CASE WHEN no_weekday = '6' AND member_type = 'casual' THEN  'Saturday' END) as CasualRideSaturday,
COUNT (CASE WHEN no_weekday = '7' AND member_type = 'casual' THEN  'Sunday' END) as CasualRideSunday
FROM [dbo].[Divvy_Analysis]
GROUP BY no_weekday
ORDER BY no_weekday ASC

--Number of Rides  by Weekday and Member Bikers
SELECT no_weekday,
COUNT (CASE WHEN no_weekday = '1' AND member_type = 'member' THEN  'Monday' END) as MemberRideMonday,
COUNT (CASE WHEN no_weekday = '2' AND member_type = 'member' THEN  'Tuesday' END) as MemberRideTuesday,
COUNT (CASE WHEN no_weekday = '3' AND member_type = 'member' THEN  'Wednesday' END) as MemberRideWednesday,
COUNT (CASE WHEN no_weekday = '4' AND member_type = 'member' THEN  'Thursday' END) as MemberRideThursday,
COUNT (CASE WHEN no_weekday = '5' AND member_type = 'member' THEN  'Friday' END) as MemberRideFriday,
COUNT (CASE WHEN no_weekday = '6' AND member_type = 'member' THEN  'Saturday' END) as MemberRideSaturday,
COUNT (CASE WHEN no_weekday = '7' AND member_type = 'member' THEN  'Sunday' END) as MemberRideSunday
FROM [dbo].[Divvy_Analysis]
GROUP BY no_weekday
ORDER BY no_weekday ASC

--Total Rides per Member Type and Time of the day
  WITH  buckets (s,e,n) AS
    (
      SELECT  s,e,n  FROM (VALUES
       ('00:00:00', '12:59:59', 'MorningRides'),
       ('13:00:00', '17:59:59', 'AfterNoonRides'),
       ('18:00:00' , '21:59:59', 'EveningRides'),
       ('21:59:59', '23:59:59', 'NightRides')
      ) AS v(s,e,n)
    ),
    sdc AS
    (
      SELECT member_type, n = COALESCE(b.n, 'Other') 
        FROM [dbo].[Divvy_Analysis] AS d
        LEFT OUTER JOIN buckets AS b
        ON CONVERT(time(2), d.started_at) BETWEEN b.s AND b.e
    )
    SELECT * FROM sdc
    PIVOT
    (
      COUNT(n) FOR n IN 
      (
        [MorningRides],[AfternoonRides],
        [EveningRides],[NightRides]
      )
    ) AS p;


	--Total Rides per Month for Casual Members
SELECT  ride_month, 
COUNT (CASE WHEN ride_month = '1' AND member_type = 'casual' THEN  'January' END) as RidesCasualJanurary,
COUNT (CASE WHEN ride_month = '2' AND member_type = 'casual' THEN  'February' END) as RidesCasualFebruary,
COUNT (CASE WHEN ride_month = '3' AND member_type = 'casual' THEN  'March' END) as RidesCasualMarch,
COUNT (CASE WHEN ride_month = '4' AND member_type = 'casual' THEN  'April' END) as RidesCasualApril,
COUNT (CASE WHEN ride_month = '5'AND member_type = 'casual' THEN  'May' END) as RidesCasualMay,
COUNT (CASE WHEN ride_month = '6'AND member_type = 'casual' THEN  'June' END) as RidesCasualJune,
COUNT (CASE WHEN ride_month = '7'AND member_type = 'casual' THEN  'July' END) as RidesCasualJuly,
COUNT (CASE WHEN ride_month = '8'AND member_type = 'casual' THEN  'August' END) as RidesCasualAugust,
COUNT (CASE WHEN ride_month = '9'AND member_type = 'casual' THEN  'September' END) as RidesCasualSeptember,
COUNT (CASE WHEN ride_month = '10'AND member_type = 'casual' THEN  'October' END) as RidesCasualOctober,
COUNT (CASE WHEN ride_month = '11'AND member_type = 'casual' THEN  'November' END) as RidesCasualNovember,
COUNT (CASE WHEN ride_month = '12'AND member_type = 'casual' THEN  'December' END) as RidesCasualDecember
FROM [dbo].[Divvy_Analysis]
GROUP BY ride_month 
ORDER BY ride_month  ASC

--Total Rides per Month for Members 
SELECT ride_month, 
	COUNT (CASE WHEN ride_month = '1'AND member_type = 'member' THEN  'January' END) as RidesMemberJanurary,
	COUNT (CASE WHEN ride_month = '2'AND member_type = 'member' THEN  'February' END) as RidesMemberFebruary,
	COUNT (CASE WHEN ride_month = '3'AND member_type = 'member' THEN  'March' END) as RidesMemberMarch,
	COUNT (CASE WHEN ride_month = '4'AND member_type = 'member' THEN  'April' END) as RidesMemberApril,
	COUNT (CASE WHEN ride_month = '5'AND member_type = 'member' THEN  'May' END) as RidesMemberMay,
	COUNT (CASE WHEN ride_month = '6'AND member_type = 'member' THEN  'June' END) as RidesMemberJune,
	COUNT (CASE WHEN ride_month = '7'AND member_type = 'member' THEN  'July' END) as RidesMemberJuly,
	COUNT (CASE WHEN ride_month = '8'AND member_type = 'member' THEN  'August' END) as RidesMemberAugust,
	COUNT (CASE WHEN ride_month = '9'AND member_type = 'member' THEN  'September' END) as RidesMemberSeptember,
	COUNT (CASE WHEN ride_month = '10'AND member_type = 'member' THEN  'October' END) as RidesMemberOctober,
	COUNT (CASE WHEN ride_month = '11'AND member_type = 'member' THEN  'November' END) as RidesMemberNovember,
	COUNT (CASE WHEN ride_month = '12'AND member_type = 'member' THEN  'December' END) as RidesMemberDecember
FROM [dbo].[Divvy_Analysis]
GROUP BY ride_month 
ORDER BY ride_month  ASC

-- Top 5 Station Names
SELECT TOP 5 start_station_name,
  COUNT(start_station_name) AS MostFrequent
   FROM [dbo].[Divvy_Analysis]
  WHERE start_station_name IS NOT NULL
  GROUP BY start_station_name
  ORDER BY MostFrequent DESC
 
 
-- Top 5 Stations Less frequent 
SELECT top 5 start_station_name,
  COUNT(start_station_name) AS LessFrequent
 FROM [dbo].[Divvy_Analysis]
  WHERE start_station_name IS NOT NULL
  GROUP BY start_station_name
  ORDER BY LessFrequent ASC
 
 -- Most Popular Bikes
 Select
COUNT(CASE WHEN rideable_type = 'electric_bike' THEN 'ElectricFrequency' END) as TotalElectric,
COUNT (CASE WHEN rideable_type  = 'classic_bike' THEN 'ClassicFrequency' END) as TotalClassic,
COUNT (CASE WHEN rideable_type = 'docked_bike' THEN 'DockedFrequency' END ) as TotalRideDocked
FROM [dbo].[Divvy_Analysis]


