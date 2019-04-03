SELECT * 
FROM   (WITH prod_every_month(prod, month, total_quant) 
             AS (SELECT prod, month, SUM(quant) 
                 FROM   sales 
                 GROUP  BY prod, month 
                 ORDER  BY prod, month), 
             prod_max(prod, max_q) 
             AS (SELECT prod, Max(total_quant) 
                 FROM   prod_every_month 
                 GROUP  BY prod 
                 ORDER  BY prod), 
             prod_month(prod, most_fav_month) 
             AS (SELECT prod_every_month.prod, prod_every_month.month 
                 FROM   prod_every_month, prod_max 
                 WHERE  prod_max.max_q = prod_every_month.total_quant) 
        SELECT * 
         FROM   prod_month) AS table_max 
        NATURAL join (WITH prod_every_month(prod, month, total_quant) 
                           AS (SELECT prod, month, SUM(quant) 
                               FROM   sales 
                               GROUP  BY prod, month 
                               ORDER  BY prod, month), 
                           prod_min(prod, min_q) 
                           AS (SELECT prod, Min(total_quant) 
                               FROM   prod_every_month 
                               GROUP  BY prod 
                               ORDER  BY prod), 
                           prod_month(prod, least_fav_month) 
                           AS (SELECT prod_every_month.prod, prod_every_month.month 
                               FROM   prod_every_month, prod_min 
                               WHERE  prod_min.min_q = prod_every_month.total_quant) 
                      SELECT * 
                       FROM   prod_month) AS table_min