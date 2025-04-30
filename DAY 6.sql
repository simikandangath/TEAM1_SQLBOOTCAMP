/* 
1.      Categorize products by stock status
(Display product_name, a new column stock_status whose values are based on below condition
 units_in_stock = 0  is 'Out of Stock'
       units_in_stock < 20  is 'Low Stock')
*/

SELECT 	product_name,
CASE
	WHEN units_in_stock = 0 THEN 'Out Of Stock'
	WHEN units_in_stock < 20 THEN 'Low Stock'
	ELSE 
		units_in_stock :: TEXT 
		end AS Stock_Status
from	public.products	
	
 
 /*
2.      Find All Products in Beverages Category
(Subquery, Display product_name,unitprice) */


SELECT product_name,unit_price
FROM PRODUCTS 
WHERE category_id = (SELECT category_id FROM public.categories WHERE category_name = 'Drinks')

 
/*
3.      Find Orders by Employee with Most Sales
(Display order_id,   order_date,  freight, employee_id.
Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. Use Subquery)
*/

SELECT  order_id,
		order_date,
		freight,
		employee_id
FROM	public.orders
WHERE	employee_id IN(SELECT employee_id 
					FROM 		public.orders 
			  		GROUP BY 	employee_id 
			  		ORDER BY	COUNT(order_id)	DESC
			  		LIMIT 	1
			 		 ) 




--4.Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. (Subquery, Try with ANY, ALL operators)
 
 -- USING ALL
 SELECT			* 
 FROM 			ORDERS	
 WHERE			freight > ALL(SELECT 
 										freight 
							  FROM 
							  			public.orders
							
							  where 
							  			ship_country  IN ('USA')
							  )


-- USING ANY
 SELECT			* 
 FROM 			ORDERS	
 WHERE			freight > ANY(SELECT 
 										freight 
							  FROM 
							  			public.orders
							
							  where 
							  			ship_country  IN ('USA')
							  )