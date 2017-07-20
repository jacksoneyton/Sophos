SELECT Clients.name AS ClientName, computers.name AS ComputerName, 
CASE WHEN computers.virusscanner IN (SELECT virusscanners.vscanid
					FROM virusscanners
					WHERE virusscanners.name LIKE '%sophos%') THEN 'Installed'
	WHEN computers.computerid IN (SELECT extrafielddata.ID
					FROM extrafielddata
					WHERE extrafielddata.extrafieldid = (SELECT extrafield.id
										FROM extrafield
										WHERE extrafield.name LIKE 'Exclude%SophosCloud%deployment')
					AND extrafielddata.value = 1) THEN 'Excluded'
ELSE 'NOT Installed'
END AS SophosStatus 
FROM computers
JOIN clients ON (clients.ClientID = Computers.ClientID)
WHERE computers.ClientID = '%clientid%'
AND Computers.LastContact > DATE_SUB(NOW(),INTERVAL 30 DAY)
ORDER BY computers.name