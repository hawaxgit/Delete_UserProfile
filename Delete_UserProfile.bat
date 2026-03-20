@echo off
:: ============================================================
::  Author  : Soroush Tavanaei
::  Dept.   : IT/OT Allrounder
::  Version : 2.0
::  Created : 16.12.2025
::  Updated : 19.03.2026
::  Purpose : Deletes a local user account from this system.
::            Must be run with Administrator privileges.
:: ============================================================

setlocal EnableDelayedExpansion
title IT Tools - User Profile Deletion v3.0

:START
cls
echo.
echo  ============================================================
echo   Author  : Soroush Tavanaei
echo   Dept.   : IT/OT Allrounder
echo   Version : 2.0
echo   Purpose : Local User Account Deletion Tool
echo   NOTE    : Must be run with Administrator privileges.
echo  ============================================================
echo.

:: Admin-Check
net session >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo  [FEHLER] Administratorrechte erforderlich!
    echo  Bitte Rechtsklick auf die Datei und "Als Administrator ausfuehren".
    echo.
    pause
    exit /b 1
)

echo  [OK] Administratorrechte erkannt.
echo.
echo  ============================================================
echo   Verfuegbare Benutzerprofile in C:\Users
echo  ============================================================
echo.

:: Benutzerordner aus C:\Users auflisten (nur echte Ordner, keine System-Ordner)
set COUNT=0
for /D %%D in (C:\Users\*) do (
    set "FOLDER=%%~nxD"
    :: System-Ordner ueberspringen
    if /I NOT "!FOLDER!"=="Public" (
    if /I NOT "!FOLDER!"=="Default" (
    if /I NOT "!FOLDER!"=="Default User" (
    if /I NOT "!FOLDER!"=="All Users" (
        set /A COUNT+=1
        set "USER_!COUNT!=!FOLDER!"
        echo    [!COUNT!]  !FOLDER!
    ))))
)

echo.
if %COUNT%==0 (
    echo  Keine Benutzerprofile gefunden.
    pause
    exit /b 0
)

echo  ============================================================
echo.
set /P CHOICE=  Nummer des zu loeschenden Benutzers eingeben (oder 0 zum Beenden): 

:: Beenden wenn 0
if "!CHOICE!"=="0" goto :BEENDEN

:: Eingabe pruefen - muss eine Zahl zwischen 1 und COUNT sein
set "VALID=0"
for /L %%i in (1,1,%COUNT%) do (
    if "!CHOICE!"=="%%i" set "VALID=1"
)

if "!VALID!"=="0" (
    echo.
    echo  [!] Ungueltige Eingabe. Bitte eine Zahl zwischen 1 und %COUNT% eingeben.
    echo.
    pause
    goto :START
)

set "TARGET_USER=!USER_%CHOICE%!"

echo.
echo  ============================================================
echo   BESTAETIGUNG
echo  ============================================================
echo.
echo   Ausgewaehlter Benutzer : !TARGET_USER!
echo   Profilpfad             : C:\Users\!TARGET_USER!
echo.
echo  [WARNUNG] Das lokale Konto und das Profil werden geloescht.
echo            Dieser Vorgang kann nicht rueckgaengig gemacht werden!
echo.
set /P CONFIRM=  Zum Bestaetigen JA eingeben: 

if /I NOT "!CONFIRM!"=="JA" (
    echo.
    echo  [--] Abgebrochen. Keine Aenderungen vorgenommen.
    echo.
    pause
    goto :START
)

:: Benutzerkonto loeschen
echo.
echo  Loesche Benutzerkonto: !TARGET_USER! ...
net user "!TARGET_USER!" /DELETE >nul 2>&1
set "NET_ERR=!ERRORLEVEL!"

:: Profil-Ordner loeschen
echo  Loesche Profilordner: C:\Users\!TARGET_USER! ...
rd /S /Q "C:\Users\!TARGET_USER!" >nul 2>&1

:: Ergebnis
echo.
if "!NET_ERR!"=="0" (
    echo  ============================================================
    echo   [ERFOLG] Benutzer "!TARGET_USER!" wurde erfolgreich geloescht.
    echo  ============================================================
    call :LOG "ERFOLG" "!TARGET_USER!"
) else (
    echo  ============================================================
    echo   [FEHLER] Konto "!TARGET_USER!" konnte nicht geloescht werden.
    echo           Moeglicherweise ist der Benutzer kein lokales Konto
    echo           oder er ist aktuell angemeldet.
    echo  ============================================================
    call :LOG "FEHLER" "!TARGET_USER!"
)

echo.
set /P WIEDER=  Weiteren Benutzer loeschen? (J/N): 
if /I "!WIEDER!"=="J" goto :START

:BEENDEN
echo.
echo  IT OPS Tool wird beendet. Auf Wiedersehen.
echo.
pause
endlocal
exit /b 0


:: ============================================================
:LOG
set "LOG_FILE=%~dp0UserDeletion_Log.txt"
echo [%DATE% %TIME%] [%~1] Host: %COMPUTERNAME% - Operator: %USERNAME% - Benutzer: %~2 >> "!LOG_FILE!"
echo  [LOG] Eintrag gespeichert in: UserDeletion_Log.txt
goto :EOF
