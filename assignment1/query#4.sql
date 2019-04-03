	DROP VIEW Q1, Q2, Q3, Q4, four_avg

	create view Q1 as (
	select cust, prod, month, quant
	from sales
	where month = 1 or month = 2 or month = 3)

	create view Q2 as (
	select cust, prod, month, quant
	from sales
	where month = 4 or month = 5 or month = 6)

	create view Q3 as (
	select cust, prod, month, quant
	from sales
	where month = 7 or month = 8 or month = 9)

	create view Q4 as (
	select cust, prod, month, quant
	from sales
	where month = 10 or month = 11 or month = 12)
	-------------------------------------------------------------
	create view four_avg as (
	select * from 
	(select cust, prod, Round(avg(quant)) as q1_avg
	from Q1
	group by cust, prod) as q1_avg
	natural full outer join
	(
	select cust, prod, Round(avg(quant)) as q2_avg
	from Q2
	group by cust, prod) as q2_avg
	natural full outer join
	(
	select cust, prod, Round(avg(quant)) as q3_avg
	from Q3
	group by cust, prod
	order by cust, prod) as q3_avg
	natural full outer join
	(
	select cust, prod, Round(avg(quant)) as q4_avg
	from Q4
	group by cust, prod
	order by cust, prod) as q4_avgc
	)
	-------------------------------------------------------------
	select * from (
	select * from four_avg
	order by cust, prod
	) as table_four_avg
	natural join (
	select cust, prod, round(avg(quant)), sum(quant), count(quant)
	from sales
	group by cust, prod
	order by cust, prod) as table_other
