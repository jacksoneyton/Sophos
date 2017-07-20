SELECT Clients.name AS ClientName, computers.name AS ComputerName, 
CASE WHEN virusscanners.name LIKE '%sophos%' THEN 'Installed'
ELSE 'NOT Installed'
END AS SophosStatus 
FROM computers
JOIN virusscanners ON (virusscanners.VScanID = computers.virusscanner)
JOIN clients ON (clients.ClientID = Computers.ClientID)
WHERE computers.ClientID = 1
AND Computers.LastContact > DATE_SUB(NOW(),INTERVAL 30 DAY)
ORDER BY computers.name