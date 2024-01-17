WITH salesterritory AS (
    SELECT 
        c.customerid,
        c.territoryid,
        CONCAT(p.firstname, ' ', p.lastname) AS salespwesoninthisterritory
    FROM 
        sales.customer c
    JOIN 
        sales.salesperson sp 
	ON 
		c.territoryid = sp.territoryid
    JOIN 
        person.person p 
	ON 
		sp.businessentityid = p.businessentityid
)
SELECT 
    *
FROM 
    salesterritory;