SELECT COUNT(*)
FROM computers
WHERE clientid = '%clientid%'
AND virusscanner NOT IN (SELECT vscanid FROM virusscanners WHERE NAME LIKE '%sophos%')
AND computerid NOT IN (SELECT extrafielddata.ID
					FROM extrafielddata
					WHERE extrafielddata.value = 1
					AND extrafielddata.extrafieldid = (SELECT extrafield.id
										FROM extrafield
										WHERE extrafield.name LIKE 'Exclude%SophosCloud%deployment'))