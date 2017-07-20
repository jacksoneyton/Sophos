SELECT Clients.name AS 'Client Name', computers.name AS 'Computer Name', IFNULL(virusscanners.name,'AV Missing') AS 'Anti Virus',
CASE WHEN computers.computerid IN (SELECT extrafielddata.ID
					FROM extrafielddata
					WHERE extrafielddata.value = 1
					AND extrafielddata.extrafieldid = (SELECT extrafield.id
										FROM extrafield
										WHERE extrafield.name LIKE 'Exclude%SophosCloud%deployment')) THEN 'Exempt'

ELSE ''
END AS 'Exempt Status',
Computers.LastContact AS 'Last Contacted'
FROM computers
JOIN clients ON (clients.ClientID = Computers.ClientID)
LEFT JOIN virusscanners 
ON computers.virusscanner = virusscanners.vscanid
WHERE computers.clientid NOT IN ('201','268')
AND computers.clientid = '%clientid%'