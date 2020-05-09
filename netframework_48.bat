@echo off
WMIC OS GET Caption | FINDSTR /c:"Server" > NUL
IF %ERRORLEVEL% EQU 0 SET _OSVersion=Server && GOTO End
WMIC OS GET Caption | FINDSTR /c:"Server 2008 R2" > NUL
IF %ERRORLEVEL% EQU 0 SET _OSVersion=2008R2 && GOTO End
WMIC OS GET Caption | FINDSTR /c:"Server 2012" > NUL
IF %ERRORLEVEL% EQU 0 SET _OSVersion=2012 && GOTO End
WMIC OS GET Caption | FINDSTR /c:"Server 2016" > NUL
IF %ERRORLEVEL% EQU 0 SET _OSVersion=2016 && GOTO End
WMIC OS GET Caption | FINDSTR /c:"Server 2019" > NUL
IF %ERRORLEVEL% EQU 0 SET _OSVersion=2019 && GOTO End


reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319\SKUs\.NETFramework,Version=v4.8" 2>nul
if errorlevel 1 (
echo .NET Framework 4.8 is NOT installed

itops\scripts\netframework_48\setup.exe /q
 
) else goto End

:End
echo .NETFramework 4.8 is already installed or is not required for this system. 
TIMEOUT /T 3
exit