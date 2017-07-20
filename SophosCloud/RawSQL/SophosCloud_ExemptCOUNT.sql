SELECT COUNT(*)
FROM computers
WHERE clientid = '%clientid%'
AND computerid IN (SELECT extrafielddata.ID
					FROM extrafielddata
					WHERE extrafielddata.value = 1
					AND extrafielddata.extrafieldid = (SELECT extrafield.id
										FROM extrafield
										WHERE extrafield.name LIKE 'Exclude%SophosCloud%deployment'))