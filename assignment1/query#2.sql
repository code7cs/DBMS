SELECT * FROM (
WITH month_table(month, prod, total_q)
     AS (SELECT month,
                prod,
                Sum(quant)
         FROM   sales
         GROUP  BY month,
                   prod
         ORDER  BY month),
     pop_total(month, most_pop_total_q)
     AS (SELECT month,
                Max(total_q) AS most_pop_total_q
         FROM   month_table
         GROUP  BY month
         ORDER  BY month)
SELECT *
FROM   pop_total
       natural JOIN(SELECT pop_total.month,
                           month_table.prod AS most_pop_prod,
                           pop_total.most_pop_total_q
                    FROM   pop_total,
                           month_table
                    WHERE  pop_total.most_pop_total_q = month_table.total_q) AS pop_prod
) AS table_pop

natural JOIN

(
WITH month_table(month, prod, total_q)
     AS (SELECT month,
                prod,
                Sum(quant)
         FROM   sales
         GROUP  BY month,
                   prod
         ORDER  BY month),
     pop_total(month, least_pop_total_q)
     AS (SELECT month,
                Min(total_q) AS least_pop_total_q
         FROM   month_table
         GROUP  BY month
         ORDER  BY month)
SELECT * FROM pop_total
natural JOIN(SELECT pop_total.month,
                           month_table.prod AS least_pop_prod,
                           pop_total.least_pop_total_q
                    FROM   pop_total,
                           month_table
                    WHERE  pop_total.least_pop_total_q = month_table.total_q) AS least_prod
) AS table_least
