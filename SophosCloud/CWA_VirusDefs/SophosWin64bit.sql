
INSERT INTO `virusscanners` (`Name`,`DefLocation`,`DefFilename`,`ProgLocation`,`UpdateCMD`,`ScanTemplate`,`AutoProtect`,`OsType`,`VersionCheck`,`VersionMask`,`InfectionCheck`,`InfectionMatch`,`GUID`) Values('Sophos 64bit','%ProgramData%\\Sophos\\AutoUpdate\\data\\status\\sophosupdatestatus.xml','(.*)','{%-HKLM\\SOFTWARE\\wow6432node\\Sophos\\SAVService\\Application:Path-%}sav32cli.exe','\"{%-HKLM\\SOFTWARE\\wow6432node\\Sophos\\SAVService\\Application:Path-%}ALUpdate.exe\"','-nmbr %p','savservice*','5','','','','','089531f0-814c-41d1-9157-20944a691afc');
