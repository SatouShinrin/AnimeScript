

Set WshShell = CreateObject("WScript.Shell")
strFilePath = WScript.Arguments(0)
WshShell.Run "C:\Tools\batch\Create_Chapters.bat """ & strFilePath & """", 0, True
