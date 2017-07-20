IF EXISTS (SELECT ExtraFieldData.Value
		FROM ExtraFieldData
		WHERE ExtraFieldData.ExtraFieldID = (SELECT ExtraField.ID
							FROM ExtraField
							WHERE ExtraField.name LIKE '%SophosCloud%x-api-key%')
		AND ExtraFieldData.ID = '%clientid%')
	UPDATE extrafielddata 
	SET ExtraFieldData.value = (SELECT plugin_labtech_rdk_controls_extra.Value
					FROM plugin_labtech_rdk_controls_extra 
					WHERE plugin_labtech_rdk_controls_extra.name LIKE 'Rapid Dev Kit_0_%clientid%_SophosCloud_x_api_key_Value_Text') 
	WHERE ExtraFieldData.ID = '%clientid%' 
	AND Extrafielddata.ExtraFieldID = (SELECT ExtraField.ID 
						FROM extrafield 
						WHERE extrafield.NAME LIKE '%SophosCloud%x-api-key%')
ELSE
	INSERT INTO extrafielddata VALUES('%clientid%', (SELECT extrafield.id FROM extrafield WHERE extrafield.name LIKE '%SophosCloud%x-api-key%'),(SELECT plugin_labtech_rdk_controls_extra.Value FROM plugin_labtech_rdk_controls_extra WHERE plugin_labtech_rdk_controls_extra.name LIKE 'Rapid Dev Kit_0_%clientid%_SophosCloud_x_api_key_Value_Text')); 
					
IF EXISTS (SELECT ExtraFieldData.Value
		FROM ExtraFieldData
		WHERE ExtraFieldData.ExtraFieldID = (SELECT ExtraField.ID
							FROM ExtraField
							WHERE ExtraField.name LIKE '%SophosCloud%Authorization%')
		AND ExtraFieldData.ID = '%clientid%')
	UPDATE extrafielddata 
	SET extrafielddata.value = (SELECT plugin_labtech_rdk_controls_extra.Value AS "Authorization" 
					FROM plugin_labtech_rdk_controls_extra 
					WHERE plugin_labtech_rdk_controls_extra.name LIKE 'Rapid Dev Kit_0_%clientid%_SophosCloud_Authorization_Value_Text') 
	WHERE ExtrafieldData.ID = '%clientid%' 
	AND ExtraFieldData.ExtraFieldID = (SELECT ExtraField.ID 
						FROM extrafield 
						WHERE extrafield.NAME LIKE '%SophosCloud%Authorization%')
ELSE
	INSERT INTO extrafielddata VALUES('%clientid%', (SELECT extrafield.id FROM extrafield WHERE extrafield.name LIKE '%SophosCloud%Authorization%'),(SELECT plugin_labtech_rdk_controls_extra.Value FROM plugin_labtech_rdk_controls_extra WHERE plugin_labtech_rdk_controls_extra.name LIKE 'Rapid Dev Kit_0_%clientid%_SophosCloud_Authorization_Value_Text')); 