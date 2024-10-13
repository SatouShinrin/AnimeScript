

Set WshShell = CreateObject("WScript.Shell")
strFilePath = WScript.Arguments(0)
WshShell.Run "C:\Tools\batch\Add_CRC.bat """ & strFilePath & """", 0, True
