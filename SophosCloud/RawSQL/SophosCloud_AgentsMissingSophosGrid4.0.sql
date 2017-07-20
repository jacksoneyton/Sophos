SELECT computers.name AS 'Computer Name', IFNULL(virusscanners.name,'AV Missing') AS 'Anti Virus',
CASE WHEN computers.computerid IN (SELECT extrafielddata.ID
				FROM extrafielddata
				WHERE extrafielddata.value = 1
				AND extrafielddata.extrafieldid = (SELECT extrafield.id
									FROM extrafield
									WHERE extrafield.name LIKE 'Exclude%SophosCloud%deployment')) THEN 'Exempt'
ELSE ''
END AS 'Exempt Status',
CASE WHEN computers.computerid IN (SELECT services.computerid
				FROM services
				WHERE services.name LIKE '%hmpalertsvc%'
				AND services.State = 'Running')
			THEN 'Installed'
WHEN computers.computerid IN (SELECT services.computerid
				FROM services
				WHERE services.name LIKE '%hmpalertsvc%'
				AND services.State != 'Running')
			THEN 'Not Running'
ELSE 'Missing'
END AS 'InterceptX',
Computers.LastContact AS 'Last Contacted'
FROM computers
LEFT JOIN virusscanners 
ON computers.virusscanner = virusscanners.vscanid
WHERE computers.clientid NOT IN ('201','268')
AND computers.clientid = '%clientid%'