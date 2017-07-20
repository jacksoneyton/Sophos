SELECT clients.name, computers.name
FROM computers
JOIN clients ON (computers.clientid = clients.clientid)
WHERE computers.virusscanner NOT IN (
	SELECT virusscanners.VScanID 
	FROM virusscanners 
	WHERE virusscanners.name NOT LIKE '%sophos%')
AND clients.clientid IN (
	SELECT extrafielddata.id 
	FROM extrafielddata 
	WHERE extrafielddata.extrafieldid = (
		SELECT extrafield.id 
		FROM extrafield 
		WHERE extrafield.name = 'Enable SophosCloud Deployment') 
	AND extrafielddata.value = '1') 
AND clients.clientid IN (
	SELECT extrafielddata.id 
	FROM extrafielddata 
	WHERE extrafielddata.extrafieldid = (
		SELECT extrafield.id 
		FROM extrafield 
		WHERE extrafield.name = 'SophosCloud Onboarding Complete') 
	AND extrafielddata.value = '1') 
AND computers.computerid NOT IN (
	SELECT extrafielddata.id 
	FROM extrafielddata 
	WHERE extrafielddata.value = '1' 
	AND extrafielddata.extrafieldid = (
		SELECT extrafield.id 
		FROM extrafield 
		WHERE extrafield.name 
		LIKE '%Exclude%SophosCloud%deployment%'))