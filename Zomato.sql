create database Zomato;
use Zomato;

alter table `zomato.country` rename Country;
alter table `zomato.currency` rename Currency;
alter table `zomato.proj` rename main;

select* from main;
select * from currency;
select * from country;

--  Build a Calendar Table using the Columns Datekey_Opening ( Which has Dates from Minimum Dates and Maximum Dates)
--   Add all the below Columns in the Calendar Table using the Formulas.
--    A.Year
--    B.Monthno
--    C.Monthfullname
--    D.Quarter(Q1,Q2,Q3,Q4)
--    E. YearMonth ( YYYY-MMM)
--    F. Weekdayno
--    G.Weekdayname
--    H.FinancialMOnth ( April = FM1, May= FM2  …. March = FM12)
--    I. Financial Quarter ( Quarters based on Financial Month FQ-1 . FQ-2..)

select Datekey_Opening, 
       Year(Datekey_Opening) as Year,
       month(Datekey_Opening) as Monthno,
       monthname(Datekey_Opening) as MonthName,
       concat('Q',quarter(Datekey_Opening)) as Quarter,
       concat(year(Datekey_Opening),"-",monthname(Datekey_Opening)) as years_month,
       weekday(Datekey_Opening) as Weekday,
       dayname(Datekey_Opening) as WeekDayName, 
       case when month(Datekey_Opening)>3 then month(Datekey_Opening)-3
            else month(Datekey_Opening)+9
            end as FinancialMonth,
       case when month(Datekey_Opening)<=3 then "Q4"
            when month(Datekey_Opening)<=6 then "Q1"
            when month(Datekey_Opening)<=9 then "Q2"
            Else "Q3" 
            End as FinancialQuarter
from main;

alter table `currency` rename column `USD Rate` to USD_Rate ;

-- Convert the Average cost for 2 column into USD dollars (currently the Average cost for 2 in local currencies

select m.*,c.*,(c.USD_Rate*m.average_cost_for_two) as currency
from main as m
join currency as c
on c.currency=m.currency;

-- Find the Numbers of Resturants based on City and Country.

Select * from main;
Select m.city as City, c.CountryName as Country, count(m.RestaurantID) as No_of_Restaurants
from main as m
join country as c
on c.CountryID=m.CountryCode
group by city, countryname;

-- Numbers of Resturants opening based on Year , Quarter , Month

select Year(Datekey_Opening) as Year,
       concat('Q',quarter(Datekey_Opening)) as Quarter,
       month(Datekey_Opening) as Monthno,
       count(RestaurantID) as No_of_restuarants
       from main
       group by 1,2,3 ;

-- Count of Resturants based on Average Ratings
  
select Round(Rating,0) as Rating,count(*) as count_of_Restaurants
from main
group by 1
order by 1;

-- Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets

select price_range,count(*) as count_of_Restaurants
from main 
group by 1;

-- Percentage of Resturants based on "Has_Table_booking"

select Has_Table_booking,count(Has_Table_booking)/(select count(*) from main) * 100 as percentage
from main 
group by Has_Table_booking;

-- Percentage of Resturants based on "Has_Online_delivery"
select Has_Online_delivery ,
       count(Has_Online_delivery)/(select count(*) from main) * 100 as percentage
from main
group by 1;

-- 2nd Highes restuarant by avg votes

select  Trim(RestaurantName) as Name,round(avg(votes),0) as totalvotes 
from main
group by 1
order by 2 desc
limit 1 offset 1;

select  Trim(RestaurantName) as Name,city,max(votes) as totalvotes 
from main
group by 1,2
order by 3 desc
limit 1 ;

	
      






  
       
       




