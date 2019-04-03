SELECT Count(*)
FROM   sales;

SELECT *
FROM   sales;

SELECT cust,
       Min(quant)           AS MIN_Q,
       Max(quant)           AS MAX_Q,
       Round(Avg(quant), 2) AS AVG_Q
INTO   base
FROM   sales
GROUP  BY cust

SELECT *
FROM   base

SELECT *
FROM   (SELECT b.cust,
               b.min_q,
               s.prod                                                          AS min_prod,
               To_date(Concat(s.year, '/', s.month, '/', s.day), 'YYYY/MM/DD') AS MIN_DATE,
               s.state                                                         AS min_st
        FROM   base AS b,
               sales AS s
        WHERE  b.cust = s.cust
               AND b.min_q = s.quant) AS min_table
       natural JOIN (SELECT b.cust,
                            b.max_q,
                            s.prod                                                          AS max_prod,
                            To_date(Concat(s.year, '/', s.month, '/', s.day), 'YYYY/MM/DD') AS MAX_DATE,
                            s.state                                                         AS max_st,
					 		b.avg_q
                     FROM   base AS b,
                            sales AS s
                     WHERE  b.cust = s.cust
                            AND b.max_q = s.quant) AS max_table
