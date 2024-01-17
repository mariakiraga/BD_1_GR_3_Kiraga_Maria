CREATE TEMPORARY TABLE TempEmployeeInfo AS
WITH employeepayhistory AS (
    SELECT 
        p.firstname AS imie,
        p.lastname AS nazwisko,
		p.businessentityid AS id,
        MAX(eph.rate) AS najwyzsza_placa
    FROM 
        humanresources.employee e
    JOIN 
        humanresources.employeepayhistory eph 
	ON 
		e.businessentityid = eph.businessentityid
    JOIN 
        person.person p 
	ON 
		e.businessentityid = p.businessentityid
    GROUP BY 
        p.businessentityid, p.firstname, p.lastname
)
SELECT 
    *
FROM 
    employeepayhistory;