SELECT COUNT(virusscanners.name)
FROM computers
JOIN virusscanners ON (virusscanners.VScanID = computers.virusscanner)
JOIN clients ON (clients.ClientID = Computers.ClientID)
WHERE clients.ClientID = '%clientid%'
AND Computers.LastContact > DATE_SUB(NOW(),INTERVAL 30 DAY)
AND virusscanners.name NOT LIKE '%sophos%'
AND computers.computerid NOT IN (
	SELECT extrafielddata.id
	FROM extrafielddata
	WHERE extrafielddata.value = 1
	AND extrafielddata.extrafieldid = ( 
		SELECT extrafield.id
		FROM extrafield
		WHERE extrafield.name LIKE '%Exclude%SophosCloud%deployment%'))