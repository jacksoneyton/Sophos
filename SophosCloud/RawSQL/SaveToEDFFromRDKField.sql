UPDATE extrafielddata SET VALUE= (SELECT VALUE FROM plugin_labtech_rdk_controls_extra WHERE NAME LIKE 'Rapid Dev Kit_0_%clientid%_SophosCloud_Login_Address_Value_Text') 
WHERE ID = '%clientid%' AND ExtraFieldID = (SELECT ExtraField.ID FROM extrafield WHERE extrafield.NAME LIKE '%SophosCloud%Login%Address%')

UPDATE extrafielddata SET VALUE= (SELECT VALUE FROM plugin_labtech_rdk_controls_extra WHERE NAME LIKE 'Rapid Dev Kit_0_%clientid%_SophosCloud_Login_Pass_Value_Text') 
WHERE ID = '%clientid%' AND ExtraFieldID = (SELECT ExtraField.ID FROM extrafield WHERE extrafield.NAME LIKE '%SophosCloud%Login%Pass%')