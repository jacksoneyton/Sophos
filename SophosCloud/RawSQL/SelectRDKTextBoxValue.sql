SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(ControlProperties, '<Text>', -1), '</Text>', 1)
FROM plugin_labtech_rdk_controls
WHERE appid = (SELECT appID FROM plugin_labtech_rdk_applications WHERE NAME LIKE '%SophosCloud%AV%' AND Enabled = 1)
AND SUBSTRING_INDEX(SUBSTRING_INDEX(ControlProperties, '<Name>', -1), '</Name>', 1) LIKE '%SophosCloud_Login_Pass_Value%'
AND ControlType = 5